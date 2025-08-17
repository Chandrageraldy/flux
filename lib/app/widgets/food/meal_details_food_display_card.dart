import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealDetailsFoodDisplayCard extends StatelessWidget {
  const MealDetailsFoodDisplayCard({super.key, required this.meal, required this.onLoggedFoodTap});

  final LoggedFoodModel meal;
  final VoidCallback onLoggedFoodTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLoggedFoodTap,
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        padding: AppStyles.kPaddSV8H12,
        child: Row(
          spacing: AppStyles.kSpac8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                spacing: AppStyles.kSpac4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.foodName ?? '',
                    style: _Styles.getLabelTextStyle(context),
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
                          '${meal.quantity} ${S.current.quantityLabel.toLowerCase()}',
                          style: Quicksand.medium.withSize(FontSizes.extraSmall),
                        ),
                      NutritionTag(
                          label: meal.calorieKcal.toString(),
                          icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10)),
                      NutritionTag(tag: MacroNutrients.protein.tag, label: meal.proteinG.toString()),
                      NutritionTag(tag: MacroNutrients.carbs.tag, label: meal.carbsG.toString()),
                      NutritionTag(tag: MacroNutrients.fat.tag, label: meal.fatG.toString()),
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
extension _WidgetFactories on MealDetailsFoodDisplayCard {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }

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
}
