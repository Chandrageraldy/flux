import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealFoodDisplayCard extends StatelessWidget {
  const MealFoodDisplayCard({super.key, required this.meal, required this.onLoggedFoodTap});

  final LoggedFoodModel meal;
  final VoidCallback onLoggedFoodTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLoggedFoodTap,
      child: Container(
        color: context.theme.colorScheme.onPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: AppStyles.kSpac8,
          children: [
            Expanded(
              child: Column(
                spacing: AppStyles.kSpac4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.foodName ?? '',
                    style: _Styles.labelTextStyle(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    spacing: AppStyles.kSpac4,
                    children: [
                      if (meal.servingQty != null && meal.servingUnit != null)
                        Text(
                          '${meal.servingQty} ${meal.servingUnit}',
                          style: Quicksand.medium.withSize(FontSizes.extraSmall),
                        ),
                      if (meal.quantity != null)
                        Text(
                          '${meal.quantity} quantity',
                          style: Quicksand.medium.withSize(FontSizes.extraSmall),
                        ),
                      NutritionTag(
                          label: meal.calorieKcal?.toStringAsFixed(0) ?? '',
                          icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10)),
                      NutritionTag(tag: MacroNutrients.protein.tag, label: meal.proteinG?.toStringAsFixed(0) ?? ''),
                      NutritionTag(tag: MacroNutrients.carbs.tag, label: meal.carbsG?.toStringAsFixed(0) ?? ''),
                      NutritionTag(tag: MacroNutrients.fat.tag, label: meal.fatG?.toStringAsFixed(0) ?? ''),
                    ],
                  ),
                ],
              ),
            ),
            FaIcon(FontAwesomeIcons.bars, size: AppStyles.kSize16)
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealFoodDisplayCard {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle labelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }
}
