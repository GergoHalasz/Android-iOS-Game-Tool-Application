import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const keyNameForCount = 'countOpens';

class RatingService {
  late SharedPreferences _prefs;
  final InAppReview _inAppReview = InAppReview.instance;

  Future<bool> isSecondTimeOpen() async {
    _prefs = await SharedPreferences.getInstance();

    int? countOpens = _prefs.getInt(keyNameForCount);

    if (countOpens == null) {
      _prefs.setInt(keyNameForCount, 1);
      return false;
    }

    if (countOpens != 4) {
      _prefs.setInt(keyNameForCount, countOpens + 1);
      return false;
    } else {
      _prefs.setInt(keyNameForCount, 0);
      return true;
    }
  }

  Future<bool> showRating() async {
    try {
      final available = await _inAppReview.isAvailable();
      if (available) {
        _inAppReview.openStoreListing(
          appStoreId: '1593368066',
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
