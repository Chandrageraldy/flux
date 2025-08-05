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
      NutritionGoalsSettings.totalRatio.key: 100.toString(),
    };
    notifyListeners();
  }

  void onMacroRatioChanged(String key, String value) {
    nutritionGoals = {...nutritionGoals, key: value};

    final protein = double.tryParse(nutritionGoals[NutritionGoalsSettings.proteinRatio.key] ?? '') ?? 0;
    final carbs = double.tryParse(nutritionGoals[NutritionGoalsSettings.carbsRatio.key] ?? '') ?? 0;
    final fat = double.tryParse(nutritionGoals[NutritionGoalsSettings.fatRatio.key] ?? '') ?? 0;

    final total = protein + carbs + fat;

    nutritionGoals = {
      ...nutritionGoals,
      NutritionGoalsSettings.totalRatio.key: total.toStringAsFixed(0),
    };

    notifyListeners();
  }

  void onDietTypeChanged(String key, String value, Map<String, double> macroRatio) {
    nutritionGoals = {
      ...nutritionGoals,
      key: value,
      NutritionGoalsSettings.proteinRatio.key: macroRatio[NutritionGoalsSettings.proteinRatio.key]!.toStringAsFixed(0),
      NutritionGoalsSettings.fatRatio.key: macroRatio[NutritionGoalsSettings.fatRatio.key]!.toStringAsFixed(0),
      NutritionGoalsSettings.carbsRatio.key: macroRatio[NutritionGoalsSettings.carbsRatio.key]!.toStringAsFixed(0),
    };
    notifyListeners();
    debugPrint('$nutritionGoals');
  }
}
