import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class MealMacronutrientIntakeProgress extends StatelessWidget {
  const MealMacronutrientIntakeProgress({
    required this.macroNutrient,
    required this.percentage,
    required this.currentValue,
    required this.targetValue,
    super.key,
  });

  final MacroNutrients macroNutrient;
  final double percentage;
  final int currentValue;
  final int targetValue;

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
      percent: percentage > 1 ? 1 : percentage,
      backgroundColor: context.theme.colorScheme.tertiary,
      progressColor: _Styles.getLinearProgressIndicatorColor(macroNutrient),
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: 6,
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
      '$currentValue/$targetValue ${NutritionUnit.g.label}',
      style: _Styles.getValueLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
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
    return Quicksand.bold.withCustomSize(11);
  }

  // Macro Nutrient Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withCustomSize(11).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
