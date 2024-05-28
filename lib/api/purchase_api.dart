import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);

    late PurchasesConfiguration configuration;
    final apiKey = Platform.isIOS
        ? 'appl_OFAINueZVlSYxIuLShwHKRDIHYb'
        : 'amzn_EqmoAZFdpGyokTlaAWqXtQZHvsJ';

    if (Platform.isAndroid) {
      configuration = AmazonConfiguration(apiKey);
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration(apiKey);
    }
    await Purchases.configure(configuration);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on PlatformException {
      return [];
    }
  }
}
