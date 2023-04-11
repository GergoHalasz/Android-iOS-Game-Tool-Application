import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);

    late PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration('goog_ORDoTnQCskoxBeCayVnpnAbFORY');
    } else if (Platform.isIOS) {
      configuration =
          PurchasesConfiguration('appl_OFAINueZVlSYxIuLShwHKRDIHYb');
    }
    await Purchases.configure(configuration);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }
}
