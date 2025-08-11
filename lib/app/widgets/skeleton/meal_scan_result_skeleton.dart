import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class MealScanResultSkeleton extends StatelessWidget {
  const MealScanResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppStyles.kSpac16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHeader(),
        getNutritionScoreContainer(),
        getCalorieContainer(),
        getMacronutrientsRow(),
        getIngredients(),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealScanResultSkeleton {
  // Header
  Widget getHeader() {
    return Row(
      spacing: AppStyles.kSpac12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            spacing: AppStyles.kSpac8,
            children: [Skeleton(height: AppStyles.kSize20), Skeleton(height: AppStyles.kSize20)],
          ),
        ),
        Expanded(flex: 1, child: Skeleton(height: AppStyles.kSize28)),
      ],
    );
  }

  // Nutrition Score Container
  Widget getNutritionScoreContainer() {
    return Skeleton(
      width: AppStyles.kDoubleInfinity,
      height: AppStyles.kSize70,
    );
  }

  // Calorie Container
  Widget getCalorieContainer() {
    return Skeleton(
      width: AppStyles.kDoubleInfinity,
      height: AppStyles.kSize50,
    );
  }

  // Macronutrients Row
  Widget getMacronutrientsRow() {
    return Row(
      spacing: AppStyles.kSpac12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Skeleton(height: AppStyles.kSize45)),
        Expanded(child: Skeleton(height: AppStyles.kSize45)),
        Expanded(child: Skeleton(height: AppStyles.kSize45)),
      ],
    );
  }

  // Ingredients
  Widget getIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac16,
      children: [
        FractionallySizedBox(widthFactor: 0.3, child: Skeleton(height: AppStyles.kSize20)),
        Skeleton(width: AppStyles.kDoubleInfinity, height: AppStyles.kSize50),
        Skeleton(width: AppStyles.kDoubleInfinity, height: AppStyles.kSize50),
        Skeleton(width: AppStyles.kDoubleInfinity, height: AppStyles.kSize50),
      ],
    );
  }
}

class MealScanActionButtonRowSkeleton extends StatelessWidget {
  const MealScanActionButtonRowSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Skeleton(height: AppStyles.kSize40));
  }
}
