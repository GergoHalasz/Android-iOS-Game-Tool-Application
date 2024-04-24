import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future init() async {
    final apiKey = Platform.isIOS
        ? 'appl_OFAINueZVlSYxIuLShwHKRDIHYb'
        : 'goog_ORDoTnQCskoxBeCayVnpnAbFORY';

    await Purchases.setDebugLogsEnabled(true);
    PurchasesConfiguration configuration = PurchasesConfiguration(apiKey);

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
