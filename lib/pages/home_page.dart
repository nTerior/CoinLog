import 'package:coin_log/layout.dart';
import 'package:coin_log/widgets/background_image.dart';
import 'package:coin_log/widgets/balance_info.dart';
import 'package:coin_log/widgets/grid_buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          const BackgroundImage(
            image: NetworkImage("https://picsum.photos/1000/3000"),
          ),
          SafeArea(
            child: Padding(
              padding: Layout.padding.hPad,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceInfo(),
                  SizedBox(height: Layout.padding),
                  GridButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
