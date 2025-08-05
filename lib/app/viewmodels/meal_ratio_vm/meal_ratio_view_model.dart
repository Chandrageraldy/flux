import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class MealRatioViewModel extends BaseViewModel {
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> mealRatio = {};

  MealRatioViewModel() {
    init();
  }

  void init() {
    final PlanModel? plan = sharedPreferenceHandler.getPlan();

    mealRatio = {
      MealRatioSettings.breakfastRatio.key: plan?.breakfastRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.lunchRatio.key: plan?.lunchRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.dinnerRatio.key: plan?.dinnerRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.snackRatio.key: plan?.snackRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.totalRatio.key: 100.toString(),
    };
  }

  void onMealRatioChanged(String key, String value) {
    mealRatio = {...mealRatio, key: value};

    final breakfast = double.tryParse(mealRatio[MealRatioSettings.breakfastRatio.key] ?? '') ?? 0;
    final lunch = double.tryParse(mealRatio[MealRatioSettings.lunchRatio.key] ?? '') ?? 0;
    final dinner = double.tryParse(mealRatio[MealRatioSettings.dinnerRatio.key] ?? '') ?? 0;
    final snack = double.tryParse(mealRatio[MealRatioSettings.snackRatio.key] ?? '') ?? 0;

    final total = breakfast + lunch + dinner + snack;

    mealRatio = {
      ...mealRatio,
      MealRatioSettings.totalRatio.key: total.toStringAsFixed(0),
    };

    notifyListeners();
  }
}
