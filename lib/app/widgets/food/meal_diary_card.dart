import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/widgets/food/meal_food_display_card.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealDiaryCard extends StatelessWidget {
  const MealDiaryCard({super.key, required this.mealType, required this.meals});

  final MealType mealType;
  final List<LoggedFoodModel> meals;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onHeaderTap(context),
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        width: AppStyles.kDoubleInfinity,
        child: Column(
          children: [
            getHeaderContainer(context),
            if (meals.isNotEmpty)
              ListView.separated(
                padding: AppStyles.kPadd16,
                itemCount: meals.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return MealFoodDisplayCard(meal: meal, onLoggedFoodTap: () => _onLoggedFoodTap(meal, context));
                },
                separatorBuilder: (_, __) => const SizedBox(height: AppStyles.kSize12),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('No meals logged', style: Theme.of(context).textTheme.bodySmall),
              ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MealDiaryCard {
  void _onHeaderTap(BuildContext context) {
    context.router.push(MealDetailsRoute(mealType: mealType));
  }

  void _onLoggedFoodTap(LoggedFoodModel loggedFood, BuildContext context) {
    if (loggedFood.source == LogSource.foodSearch.value) {
      context.router.push(FoodSearchLoggedFoodDetailsRoute(loggedFood: loggedFood));
    } else {
      context.router.push(
        MealScanLoggedFoodNavigatorRoute(loggedFood: loggedFood),
      );
    }
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on MealDiaryCard {
  Map<String, double> _calculateTotalNutrition(List<LoggedFoodModel>? meals) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    if (meals != null) {
      for (final meal in meals) {
        totalCalories += meal.calorieKcal ?? 0;
        totalProtein += meal.proteinG ?? 0;
        totalCarbs += meal.carbsG ?? 0;
        totalFat += meal.fatG ?? 0;
      }
    }

    double round2(double val) => double.parse(val.toStringAsFixed(2));

    return {
      Nutrition.calorie.key: round2(totalCalories),
      Nutrition.protein.key: round2(totalProtein),
      Nutrition.carbs.key: round2(totalCarbs),
      Nutrition.fat.key: round2(totalFat),
    };
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealDiaryCard {
  // Header Container
  Widget getHeaderContainer(BuildContext context) {
    final totalNutrition = _calculateTotalNutrition(meals);
    return Container(
      padding: AppStyles.kPaddOL16R16T16,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          Column(
            spacing: AppStyles.kSpac4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getMealTypeLabel(context),
              Row(
                spacing: AppStyles.kSpac4,
                children: [
                  getCalorieTag(context, totalNutrition[Nutrition.calorie.key] ?? 0),
                  getProteinTag(context, totalNutrition[Nutrition.protein.key] ?? 0),
                  getCarbsTag(context, totalNutrition[Nutrition.carbs.key] ?? 0),
                  getFatTag(context, totalNutrition[Nutrition.fat.key] ?? 0),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: AppStyles.kPadd6,
            decoration: BoxDecoration(color: context.theme.colorScheme.secondary, shape: BoxShape.circle),
            child: FaIcon(FontAwesomeIcons.add, color: context.theme.colorScheme.onSecondary, size: AppStyles.kSize16),
          )
        ],
      ),
    );
  }

  // Meal Type Label
  Widget getMealTypeLabel(BuildContext context) {
    return Text(mealType.label, style: _Styles.getMealTypeLabelTextStyle(context));
  }

  // Calorie Tag
  Widget getCalorieTag(BuildContext context, double value) {
    return NutritionTag(label: '$value', icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10));
  }

  // Protein Tag
  Widget getProteinTag(BuildContext context, double value) {
    return NutritionTag(label: '$value', tag: MacroNutrients.protein.tag);
  }

  // Carbs Tag
  Widget getCarbsTag(BuildContext context, double value) {
    return NutritionTag(label: '$value', tag: MacroNutrients.carbs.tag);
  }

  // Fat Tag
  Widget getFatTag(BuildContext context, double value) {
    return NutritionTag(label: '$value', tag: MacroNutrients.fat.tag);
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Meal Type Label Text Style
  static TextStyle getMealTypeLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withCustomSize(13).copyWith(color: context.theme.colorScheme.primary);
  }
}
