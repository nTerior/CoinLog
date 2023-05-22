import 'package:coin_log/widgets/background_image.dart';
import 'package:coin_log/widgets/balance_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Stack(
        fit: StackFit.passthrough,
        children: [
          BackgroundImage(
            image: NetworkImage("https://picsum.photos/1000/3000"),
          ),
          BalanceInfo(),
        ],
      ),
      bottomSheet: BottomSheet(
        showDragHandle: true,
        onClosing: () {},
        builder: (context) => SizedBox(
          height: 100,
        ),
      ),
    );
  }
}
