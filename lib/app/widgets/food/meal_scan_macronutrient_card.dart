import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealScanMacronutrientCard extends StatelessWidget {
  const MealScanMacronutrientCard({required this.nutrient, required this.value, required this.icon, super.key});

  final MacroNutrients nutrient;
  final double value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: AppStyles.kPaddSV10H8,
        decoration: _Styles.getContainerDecoration(context),
        child: Row(
          spacing: AppStyles.kSpac8,
          children: [
            Container(
              height: AppStyles.kSize30,
              width: AppStyles.kSize30,
              decoration: _Styles.getIconContainerDecoration(context),
              child: Center(child: FaIcon(icon, size: AppStyles.kSize16, color: nutrient.color)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nutrient.label,
                    style: _Styles.getLabelTextStyle(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('${value}g', style: _Styles.getValueLabelTextStyle(context))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall);
  }

  // Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }

  // Icon Container Decoration
  static BoxDecoration getIconContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad100,
    );
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
