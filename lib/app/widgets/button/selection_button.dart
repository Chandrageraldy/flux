import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String description;
  final FaIcon icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: _Styles.getButtonContainerDecoration(context),
        width: AppStyles.kDoubleInfinity,
        child: Padding(
          padding: AppStyles.kPadd12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getIconContainer(context),
              AppStyles.kSizedBoxW12,
              getTextColumn(context),
              AppStyles.kSizedBoxW12,
              getArrowIcon(context),
            ],
          ),
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on SelectionButton {
  // Icon Container
  Widget getIconContainer(BuildContext context) {
    return Container(
        width: 48, height: 48, decoration: _Styles.getIconContainerDecoration(context), child: Center(child: icon));
  }

  // Arrow Icon
  Widget getArrowIcon(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddOR12,
      child: FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kIconSize16),
    );
  }

  // Text Column
  Widget getTextColumn(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [getTitleLabel(context), getDescriptionLabel(context)],
      ),
    );
  }

  // Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(title, style: _Styles.getTitleLabelTextStyle(context));
  }

  // Description Label
  Widget getDescriptionLabel(BuildContext context) {
    return Text(description,
        style: _Styles.getDescriptionLabelTextStyle(context), maxLines: 2, overflow: TextOverflow.ellipsis);
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Text Style
  static getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.mediumPlus).copyWith(color: context.theme.colorScheme.primary);
  }

  // Description Text Style
  static getDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.light.withSize(FontSizes.mediumPlus).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Button Container Decoration
  static BoxDecoration getButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: AppStyles.kRad16,
      color: context.theme.colorScheme.onPrimary,
      border: Border.all(width: 1, color: context.theme.colorScheme.tertiary),
    );
  }

  // Icon Container Decoration
  static BoxDecoration getIconContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.tertiaryContainer, borderRadius: AppStyles.kRad100);
  }
}
