import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealFoodDisplayCard extends StatelessWidget {
  const MealFoodDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: AppStyles.kSpac4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nasi Lemak', style: _Styles.labelTextStyle(context)),
            Row(
              spacing: AppStyles.kSpac4,
              children: [
                NutritionTag(label: '245', icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10)),
                NutritionTag(tag: MacroNutrients.protein.tag, label: '31'),
                NutritionTag(tag: MacroNutrients.carbs.tag, label: '20'),
                NutritionTag(tag: MacroNutrients.fat.tag, label: '62'),
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
