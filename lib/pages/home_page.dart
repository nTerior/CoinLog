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
    return Stack(
      fit: StackFit.passthrough,
      children: [
        const BackgroundImage(
          image: AssetImage(Assets.assetsBackground),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
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
                    SizedBox(height: Layout.padding * 2),
                    TransactionHistory(),
                    SizedBox(height: Layout.padding),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
