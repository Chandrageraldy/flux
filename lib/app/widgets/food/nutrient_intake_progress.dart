import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class NutrientIntakeProgress extends StatelessWidget {
  const NutrientIntakeProgress({
    super.key,
    required this.nutrition,
    required this.percentage,
    required this.currentValue,
    required this.targetValue,
    this.lineHeight = 6,
  });

  final Nutrition nutrition;
  final double percentage;
  final int currentValue;
  final int targetValue;
  final double lineHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Expanded(child: getMacroNutrientLabel(context)), getMacroNutrientValueLabel(context)],
        ),
        getLinearProgressIndicator(context),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on NutrientIntakeProgress {
  // Macro Nutrient Linear Percent Indicator
  Widget getLinearProgressIndicator(BuildContext context) {
    return LinearPercentIndicator(
      percent: percentage > 1 ? 1 : percentage,
      backgroundColor: context.theme.colorScheme.tertiary,
      progressColor: _Styles.getProgressColor(context, nutrition),
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: lineHeight,
    );
  }

  Widget getMacroNutrientLabel(BuildContext context) {
    return Text(
      nutrition.label,
      style: _Styles.getMacroNutrientLabelTextStyle(context),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  // Macro Nutrient Value Label
  Widget getMacroNutrientValueLabel(BuildContext context) {
    return Text(
      '$currentValue/$targetValue ${nutrition.unit}',
      style: _Styles.getValueLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Macro Nutrient Label Text Style
  static TextStyle getMacroNutrientLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withCustomSize(11);
  }

  // Macro Nutrient Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withCustomSize(11).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Progress Color
  static Color getProgressColor(BuildContext context, Nutrition nutrition) {
    return nutrition == Nutrition.calorie
        ? context.theme.colorScheme.secondary
        : nutrition == Nutrition.protein
            ? MacroNutrients.protein.color
            : nutrition == Nutrition.carbs
                ? MacroNutrients.carbs.color
                : nutrition == Nutrition.fat
                    ? MacroNutrients.fat.color
                    : context.theme.colorScheme.primary;
  }
}
