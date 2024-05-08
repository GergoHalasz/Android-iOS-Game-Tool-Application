import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:wowtalentcalculator/ad_manager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdState extends ChangeNotifier {
  int interstitialAdCounter = 0;
  Map<String, bool> placements = {
    AdManager.interstitialVideoAdPlacementId: false,
    AdManager.rewardedVideoAdPlacementId: false,
  };

  AdState() {
    UnityAds.init(
      gameId: AdManager.gameId,
      testMode: true,
      onComplete: () {
        print('Initialization Complete');
        _loadAds();
      },
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
  Purchases.addPurchaserInfoUpdateListener(
        (purchaserInfo) => {updatePurchaseStatus()});
    checkIsAdFreeversion();
  }

  void _loadAds() {
    for (var placementId in placements.keys) {
      _loadAd(placementId);
    }
  }

  void _loadAd(String placementId) {
    UnityAds.load(
      placementId: placementId,
      onComplete: (placementId) {
        print('Load Complete $placementId');

        placements[placementId] = true;
        notifyListeners();
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  void checkIfCanShowAd(String placementId, bool freezeCheck) {
    if (freezeCheck) {
      _showAd(placementId);
    } else {
      if (interstitialAdCounter >= 3) {
        _showAd(placementId);
        interstitialAdCounter = 0;
      } else {
        interstitialAdCounter++;
      }
    }
  }

  void _showAd(String placementId) {
    placements[placementId] = false;
    notifyListeners();
    UnityAds.showVideoAd(
      placementId: placementId,
      onComplete: (placementId) {
        print('Video Ad $placementId completed');
        _loadAd(placementId);
      },
      onFailed: (placementId, error, message) {
        print('Video Ad $placementId failed: $error $message');
        _loadAd(placementId);
      },
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) {
        print('Video Ad $placementId skipped');
        _loadAd(placementId);
      },
    );
  }

  bool isAdFreeVersion = false;

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getPurchaserInfo();
    final productName =
        Platform.isAndroid ? "free_ad_version" : "wowtc_ad_free_version";

    if (purchaserInfo.allPurchasedProductIdentifiers.length > 0 &&
        purchaserInfo.allPurchasedProductIdentifiers[0] == productName) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isAdFreeVersion', true);
      isAdFreeVersion = true;
      notifyListeners();
    }
  }

  checkIsAdFreeversion() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isAdFree = prefs.getBool("isAdFreeVersion");
    if (isAdFree != null && isAdFree == true) {
      isAdFreeVersion = true;
      notifyListeners();
    }
  }

  void changeToAdFreeVersion() {
    isAdFreeVersion = true;
    notifyListeners();
  }
}
