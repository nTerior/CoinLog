import 'package:coin_log/generated/assets.dart';
import 'package:coin_log/layout.dart';
import 'package:coin_log/widgets/background_image.dart';
import 'package:coin_log/widgets/balance_info.dart';
import 'package:coin_log/widgets/grid_buttons.dart';
import 'package:coin_log/widgets/transaction_history.dart';
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
            image: AssetImage(Assets.assetsBackground),
          ),
          SafeArea(
            child: Padding(
              padding: Layout.padding.hPad,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return false;
                },
                child: ListView(
                  children: const [
                    SizedBox(height: Layout.padding),
                    BalanceInfo(),
                    SizedBox(height: Layout.padding),
                    GridButtons(),
                    TransactionHistory(),
                    SizedBox(height: Layout.padding),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
