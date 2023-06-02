import 'dart:convert';
import 'dart:io';

import 'package:coin_log/finance/finance.dart';
import 'package:coin_log/finance/transaction.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/morphism/glass_morphism.dart';
import 'package:coin_log/receipt/receipt.dart';
import 'package:coin_log/widgets/grid_buttons.dart';
import 'package:coin_log/widgets/receipt_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

const _ocrServer = "ocr.asprise.com";
const _ocrBackupServer = "ocr2.asprise.com";

const _url = "https://$_ocrServer/api/v1/receipt";
const _backupUrl = "https://$_ocrBackupServer/api/v1/receipt";

Future<bool> _canConnectToServer(String host) async {
  try {
    final result = await InternetAddress.lookup(host);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

Future<String?> getWorkingReceiptScannerUrl() async {
  if (await _canConnectToServer(_ocrServer)) {
    return _url;
  } else if (await _canConnectToServer(_ocrBackupServer)) {
    return _backupUrl;
  }
  return null;
}

Future<MultipartRequest> buildRequest(String uri, String imagePath) async {
  return MultipartRequest("POST", Uri.parse(uri))
    ..fields["api_key"] = "TEST"
    ..fields["recognizer"] = "DE"
    ..files.add(await MultipartFile.fromPath("file", imagePath));
}

Future<Response> _getResponse(MultipartRequest request) async {
  return Response.fromStream(await request.send());
}

class ReceiptScannerPage extends StatefulWidget {
  final MultipartRequest request;

  const ReceiptScannerPage({Key? key, required this.request}) : super(key: key);

  @override
  State<ReceiptScannerPage> createState() => _ReceiptScannerPageState();
}

class _ReceiptScannerPageState extends State<ReceiptScannerPage> {
  late Future<Response> _data;

  @override
  void initState() {
    _data = _getResponse(widget.request);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      bottomBorderWidth: 0,
      topBorderWidth: 0,
      leftBorderWidth: 0,
      rightBorderWidth: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text(
            "Receipt Scanner",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w100,
                ),
          ),
        ),
        body: Padding(
          padding: Layout.padding.hPad,
          child: Center(
            child: FutureBuilder<Response>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return const Text("Something went wrong.");
                }
                if (!jsonDecode(snapshot.data!.body)["success"]) {
                  return Text(jsonDecode(snapshot.data!.body)["message"]);
                }
                return _ReceiptDetails(response: snapshot.data!);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ReceiptDetails extends StatelessWidget {
  final Response response;

  @override
  Widget build(BuildContext context) {
    final receipt = Receipt.fromJson(jsonDecode(response.body)["receipts"][0]);
    receipt.merchant_name ??= "Shop";

    DateTime date =
        receipt.date != null ? DateTime.parse(receipt.date!) : DateTime.now();

    if (receipt.time != null) {
      final time = receipt.time!.split(":");
      date = date.copyWith(
        hour: int.parse(time[0]),
        minute: int.parse(time[1]),
      );
    } else {
      final time = DateTime.now();
      date = date.copyWith(
        hour: time.hour,
        minute: time.minute,
      );
    }

    final transaction = Transaction()
      ..amount = -receipt.total!
      ..title = receipt.merchant_name!
      ..dateTime = date;

    final children = [
      Text(
        "Details",
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w100,
            ),
      ),
      GlassMorphism(
        padding: Layout.padding.pad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    receipt.merchant_name!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: Layout.padding),
                Text(
                  receipt.total!.asCurrency("€"),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              date.formatDateTime,
              style: const TextStyle(
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: Layout.padding),
      // ToDo: add edit button
      Row(
        children: [
          const Spacer(),
          SizedBox(
            width: 100,
            child: GridButton(
              text: "Save",
              icon: Symbols.save,
              onTap: () {
                Provider.of<Finance>(context, listen: false).add(transaction);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: Layout.padding),
      Text(
        "Items",
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w100,
            ),
      ),
      Expanded(
        child: GlassMorphism(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: Layout.padding.pad,
              child: ReceiptItemWidget(item: receipt.items![index]),
            ),
            itemCount: receipt.items!.length,
          ),
        ),
      ),
      const SizedBox(height: Layout.padding),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  const _ReceiptDetails({Key? key, required this.response}) : super(key: key);
}
