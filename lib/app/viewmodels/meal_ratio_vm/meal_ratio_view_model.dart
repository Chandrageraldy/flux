import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class MealRatioViewModel extends BaseViewModel {
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> modifiedMealRatio = {};
  Map<String, String> unmodifiedMealRatio = {};

  MealRatioViewModel() {
    init();
  }

  void init() {
    final PlanModel? plan = sharedPreferenceHandler.getPlan();

    modifiedMealRatio = {
      MealRatioSettings.breakfastRatio.key: plan?.breakfastRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.lunchRatio.key: plan?.lunchRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.dinnerRatio.key: plan?.dinnerRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.snackRatio.key: plan?.snackRatio?.toStringAsFixed(0) ?? '',
      MealRatioSettings.totalRatio.key: 100.toString(),
    };
    unmodifiedMealRatio = modifiedMealRatio;
    notifyListeners();
  }

  void onMealRatioChanged(String key, String value) {
    modifiedMealRatio = {...modifiedMealRatio, key: value};

    final breakfast = double.tryParse(modifiedMealRatio[MealRatioSettings.breakfastRatio.key] ?? '') ?? 0;
    final lunch = double.tryParse(modifiedMealRatio[MealRatioSettings.lunchRatio.key] ?? '') ?? 0;
    final dinner = double.tryParse(modifiedMealRatio[MealRatioSettings.dinnerRatio.key] ?? '') ?? 0;
    final snack = double.tryParse(modifiedMealRatio[MealRatioSettings.snackRatio.key] ?? '') ?? 0;

    final total = breakfast + lunch + dinner + snack;

    modifiedMealRatio = {
      ...modifiedMealRatio,
      MealRatioSettings.totalRatio.key: total.toStringAsFixed(0),
    };

    notifyListeners();
  }

  bool checkIfNotEdited() {
    return modifiedMealRatio == unmodifiedMealRatio;
  }
}
