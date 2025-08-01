import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MacronutrientIntakeProgress extends StatelessWidget {
  const MacronutrientIntakeProgress({
    required this.macroNutrient,
    required this.percentage,
    required this.currentValue,
    required this.targetValue,
    super.key,
  });

  final MacroNutrients macroNutrient;
  final double percentage;
  final double currentValue;
  final double targetValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: AppStyles.kSpac4,
        children: [
          getLabel(context),
          getLinearProgressIndicator(context),
          getValueLabel(context),
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MacronutrientIntakeProgress {
  // Label
  Widget getLabel(BuildContext context) {
    return Text(macroNutrient.label, style: _Styles.getLabelTextStyle(context));
  }

  // Linear Progress Indicator
  Widget getLinearProgressIndicator(BuildContext context) {
    return LinearPercentIndicator(
      percent: percentage,
      backgroundColor: context.theme.colorScheme.tertiary,
      progressColor: _Styles.getLinearProgressIndicatorColor(macroNutrient),
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      padding: AppStyles.kPaddSH12,
      barRadius: Radius.circular(AppStyles.kSize20),
      lineHeight: AppStyles.kSize7,
    );
  }

  // Value Label
  Widget getValueLabel(BuildContext context) {
    return Text(
      '${currentValue.toStringAsFixed(0)} / ${targetValue.toStringAsFixed(0)}g',
      style: _Styles.getValueLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Linear Progress Indicator Color
  static Color getLinearProgressIndicatorColor(MacroNutrients macroNutrient) {
    return macroNutrient == MacroNutrients.protein
        ? MacroNutrients.protein.color
        : macroNutrient == MacroNutrients.carbs
            ? MacroNutrients.carbs.color
            : MacroNutrients.fat.color;
  }
}
