import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
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
  }

  @override
  Widget body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('lib/app/assets/animations/loading.json', width: 150, height: 150),
          Text('Personalizing your plan.....', style: Quicksand.medium.withSize(FontSizes.huge)),
        ],
      ),
    );
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _LoadingPageState {
  void calculateRequiredCaloriesAndNutrients() {
    final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

    final dob = userProfile!.bodyMetrics?.dob;
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
    if (gender.toLowerCase() == 'male') {
      return 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      return 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }
  }

  double getActivityFactor(String level) {
    switch (level) {
      case 'sedentary':
        return 1.2;
      case 'lightly_active':
        return 1.375;
      case 'moderately_active':
        return 1.55;
      case 'very_active':
        return 1.725;
      case 'super_active':
        return 1.9;
      default:
        return 1.2;
    }
  }

  double calculateTDEE(double bmr, double activityFactor) {
    return bmr * activityFactor;
  }

  double adjustCaloriesForGoal({
    required double tdee,
    required double targetWeeklyWeightChangeKg,
  }) {
    // Negative to lose, positive to gain
    double calorieAdjustment = targetWeeklyWeightChangeKg * 7700 / 7;
    return tdee + calorieAdjustment;
  }

  Map<String, double> calculateMacros(double totalCalories) {
    double proteinCalories = totalCalories * 0.25;
    double fatCalories = totalCalories * 0.25;
    double carbCalories = totalCalories * 0.50;

    return {
      'protein_g': proteinCalories / 4,
      'fat_g': fatCalories / 9,
      'carbs_g': carbCalories / 4,
    };
  }
}
