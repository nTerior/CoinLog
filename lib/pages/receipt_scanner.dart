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
  //return Response.fromStream(await request.send());
  return Response(r'''{
  "request_id" : "P_218.186.139.27_kl96a7ie_o9k",
  "ref_no" : "AspDemo_1613550458205_154",
  "file_name" : "SG-01s.jpg",
  "request_received_on" : 1613550460551,
  "success" : true,
  "image_width" : 1200,
  "image_height" : 1600,
  "image_rotation" : -0.006,
  "recognition_completed_on" : 1613550461387,
  "receipts" : [ {
    "merchant_name" : "McDonald's",
    "merchant_address" : "600 @ Toa Payoh #01-02, Singapore 319515",
    "merchant_phone" : "62596362",
    "merchant_website" : null,
    "merchant_tax_reg_no" : "M2-0023981-4",
    "merchant_company_reg_no" : null,
    "merchant_logo" : "/ocr/api/img/demo/logos/mcd.jpg",
    "region" : null,
    "mall" : "600 @ Toa Payoh",
    "country" : "SG",
    "receipt_no" : "002201330026",
    "date" : "2016-10-10",
    "time" : "15:49",
    "items" : [ {
      "amount" : 2.95,
      "description" : "Med Ice Lemon Tea",
      "flags" : "",
      "qty" : 1,
      "remarks" : null,
      "unitPrice" : null
    }, {
      "amount" : 2.40,
      "description" : "Coffee with Milk",
      "flags" : "",
      "qty" : 1,
      "remarks" : null,
      "unitPrice" : null
    } ],
    "currency" : "SGD",
    "total" : 5.35,
    "subtotal" : null,
    "tax" : 0.35,
    "service_charge" : null,
    "tip" : null,
    "payment_method" : "cash",
    "payment_details" : null,
    "credit_card_type" : null,
    "credit_card_number" : null,
    "ocr_text" : "         McDonald's Toa Payoh Central\n            600 @ Toa Payoh #01-02,\n              Singapore 319515\n                Tel: 62596362\n       McDonald's Restaurants Pte Ltd\n          GST REGN NO : M2-0023981-4\n                 TAX INVOICE\n   INV# 002201330026\n  ORD $57 -REG # 1 - 13/01/2016 15:49:52\n  QTY ITEM                            TOTAL\n    1 Med Ice Lemon Tea                2.95\n    1 Coffee with Milk                 2.40\n Eat- In Total (incl GST)              5.35\n Cash Tendered                         10.00\n Change                                 4.65\n TOTAL INCLUDES GST OF                  0.35\n     Thank You and Have A Nice Day",
    "ocr_confidence" : 96.60,
    "width" : 954,
    "height" : 1170,
    "avg_char_width" : null,
    "avg_line_height" : null,
    "source_locations" : {
      "date" : [ [ { "y" : 684, "x" : 500 }, { "y" : 681, "x" : 965 }, { "y" : 747, "x" : 966 }, { "y" : 750, "x" : 501 } ] ],
      "total" : [ [ { "y" : 957, "x" : 936 }, { "y" : 957, "x" : 1041 }, { "y" : 1012, "x" : 1041 }, { "y" : 1012, "x" : 936 } ] ],
      "receipt_no" : [ [ { "y" : 588, "x" : 246 }, { "y" : 587, "x" : 528 }, { "y" : 645, "x" : 528 }, { "y" : 646, "x" : 246 } ] ],
      "doc" : [ [ { "y" : 163, "x" : 44 }, { "y" : 157, "x" : 1094 }, { "y" : 1444, "x" : 1102 }, { "y" : 1450, "x" : 52 } ] ],
      "merchant_name" : [ [ { "y" : 223, "x" : 254 }, { "y" : 215, "x" : 876 }, { "y" : 260, "x" : 877 }, { "y" : 269, "x" : 255 } ] ],
      "tax" : [ [ { "y" : 1200, "x" : 949 }, { "y" : 1201, "x" : 1057 }, { "y" : 1258, "x" : 1056 }, { "y" : 1257, "x" : 948 } ] ],
      "merchant_address" : [ [ { "y" : 262, "x" : 318 }, { "y" : 261, "x" : 832 }, { "y" : 309, "x" : 832 }, { "y" : 309, "x" : 318 } ], [ { "y" : 308, "x" : 383 }, { "y" : 304, "x" : 768 }, { "y" : 356, "x" : 769 }, { "y" : 361, "x" : 384 } ] ],
      "merchant_phone" : [ [ { "y" : 354, "x" : 539 }, { "y" : 354, "x" : 719 }, { "y" : 396, "x" : 719 }, { "y" : 397, "x" : 539 } ] ],
      "merchant_tax_reg_no" : [ [ { "y" : 444, "x" : 574 }, { "y" : 438, "x" : 856 }, { "y" : 482, "x" : 857 }, { "y" : 488, "x" : 575 } ] ]
    }
  } ]
}''', 200);
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
                  return const CircularProgressIndicator();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  receipt.merchant_name!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
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
