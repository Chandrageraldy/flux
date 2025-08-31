import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/plan_vm/plan_view_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

enum PlanAction {
  CREATE,
  UPDATE,
}

@RoutePage()
class PersonalizingPlanLoadingPage extends BaseStatefulPage {
  const PersonalizingPlanLoadingPage({
    super.key,
    this.planAction = PlanAction.CREATE,
    this.mealRatio,
    this.nutritionGoals,
  });

  final PlanAction? planAction;
  final Map<String, String>? mealRatio;
  final Map<String, String>? nutritionGoals;

  @override
  State<PersonalizingPlanLoadingPage> createState() => _PersonalizingPlanLoadingPageState();
}

class _PersonalizingPlanLoadingPageState extends BaseStatefulState<PersonalizingPlanLoadingPage> {
  @override
  void initState() {
    super.initState();
    calculateRequiredCaloriesAndNutrients();
  }

  @override
  Widget body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            AnimationPath.starAIAnimation,
            width: AppStyles.kSize64,
            height: AppStyles.kSize64,
          ),
          AppStyles.kSizedBoxH20,
          Padding(
            padding: AppStyles.kPaddSH20,
            child: Text(
              widget.planAction == PlanAction.CREATE
                  ? S.current.personalizingYourPlanLoadingText
                  : S.current.updateYourPlanLoadingText,
              style: _Styles.getPersonalizingPlanLabelTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _PersonalizingPlanLoadingPageState {
  void calculateRequiredCaloriesAndNutrients() {
    final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

    final bm = userProfile!.bodyMetrics!;
    final dob = bm.dob?.toDateTime(DateFormat.YEAR_MONTH_DAY);
    if (dob == null) return;

    final gender = bm.gender ?? PlanSelectionValue.male.value;
    final goal = bm.goal ?? PlanSelectionValue.maintain.value;
    final weight = double.tryParse(bm.weight ?? '') ?? 0;
    final height = double.tryParse(bm.height ?? '') ?? 0;

    double targetWeeklyChange;

    // Convert target weekly change to negative value for weight loss
    if (goal == PlanSelectionValue.maintain.value) {
      targetWeeklyChange = 0.0;
    } else if (goal == PlanSelectionValue.gain.value) {
      targetWeeklyChange = double.tryParse(bm.targetWeeklyChange ?? '') ?? -0.5;
    } else {
      final negativeWeeklyChange = double.tryParse(bm.targetWeeklyChange ?? '') ?? 0.5;
      targetWeeklyChange = -negativeWeeklyChange;
    }

    final activityLevel = bm.activityLevel ?? PlanSelectionValue.sedentary.value;
    final exerciseLevel = bm.exerciseLevel ?? PlanSelectionValue.never.value;

    final age = FunctionUtils.calculateAge(dob);
    final bmr = calculateBMR(gender: gender, weightKg: weight, heightCm: height, age: age);

    final activityFactor = FunctionUtils.getActivityFactor(activityLevel);
    final exerciseFactor = FunctionUtils.getExerciseFactor(exerciseLevel);

    final tdee = bmr * (activityFactor + exerciseFactor);

    // Adjust TDEE based on target weekly change
    final double adjustedKcalBasedOnTargetWeeklyChange = goal == PlanSelectionValue.maintain.value
        ? tdee
        : adjustCaloriesForTargetWeeklyChange(tdee: tdee, targetWeeklyChange: targetWeeklyChange);

    Map<String, double> macroRatio = {};
    final PlanModel? plan = SharedPreferenceHandler().getPlan();

    if (widget.nutritionGoals != null) {
      // If update from nutrition goals settings, use updated ratio
      macroRatio = FunctionUtils.getMacroRatio(
        bm.dietType ?? PlanSelectionValue.balanced.value,
        customCarbsRatio: double.tryParse(
          widget.nutritionGoals?[NutritionGoalsSettings.carbsRatio.key] ?? '0',
        ),
        customProteinRatio: double.tryParse(
          widget.nutritionGoals?[NutritionGoalsSettings.proteinRatio.key] ?? '0',
        ),
        customFatRatio: double.tryParse(
          widget.nutritionGoals?[NutritionGoalsSettings.fatRatio.key] ?? '0',
        ),
      );
    } else if (widget.nutritionGoals == null && widget.planAction == PlanAction.UPDATE) {
      // If update from other plan customization settings, use current ratio
      macroRatio = FunctionUtils.getMacroRatio(
        bm.dietType ?? PlanSelectionValue.balanced.value,
        customCarbsRatio: plan?.carbsRatio,
        customProteinRatio: plan?.proteinRatio,
        customFatRatio: plan?.fatRatio,
      );
    } else {
      macroRatio = FunctionUtils.getMacroRatio(bm.dietType ?? PlanSelectionValue.balanced.value);
    }

    Map<String, double> dailyMicronutrients = getDailyMicronutrients(gender, age);

    final completeNutrient =
        getCompleteNutrients(adjustedKcalBasedOnTargetWeeklyChange, macroRatio, dailyMicronutrients);

    createOrUpdatePersonalizedPlan(completeNutrient);
  }

  // Basal Metabolic Rate (BMR)
  double calculateBMR({
    required String gender,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    if (gender == PlanSelectionValue.male.value) {
      return 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      return 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }
  }

  Map<String, double> getDailyMicronutrients(String gender, int age) {
    final bool isMale = gender == PlanSelectionValue.male.value;

    Map<String, double> male19_30 = {
      Nutrition.calcium.key: 1000, // mg
      Nutrition.iron.key: 8, // mg
      Nutrition.magnesium.key: 400, // mg
      Nutrition.phosphorus.key: 700, // mg
      Nutrition.potassium.key: 3400, // mg
      Nutrition.sodium.key: 1500, // mg
      Nutrition.zinc.key: 11, // mg
      Nutrition.copper.key: 0.9, // mg
      Nutrition.manganese.key: 2.3, // mg
      Nutrition.selenium.key: 55, // µg
      Nutrition.vitaminA.key: 3000, // IU
      Nutrition.vitaminE.key: 15, // mg
      Nutrition.vitaminD.key: 600, // IU
      Nutrition.vitaminC.key: 90, // mg
      Nutrition.thiamin.key: 1.2, // mg
      Nutrition.riboflavin.key: 1.3, // mg
      Nutrition.niacin.key: 16, // mg
      Nutrition.vitaminB6.key: 1.3, // mg
      Nutrition.vitaminB12.key: 2.4, // µg
      Nutrition.choline.key: 550, // mg
      Nutrition.vitaminK.key: 120, // µg
      Nutrition.folate.key: 400, // µg
    };

    Map<String, double> male31_50 = {
      ...male19_30,
      Nutrition.magnesium.key: 420, // mg
    };

    Map<String, double> male51plus = {
      ...male31_50,
      Nutrition.vitaminB6.key: 1.7, // mg
    };

    Map<String, double> male70plus = {
      ...male51plus,
      Nutrition.calcium.key: 1200, // mg
    };

    Map<String, double> female19_30 = {
      Nutrition.calcium.key: 1000, // mg
      Nutrition.iron.key: 18, // mg
      Nutrition.magnesium.key: 310, // mg
      Nutrition.phosphorus.key: 700, // mg
      Nutrition.potassium.key: 2600, // mg
      Nutrition.sodium.key: 1500, // mg
      Nutrition.zinc.key: 8, // mg
      Nutrition.copper.key: 0.9, // mg
      Nutrition.manganese.key: 1.8, // mg
      Nutrition.selenium.key: 55, // µg
      Nutrition.vitaminA.key: 2333, // IU
      Nutrition.vitaminE.key: 15, // mg
      Nutrition.vitaminD.key: 600, // IU
      Nutrition.vitaminC.key: 75, // mg
      Nutrition.thiamin.key: 1.1, // mg
      Nutrition.riboflavin.key: 1.1, // mg
      Nutrition.niacin.key: 14, // mg
      Nutrition.vitaminB6.key: 1.3, // mg
      Nutrition.vitaminB12.key: 2.4, // µg
      Nutrition.choline.key: 425, // mg
      Nutrition.vitaminK.key: 90, // µg
      Nutrition.folate.key: 400, // µg
    };

    Map<String, double> female31_50 = {
      ...female19_30,
      Nutrition.magnesium.key: 320, // mg
    };

    Map<String, double> female51plus = {
      ...female31_50,
      Nutrition.calcium.key: 1200, // mg
      Nutrition.iron.key: 8, // mg
      Nutrition.vitaminB6.key: 1.5, // mg
    };

    if (age >= 19 && age <= 30) {
      return isMale ? male19_30 : female19_30;
    } else if (age >= 31 && age <= 50) {
      return isMale ? male31_50 : female31_50;
    } else if (age >= 51 && age <= 70) {
      return isMale ? male51plus : female51plus;
    } else if (age > 70) {
      return isMale ? male70plus : female51plus;
    }

    return {};
  }

  double adjustCaloriesForTargetWeeklyChange({
    required double tdee,
    required double targetWeeklyChange,
  }) {
    double calorieAdjustment = targetWeeklyChange * 7700 / 7;
    return tdee + calorieAdjustment;
  }

  Map<String, dynamic> getCompleteNutrients(
    double calorie,
    Map<String, double> macroRatio,
    Map<String, double> microNutrients,
  ) {
    double protein = calorie * (macroRatio['proteinRatio']! / 100);
    double fat = calorie * (macroRatio['fatRatio']! / 100);
    double carb = calorie * (macroRatio['carbsRatio']! / 100);

    return {
      Nutrition.calorie.key: calorie.round(),
      Nutrition.protein.key: (protein / 4).round(),
      Nutrition.fat.key: (fat / 9).round(),
      Nutrition.carbs.key: (carb / 4).round(),
      ...macroRatio,
      ...microNutrients,
    };
  }

  Map<String, double> mealDistribution() {
    final PlanModel? plan = SharedPreferenceHandler().getPlan();

    if (widget.mealRatio != null) {
      // If update from meal ratio settings, use updated ratio
      return {
        MealRatioSettings.breakfastRatio.key:
            double.tryParse(widget.mealRatio![MealRatioSettings.breakfastRatio.key]?.toString() ?? '0')! / 100,
        MealRatioSettings.lunchRatio.key:
            double.tryParse(widget.mealRatio![MealRatioSettings.lunchRatio.key]?.toString() ?? '0')! / 100,
        MealRatioSettings.dinnerRatio.key:
            double.tryParse(widget.mealRatio![MealRatioSettings.dinnerRatio.key]?.toString() ?? '0')! / 100,
        MealRatioSettings.snackRatio.key:
            double.tryParse(widget.mealRatio![MealRatioSettings.snackRatio.key]?.toString() ?? '0')! / 100,
      };
    }

    if (widget.mealRatio == null && widget.planAction == PlanAction.UPDATE) {
      // If update from other plan customization settings, use current ratio
      return {
        MealRatioSettings.breakfastRatio.key: (plan?.breakfastRatio ?? 0) / 100,
        MealRatioSettings.lunchRatio.key: (plan?.lunchRatio ?? 0) / 100,
        MealRatioSettings.dinnerRatio.key: (plan?.dinnerRatio ?? 0) / 100,
        MealRatioSettings.snackRatio.key: (plan?.snackRatio ?? 0) / 100,
      };
    }

    // Default ratios in decimal form
    return {
      MealRatioSettings.breakfastRatio.key: 0.25,
      MealRatioSettings.lunchRatio.key: 0.35,
      MealRatioSettings.dinnerRatio.key: 0.30,
      MealRatioSettings.snackRatio.key: 0.10,
    };
  }

  Map<String, dynamic> calculateMealRatioMap({
    required double totalCalories,
    required double totalProtein,
    required double totalFat,
    required double totalCarbs,
    required double portion,
  }) {
    return {
      Nutrition.calorie.key: (totalCalories * portion).roundToDouble(),
      Nutrition.protein.key: (totalProtein * portion).roundToDouble(),
      Nutrition.fat.key: (totalFat * portion).roundToDouble(),
      Nutrition.carbs.key: (totalCarbs * portion).roundToDouble(),
    };
  }

  Map<String, dynamic> getMealRatio(Map<String, dynamic> completeNutrients) {
    final double totalCalories = (completeNutrients[Nutrition.calorie.key] ?? 0).toDouble();
    final double totalProtein = (completeNutrients[Nutrition.protein.key] ?? 0).toDouble();
    final double totalFat = (completeNutrients[Nutrition.fat.key] ?? 0).toDouble();
    final double totalCarbs = (completeNutrients[Nutrition.carbs.key] ?? 0).toDouble();

    final Map<String, dynamic> mealRatios = {
      MealType.breakfast.key: calculateMealRatioMap(
        totalCalories: totalCalories,
        totalProtein: totalProtein,
        totalFat: totalFat,
        totalCarbs: totalCarbs,
        portion: mealDistribution()[MealRatioSettings.breakfastRatio.key]!,
      ),
      MealType.lunch.key: calculateMealRatioMap(
        totalCalories: totalCalories,
        totalProtein: totalProtein,
        totalFat: totalFat,
        totalCarbs: totalCarbs,
        portion: mealDistribution()[MealRatioSettings.lunchRatio.key]!,
      ),
      MealType.dinner.key: calculateMealRatioMap(
        totalCalories: totalCalories,
        totalProtein: totalProtein,
        totalFat: totalFat,
        totalCarbs: totalCarbs,
        portion: mealDistribution()[MealRatioSettings.dinnerRatio.key]!,
      ),
      MealType.snack.key: calculateMealRatioMap(
        totalCalories: totalCalories,
        totalProtein: totalProtein,
        totalFat: totalFat,
        totalCarbs: totalCarbs,
        portion: mealDistribution()[MealRatioSettings.snackRatio.key]!,
      ),
    };

    return mealRatios;
  }

  void createOrUpdatePersonalizedPlan(Map<String, dynamic> completeNutrients) async {
    final mealRatio = getMealRatio(completeNutrients);

    final updatedMealDistribution = mealDistribution().map(
      (key, value) => MapEntry(key, value * 100),
    );

    final personalizedPlan = {...completeNutrients, ...mealRatio, ...updatedMealDistribution};

    if (widget.planAction == PlanAction.CREATE) {
      await createPersonalizedPlan(personalizedPlan);
    } else {
      await updatePersonalizedPlan(personalizedPlan);
    }
  }

  Future<void> createPersonalizedPlan(Map<String, dynamic> personalizedPlan) async {
    final response =
        await tryCatch(context, () => context.read<PlanViewModel>().createPersonalizedPlan(personalizedPlan)) ?? false;

    await Future.delayed(Duration(seconds: 3));

    if (response && mounted) {
      context.router.replaceAll([DashboardNavigatorRoute()]);
    }
  }

  Future<void> updatePersonalizedPlan(Map<String, dynamic> personalizedPlan) async {
    final response =
        await tryCatch(context, () => context.read<PlanViewModel>().updatePersonalizedPlan(personalizedPlan)) ?? false;

    if (response && mounted) {
      context.router.replaceAll([ProfileRoute()]);
    }
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Personalizing Plan Label Text Style
  static TextStyle getPersonalizingPlanLabelTextStyle() {
    return Quicksand.medium.withSize(FontSizes.large);
  }
}
