import 'dart:io';
import 'dart:math';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/foundation.dart';

import 'package:wowtalentcalculator/ad_manager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdState extends ChangeNotifier {
  int interstitialAdCounter = 0;
  int _maxExponentialRetryCount = 6;
  var _interstitialRetryAttempt = 0;
  AdState() {
    Purchases.addPurchaserInfoUpdateListener(
        (purchaserInfo) => {updatePurchaseStatus()});
    checkIsAdFreeversion();
  }

  void showInterstitialAd() async {
    bool isReady = (await AppLovinMAX.isInterstitialReady(interAdId))!;
    if (isReady) {
      AppLovinMAX.showInterstitial(interAdId);
    }
  }

  void initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to show. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_ID) now returns 'true'.
        print('Interstitial ad loaded from ' + ad.networkName);

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load.
        // AppLovin recommends that you retry with exponentially higher delays up to a maximum delay (in this case 64 seconds).
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
        if (_interstitialRetryAttempt > _maxExponentialRetryCount) return;
        int retryDelay =
            pow(2, min(_maxExponentialRetryCount, _interstitialRetryAttempt))
                .toInt();

        print('Interstitial ad failed to load with code ' +
            error.code.toString() +
            ' - retrying in ' +
            retryDelay.toString() +
            's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(interAdId);
        });
      },
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
      showInterstitialAd();
    } else {
      if (interstitialAdCounter >= 3) {
        showInterstitialAd();
        interstitialAdCounter = 0;
      } else {
        interstitialAdCounter++;
      }
    }
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
