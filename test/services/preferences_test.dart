import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gifza/services/userPreferenceService.dart';

void main() {
  late UserPreferenceService prefs;

  setUp(() async {
    // Set initial in-memory preferences
    SharedPreferences.setMockInitialValues({});
    prefs = UserPreferenceService();
    await prefs.init(); // init with mock values
  });

  test('default tolerance in range is 1.0', () {
    final value = prefs.getTolerancePref(toleranceType: ToleranceType.inRange);
    expect(value, 1.0);
  });

  test('default tolerance percentage is 50%', () {
    final value =
        prefs.getTolerancePref(toleranceType: ToleranceType.percentage);
    expect(value, 50.0);
  });

  test('storeTolerancePref stores correctly and returns updated value', () {
    prefs.storeTolerancePref(toleranceSliderValue: 0.3);
    final inRange =
        prefs.getTolerancePref(toleranceType: ToleranceType.inRange);
    final percentage =
        prefs.getTolerancePref(toleranceType: ToleranceType.percentage);
    expect(inRange, closeTo(0.6, 1e-9));
    expect(percentage, closeTo(30.0, 1e-9));
  });

  test('maxResultsPerQuery defaults to 4 and can be changed', () {
    expect(prefs.getMaxResultsPerQuery(), 4);
    prefs.storeMaxResultsPerQuery(maxResults: 10);
    expect(prefs.getMaxResultsPerQuery(), 10);
  });
}
