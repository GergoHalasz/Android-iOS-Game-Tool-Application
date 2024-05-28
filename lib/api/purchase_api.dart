import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future init() async {
    final apiKey = Platform.isIOS
        ? 'appl_OFAINueZVlSYxIuLShwHKRDIHYb'
        : 'amzn_EqmoAZFdpGyokTlaAWqXtQZHvsJ';

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(apiKey);
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
