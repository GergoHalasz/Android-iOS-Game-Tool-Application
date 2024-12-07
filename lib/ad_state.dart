import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdState extends ChangeNotifier {
  Future<InitializationStatus> initialization;
  InterstitialAd? interstitialAd;
  int interstitialAdCounter = 0;
  int interstitialAdCounter2 = 0;

  AdState(this.initialization) {
    this.initialization = initialization;
    loadInterstitialAd();
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) {
      updatePurchaseStatus();
    });
    checkIsAdFreeversion();
  }

  bool isAdFreeVersion = false;

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getPurchaserInfo();
    final productName =
        Platform.isAndroid ? "1234567890" : "wowtc_ad_free_version";

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

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9214589741'
      : 'ca-app-pub-7574598565891663/4000989331';

  String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-7574598565891663/8411007639';

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  void loadInterstitialAd() {
    if (!isAdFreeVersion) {
      InterstitialAd.load(
          adUnitId: interstitialAdUnitId!,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              this.interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              interstitialAd = null;
              loadInterstitialAd();
            },
          ));
    }
  }

  void showInterstitialAd() {
    if (interstitialAd != null && !isAdFreeVersion) {
      interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        interstitialAd!.dispose();
        loadInterstitialAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        interstitialAd!.dispose();
        loadInterstitialAd();
      }));
      interstitialAd!.show();
    } else {
      if (interstitialAd == null) {
        loadInterstitialAd();
      }
    }
  }

  void showInterstitialAdClass2() {
    if (interstitialAd != null && !isAdFreeVersion && interstitialAdCounter2 == 2) {
      interstitialAdCounter2 = 0;
      interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        interstitialAd!.dispose();
        loadInterstitialAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        interstitialAd!.dispose();
        loadInterstitialAd();
      }));
      interstitialAd!.show();
    } else {
      if (interstitialAd == null) {
        loadInterstitialAd();
      }
    }
  }

  void showInterstitialAdClassScreen() {
    if (interstitialAd != null &&
        !isAdFreeVersion &&
        interstitialAdCounter == 3) {
      interstitialAdCounter = 0;
      interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        interstitialAd!.dispose();
        loadInterstitialAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        interstitialAd!.dispose();
        loadInterstitialAd();
      }));
      interstitialAd!.show();
    } else {
      if (interstitialAd == null) {
        loadInterstitialAd();
      }
    }
  }
}
