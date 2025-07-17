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
            children: [
              Text(label, style: _Styles.getLabelTextStyle(context)),
              Text('${value}g', style: _Styles.getValueLabelTextStyle(context)),
              Text(
                '${(percentage * 100).toStringAsFixed(1)}%',
                style: _Styles.getPercentageTextStyle(context, macroNutrient),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MacronutrientCard {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(
          color: context.theme.colorScheme.tertiaryFixedDim,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumPlus).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Value Label Text Style
  static TextStyle getValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.huge).copyWith(color: context.theme.colorScheme.primary);
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
