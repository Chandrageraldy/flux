import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class MealMacronutrientIntakeProgress extends StatelessWidget {
  const MealMacronutrientIntakeProgress({required this.macroNutrient, super.key});

  final MacroNutrients macroNutrient;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [getMacroNutrientLabel(context), getMacroNutrientValueLabel(context)],
        ),
        getLinearProgressIndicator(context),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealMacronutrientIntakeProgress {
  // Macro Nutrient Linear Percent Indicator
  Widget getLinearProgressIndicator(BuildContext context) {
    return LinearPercentIndicator(
      percent: 0.7,
      backgroundColor: context.theme.colorScheme.tertiary,
      progressColor: _Styles.getLinearProgressIndicatorColor(macroNutrient),
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: _Styles.linearPercentIndicatorLineHeight,
    );
  }

  // Macro Nutrient Label
  Widget getMacroNutrientLabel(BuildContext context) {
    return Text(
      macroNutrient.label,
      style: _Styles.getMacroNutrientLabelTextStyle(context),
    );
  }

  // Macro Nutrient Value Label
  Widget getMacroNutrientValueLabel(BuildContext context) {
    return Text(
      '50/120 g',
      style: _Styles.getValueLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Linear Percent Indicator Line Height
  static const double linearPercentIndicatorLineHeight = 6.0;

  // Linear Progress Indicator Color
  static Color getLinearProgressIndicatorColor(MacroNutrients macroNutrient) {
    return macroNutrient == MacroNutrients.protein
        ? MacroNutrients.protein.color
        : macroNutrient == MacroNutrients.carbs
            ? MacroNutrients.carbs.color
            : MacroNutrients.fat.color;
  }

  // Macro Nutrient Label Text Style
  static TextStyle getMacroNutrientLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.bold.withSize(FontSizes.small);
  }

  // Macro Nutrient Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.medium
        .withSize(FontSizes.small)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
