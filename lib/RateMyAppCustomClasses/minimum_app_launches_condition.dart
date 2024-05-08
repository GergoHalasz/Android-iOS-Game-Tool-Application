import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomMinimumAppLaunchesCondition extends DebuggableCondition {
  /// Minimum launches before being able to show the dialog.
  final int minLaunches;

  /// Launches to subtract to the number of launches when the user clicks on "Maybe later".
  final int remindLaunches;

  /// Number of app launches.
  var launches = 0;

  /// Creates a new minimum app launches condition instance.
  CustomMinimumAppLaunchesCondition({
    required this.minLaunches,
    required this.remindLaunches,
  });

  @override
  void readFromPreferences(
      SharedPreferences preferences, String preferencesPrefix) {
    launches = preferences.getInt(preferencesPrefix + 'launches') ?? 0;
  }

  @override
  Future<void> saveToPreferences(
      SharedPreferences preferences, String preferencesPrefix) {
    return preferences.setInt(preferencesPrefix + 'launches', launches);
  }

  @override
  void reset() => launches = 0;

  @override
  bool get isMet => launches >= minLaunches;

  @override
  bool onEventOccurred(RateMyAppEventType eventType) {
    if (eventType == RateMyAppEventType.initialized) {
      launches++;
      return true;
    }

    if (eventType == RateMyAppEventType.laterButtonPressed ||
        eventType == RateMyAppEventType.noButtonPressed ||
        eventType == RateMyAppEventType.iOSRequestReview) {
      launches -= remindLaunches;
      return true;
    }

    return false;
  }

  @override
  String get valuesAsString {
    return 'Minimum launches : $minLaunches\nRemind launches : $remindLaunches\nCurrent launches : $launches';
  }
}