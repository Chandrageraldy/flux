import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NutritionTag extends StatelessWidget {
  const NutritionTag({this.tag, required this.label, this.icon, super.key});

  final String? tag;
  final String label;
  final FaIcon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.kPaddSV3H6,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.tertiaryContainer,
        borderRadius: AppStyles.kRad10,
      ),
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          if (icon != null) icon!,
          Text.rich(
            TextSpan(
              children: [
                if (tag != null)
                  TextSpan(
                    text: '$tag ',
                    style: _Styles.getTagLabelTextStyle(context, tag!),
                  ),
                TextSpan(
                  text: label.toString(),
                  style: _Styles.getLabelTextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on NutritionTag {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Tag Label Text Style
  static TextStyle getTagLabelTextStyle(BuildContext context, String tag) {
    Color color = tag == MacroNutrients.protein.tag
        ? MacroNutrients.protein.color
        : tag == MacroNutrients.carbs.tag
            ? MacroNutrients.carbs.color
            : MacroNutrients.fat.color;

    return Quicksand.bold.withCustomSize(9).copyWith(color: color);
  }

  // Label Text Style
  static TextStyle getLabelTextStyle() {
    return Quicksand.medium.withSize(FontSizes.extraSmall);
  }
}
