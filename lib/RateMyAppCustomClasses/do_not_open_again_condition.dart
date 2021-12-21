import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDoNotOpenAgainCondition extends DebuggableCondition {
  /// Whether the dialog should not be opened again.
  bool doNotOpenAgain = false;

  @override
  void readFromPreferences(
      SharedPreferences preferences, String preferencesPrefix) {
    doNotOpenAgain =
        preferences.getBool(preferencesPrefix + 'doNotOpenAgain') ?? false;
  }

  @override
  Future<void> saveToPreferences(
      SharedPreferences preferences, String preferencesPrefix) {
    return preferences.setBool(
        preferencesPrefix + 'doNotOpenAgain', doNotOpenAgain);
  }

  @override
  void reset() => doNotOpenAgain = false;

  @override
  bool get isMet => !doNotOpenAgain;

  @override
  bool onEventOccurred(RateMyAppEventType eventType) {
    if (eventType == RateMyAppEventType.rateButtonPressed) {
      doNotOpenAgain = true;
      return true;
    }

    return false;
  }

  @override
  String get valuesAsString {
    return 'Do not open again ? ' + (doNotOpenAgain ? 'Yes' : 'No');
  }
}
