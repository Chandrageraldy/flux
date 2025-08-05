import 'package:flux/app/assets/exporter/exporter_app_general.dart';

import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class NutritionGoalsViewModel extends BaseViewModel {
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> nutritionGoals = {};

  NutritionGoalsViewModel() {
    _init();
  }

  void _init() {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();
    final PlanModel? plan = sharedPreferenceHandler.getPlan();

    nutritionGoals = {
      NutritionGoalsSettings.energyTarget.key: plan?.calorieKcal?.toStringAsFixed(0) ?? '',
      NutritionGoalsSettings.proteinRatio.key: plan?.proteinRatio?.toStringAsFixed(0) ?? '',
      NutritionGoalsSettings.carbsRatio.key: plan?.carbsRatio?.toStringAsFixed(0) ?? '',
      NutritionGoalsSettings.fatRatio.key: plan?.fatRatio?.toStringAsFixed(0) ?? '',
      NutritionGoalsSettings.dietType.key: user?.bodyMetrics?.dietType ?? '',
    };
    notifyListeners();
  }
}
