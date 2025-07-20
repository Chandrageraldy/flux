import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class LoadingPage extends BaseStatefulPage {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends BaseStatefulState<LoadingPage> {
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
          Lottie.asset(AnimationPath.loadingAnimation, width: 150, height: 150),
          Text(S.current.personalizingYourPlanLoadingText, style: Quicksand.medium.withSize(FontSizes.huge)),
        ],
      ),
    );
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _LoadingPageState {
  void calculateRequiredCaloriesAndNutrients() {
    final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

    final bm = userProfile!.bodyMetrics!;
    final dob = bm.dob?.toDateTime(DateFormat.YEAR_MONTH_DAY);
    if (dob == null) return;

    final gender = bm.gender ?? PlanSelectionValue.male.value;
    final goal = bm.goal ?? PlanSelectionValue.maintain.value;
    final weight = double.tryParse(bm.weight ?? '') ?? 0;
    final height = double.tryParse(bm.height ?? '') ?? 0;

    double targetWeeklyGain;

    // Convert target weekly gain to negative value for weight loss
    if (goal == PlanSelectionValue.maintain.value) {
      targetWeeklyGain = 0.0;
    } else if (goal == PlanSelectionValue.gain.value) {
      targetWeeklyGain = double.tryParse(bm.targetWeeklyGain ?? '') ?? -0.5;
    } else {
      final negativeWeeklyChange = double.tryParse(bm.targetWeeklyGain ?? '') ?? 0.5;
      targetWeeklyGain = -negativeWeeklyChange;
    }

    final activityLevel = bm.activityLevel ?? PlanSelectionValue.sedentary.value;
    final exerciseLevel = bm.exerciseLevel ?? PlanSelectionValue.never.value;

    final age = calculateAge(dob);
    final bmr = calculateBMR(gender: gender, weightKg: weight, heightCm: height, age: age);

    final activityFactor = getActivityFactor(activityLevel);
    final exerciseFactor = getExerciseFactor(exerciseLevel);

    final tdee = bmr * (activityFactor + exerciseFactor);

    // Adjust TDEE based on target weekly gain
    final double adjustedKcalBasedOnTargetWeeklyGain = goal == PlanSelectionValue.maintain.value
        ? tdee
        : adjustCaloriesForTargetWeeklyGain(tdee: tdee, targetWeeklyGain: targetWeeklyGain);

    Map<String, double> macroRatio = getMacroRatio(bm.dietType ?? PlanSelectionValue.balanced.value);

    final calorieAndMacro = getCalorieAndMacro(adjustedKcalBasedOnTargetWeeklyGain, macroRatio);

    // ignore: avoid_print
    print(calorieAndMacro);
  }

  int calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
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

  double getActivityFactor(String level) {
    switch (level) {
      case 'sedentary':
        return 1.2;
      case 'lightly active':
        return 1.375;
      case 'active':
        return 1.55;
      case 'very active':
        return 1.725;
      default:
        return 1.2;
    }
  }

  double getExerciseFactor(String exerciseLevel) {
    switch (exerciseLevel) {
      case 'never':
        return 0.0;
      case 'light':
        return 0.1;
      case 'moderate':
        return 0.15;
      case 'frequent':
        return 0.2;
      default:
        return 0.0;
    }
  }

  Map<String, double> getMacroRatio(String dietType) {
    late double proteinRatio;
    late double fatRatio;
    late double carbRatio;

    switch (dietType) {
      case 'keto':
        proteinRatio = 0.20;
        fatRatio = 0.70;
        carbRatio = 0.10;
        break;
      case 'mediterranean':
        proteinRatio = 0.15;
        fatRatio = 0.30;
        carbRatio = 0.55;
        break;
      case 'vegetarian':
        proteinRatio = 0.30;
        fatRatio = 0.20;
        carbRatio = 0.50;
        break;
      case 'paleo':
        proteinRatio = 0.30;
        fatRatio = 0.35;
        carbRatio = 0.35;
        break;
      case 'lowCarbs':
        proteinRatio = 0.45;
        fatRatio = 0.35;
        carbRatio = 0.20;
        break;
      default:
        proteinRatio = 0.25;
        fatRatio = 0.25;
        carbRatio = 0.50;
    }

    return {
      'proteinRatio': proteinRatio,
      'fatRatio': fatRatio,
      'carbRatio': carbRatio,
    };
  }

  Map<String, double> getDailyMicronutrients(String gender, int age) {
    if (gender == PlanSelectionValue.male.value && age >= 19 && age <= 30) {}
    return {};
  }

  double adjustCaloriesForTargetWeeklyGain({
    required double tdee,
    required double targetWeeklyGain,
  }) {
    double calorieAdjustment = targetWeeklyGain * 7700 / 7;
    return tdee + calorieAdjustment;
  }

  Map<String, double> getCalorieAndMacro(double calorie, Map<String, double> macroRatio) {
    double protein = calorie * macroRatio['proteinRatio']!;
    double fat = calorie * macroRatio['fatRatio']!;
    double carb = calorie * macroRatio['carbRatio']!;

    return {
      Nutrition.calorie.key: calorie,
      Nutrition.protein.key: protein / 4,
      Nutrition.fat.key: fat / 9,
      Nutrition.carbs.key: carb / 4,
    };
  }
}
