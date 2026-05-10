import 'package:shared_preferences/shared_preferences.dart';

// necessary because retrieving tolerance for user display needs to be in percentage(s?), but for lookups, we need the valid 0.0 => 2.0 range
// could just be a bool, but enums are cooler
enum ToleranceType { percentage, inRange }

class UserPreferenceService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  storeTolerancePref({required double toleranceInPercentage}) {
    //conver the users tolerance preset in percentage to the valid range of 0 => 2.0 for ObjectBox
    final toleranceInRange = (toleranceInPercentage / 100) * 2.0;
    _prefs.setDouble('search_tolerance', toleranceInRange);
  }

  double getTolerancePref({required ToleranceType toleranceType}) {
    final toleranceInRange = _prefs.getDouble('search_tolerance') ?? 0.0;
    if (toleranceType == ToleranceType.inRange) {
      // since we converted tolerance to valid ANN range(0.0 => 2.0) , on DIRECT retrivel it comes out as that, must be converted to precentage for UI
      return toleranceInRange;
    } else {
      return ((toleranceInRange / 2.0) * 100);
    }
  }

  storeMaxResultsPerQuery({required int maxResults}) {
    _prefs.setInt('maxResults', maxResults);
  }

  int getMaxResultsPerQuery() {
    return _prefs.getInt('maxResults') ?? 4;
  }
}
