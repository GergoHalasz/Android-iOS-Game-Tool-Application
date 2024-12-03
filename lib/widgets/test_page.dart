import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class TestPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const TestPage({Key? key, required this.rateMyApp}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => widget.rateMyApp.showRateDialog(context),
        child: Text('asd'),
      ),
    );
  }
}
