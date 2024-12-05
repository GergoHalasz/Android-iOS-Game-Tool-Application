import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppInitWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;

  const RateAppInitWidget({Key? key, required this.builder}) : super(key: key);

  @override
  State<RateAppInitWidget> createState() => _RateAppInitWidgetState();
}

class _RateAppInitWidgetState extends State<RateAppInitWidget> {
  RateMyApp? rateMyApp;

  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
          appStoreIdentifier: "1593368066",
          googlePlayIdentifier: "com.gergo.asdlol",
          minLaunches: 2,
          minDays: 0,
          remindDays: 1,
          remindLaunches: 1),
      onInitialized: (context, rateMyApp) {
        setState(() {
          this.rateMyApp = rateMyApp;
        });

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(context);
        }
      },
      builder: (context) => rateMyApp == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : widget.builder(rateMyApp!),
    );
  }
}
