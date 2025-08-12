import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealFoodDisplayCard extends StatelessWidget {
  const MealFoodDisplayCard({super.key, required this.meal});

  final LoggedFoodModel meal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: AppStyles.kSpac4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meal.foodName ?? '', style: _Styles.labelTextStyle(context)),
            Row(
              spacing: AppStyles.kSpac4,
              children: [
                NutritionTag(
                    label: meal.calorieKcal.toString(), icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10)),
                NutritionTag(tag: MacroNutrients.protein.tag, label: meal.proteinG.toString()),
                NutritionTag(tag: MacroNutrients.carbs.tag, label: meal.carbsG.toString()),
                NutritionTag(tag: MacroNutrients.fat.tag, label: meal.fatG.toString()),
              ],
            ),
          ],
        ),
        FaIcon(FontAwesomeIcons.bars, size: AppStyles.kSize16)
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealFoodDisplayCard {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle labelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small);
  }
}
