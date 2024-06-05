import 'dart:io';
import 'dart:math';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/foundation.dart';

import 'package:wowtalentcalculator/ad_manager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdState extends ChangeNotifier {
  int interstitialAdCounter = 1;
  int _maxExponentialRetryCount = 6;
  var _interstitialRetryAttempt = 0;
  AdState() {
    Purchases.addPurchaserInfoUpdateListener(
        (purchaserInfo) => {updatePurchaseStatus()});
    checkIsAdFreeversion();
  }

  void showInterstitialAd() async {
    AppLovinMAX.showInterstitial(interAdId);
  }

  void initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {},
      onAdLoadFailedCallback: (adUnitId, error) {},
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {},
    ));

    // Load the first interstitial.
    AppLovinMAX.loadInterstitial(interAdId);
  }

  void checkIfCanShowAd(bool freezeCheck) {
    if (freezeCheck) {
      if (interstitialAdCounter >= 1) {
        showInterstitialAd();
        interstitialAdCounter = 0;
      } else {
        interstitialAdCounter++;
        AppLovinMAX.loadInterstitial(interAdId);
      }
    }
  }

  bool isAdFreeVersion = false;

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getPurchaserInfo();
    final productName = Platform.isAndroid ? "123456" : "wowtc_ad_free_version";

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
