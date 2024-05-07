import 'package:flutter/foundation.dart';

class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '5601037';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return '5601036';
    }
    return '';
  }

  static String get bannerAdPlacementId {
    return 'Banner_iOS';
  }

  static String get interstitialVideoAdPlacementId {
    return 'Interstitial_iOS';
  }

  static String get rewardedVideoAdPlacementId {
    return 'your_rewarded_video_ad_placement_id';
  }
}