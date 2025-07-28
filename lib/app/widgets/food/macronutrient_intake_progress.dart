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
        spacing: AppStyles.kSpac8,
        children: [
          getLabel(context),
          getLinearProgressIndicator(context),
          getValueLabel(context),
          AppStyles.kSizedBoxH2,
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
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: _Styles.linearPercentIndicatorLineHeight,
    );
  }

  // Value Label
  Widget getValueLabel(BuildContext context) {
    return Text(
      '${currentValue.toStringAsFixed(1)} / ${targetValue.toStringAsFixed(1)} g',
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

  // Linear Percent Indicator Line Height
  static const double linearPercentIndicatorLineHeight = 6.0;

  // Linear Progress Indicator Color
  static Color getLinearProgressIndicatorColor(MacroNutrients macroNutrient) {
    return macroNutrient == MacroNutrients.protein
        ? Color(0xFFdf9149)
        : macroNutrient == MacroNutrients.carbs
            ? Color(0xFF6bd0e9)
            : Color(0xFF7770c0);
  }
}
