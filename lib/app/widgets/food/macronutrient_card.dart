import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class MacronutrientCard extends StatelessWidget {
  const MacronutrientCard(
      {required this.label, required this.value, required this.percentage, required this.macroNutrient, super.key});

  final String label;
  final String value;
  final double percentage;
  final MacroNutrients macroNutrient;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        child: Padding(
          padding: AppStyles.kPaddSV8H16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [getLabel(context), getValueLabelWithUnit(context), getPercentageText(context)],
          ),
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MacronutrientCard {
  // Label
  Widget getLabel(BuildContext context) {
    return Text(
      label,
      style: _Styles.getLabelTextStyle(context),
    );
  }

  // Value Label With Unit
  Widget getValueLabelWithUnit(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [getMacroNutrientValueLabel(value, context), getMacroNutrientUnitLabel(context)],
      ),
    );
  }

  // Value Label
  TextSpan getMacroNutrientValueLabel(String macroNutrient, BuildContext context) {
    return TextSpan(
      text: macroNutrient,
      style: _Styles.getValueLabelTextStyle(context),
    );
  }

  // Unut Label
  TextSpan getMacroNutrientUnitLabel(BuildContext context) {
    return TextSpan(
      text: NutritionUnit.g.label,
      style: _Styles.getUnitLabelTextStyle(context),
    );
  }

  // Percentage Text
  Widget getPercentageText(BuildContext context) {
    return Text(
      '${(percentage * 100).toStringAsFixed(1)}%',
      style: _Styles.getPercentageTextStyle(context, macroNutrient),
    );
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
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Unit Label Text Style
  static TextStyle getUnitLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary);
  }

  // Percentage Text Style
  static TextStyle getPercentageTextStyle(BuildContext context, MacroNutrients macroNutrient) {
    Color color = macroNutrient == MacroNutrients.protein
        ? Color(0xFFdf9149)
        : macroNutrient == MacroNutrients.carbs
            ? Color(0xFF6bd0e9)
            : Color(0xFF7770c0);

    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: color);
  }
}
