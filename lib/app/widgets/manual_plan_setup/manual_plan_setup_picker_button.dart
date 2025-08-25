import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManualPlanSetupPickerButton extends StatelessWidget {
  const ManualPlanSetupPickerButton({
    required this.title,
    required this.pickedValue,
    required this.icon,
    required this.onPressed,
    required this.unit,
    required this.isPicked,
    super.key,
  });

  final String title;
  final String pickedValue;
  final FaIcon icon;
  final VoidCallback onPressed;
  final String unit;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: _Styles.getButtonContainerDecoration(context, isPicked),
        width: AppStyles.kDoubleInfinity,
        child: Padding(
          padding: AppStyles.kPaddSV8H12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [getIconContainer(context), AppStyles.kSizedBoxW12, getTextColumn(context)],
          ),
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ManualPlanSetupPickerButton {
  // Get Icon Container
  Widget getIconContainer(BuildContext context) {
    return Container(
      width: AppStyles.kSize40,
      height: AppStyles.kSize40,
      decoration: _Styles.getIconContainerDecoration(context, isPicked),
      child: Center(child: icon),
    );
  }

  // Get Text Column
  Widget getTextColumn(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitleLabel(context),
          Row(
            children: [getPickedValueLabel(context), AppStyles.kSizedBoxW4, getUnitLabel(context)],
          ),
        ],
      ),
    );
  }

  // Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(title, style: _Styles.getTitleLabelTextStyle(context, isPicked));
  }

  // Picked Value Label
  Widget getPickedValueLabel(BuildContext context) {
    return Text(pickedValue, style: _Styles.getDescriptionLabelTextStyle(context, isPicked));
  }

  // Unit Label
  Widget getUnitLabel(BuildContext context) {
    return Text(unit, style: _Styles.getDescriptionLabelTextStyle(context, isPicked));
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Label Text Style
  static getTitleLabelTextStyle(BuildContext context, bool isPicked) {
    return Quicksand.semiBold
        .withSize(FontSizes.medium)
        .copyWith(color: isPicked ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiary);
  }

  // Description Label Text Style
  static getDescriptionLabelTextStyle(BuildContext context, bool isPicked) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(
        color: isPicked ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiaryContainer);
  }

  // Button Container Decoration
  static BoxDecoration getButtonContainerDecoration(BuildContext context, bool isPicked) {
    return BoxDecoration(
      borderRadius: AppStyles.kRad16,
      color: isPicked ? context.theme.colorScheme.secondary.withAlpha(150) : context.theme.colorScheme.onPrimary,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Icon Container Decoration
  static BoxDecoration getIconContainerDecoration(BuildContext context, bool isPicked) {
    return isPicked
        ? BoxDecoration(gradient: GradientAppColors.primaryGradient, borderRadius: AppStyles.kRad100)
        : BoxDecoration(color: context.theme.colorScheme.tertiaryContainer, borderRadius: AppStyles.kRad100);
  }
}
