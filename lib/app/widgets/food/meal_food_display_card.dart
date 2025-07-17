import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealFoodDisplayCard extends StatelessWidget {
  const MealFoodDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getContainerDecoration(context),
      padding: AppStyles.kPaddSV6H12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: AppStyles.kSpac4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nasi Lemak', style: _Styles.labelTextStyle(context)),
              Row(
                spacing: AppStyles.kSpac8,
                children: [
                  NutritionTag(
                    tag: S.current.calorieUnit,
                    label: '245',
                    icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kIconSize16),
                  ),
                  NutritionTag(tag: 'P', label: '31'),
                  NutritionTag(tag: 'C', label: '20'),
                  NutritionTag(tag: 'F', label: '62'),
                ],
              ),
            ],
          ),
          FaIcon(FontAwesomeIcons.bars, size: AppStyles.kIconSize16)
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealFoodDisplayCard {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.surface,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Label Text Style
  static TextStyle labelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium);
  }
}
