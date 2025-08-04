import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsListTile extends StatelessWidget {
  const ProfileSettingsListTile({
    this.leadingIcon,
    required this.label,
    this.desc,
    this.onTap,
    this.value,
    this.trailingIcon,
    this.trailingIconColor,
    super.key,
  });

  final IconData? leadingIcon;
  final String label;
  final String? desc;
  final VoidCallback? onTap;
  final String? value;
  final IconData? trailingIcon;
  final Color? trailingIconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: context.theme.colorScheme.onPrimary,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppStyles.kSpac12,
              children: [
                if (leadingIcon != null) getLeadingIcon(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [getLabel(context), if (desc != null) getDesc(context)],
                ),
              ],
            ),
            Row(
              spacing: AppStyles.kSpac12,
              children: [
                if (value != null) Text(value!, style: Quicksand.regular.withSize(FontSizes.small)),
                getTrailingIcon(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ProfileSettingsListTile {
  // Leading Icon
  Widget getLeadingIcon(BuildContext context) {
    return SizedBox(
      height: AppStyles.kSize20,
      width: AppStyles.kSize20,
      child: FaIcon(
        leadingIcon,
        size: AppStyles.kSize20,
        color: leadingIcon == FontAwesomeIcons.arrowRightFromBracket
            ? AppColors.redColor
            : context.theme.colorScheme.secondary,
      ),
    );
  }

  // Label
  Widget getLabel(BuildContext context) {
    return Text(label, style: _Styles.getLabelTextStyle(context));
  }

  // Chevron Icon
  Widget getTrailingIcon(BuildContext context) {
    return FaIcon(
      trailingIcon ?? FontAwesomeIcons.chevronRight,
      size: AppStyles.kSize12,
      color: trailingIconColor ?? context.theme.colorScheme.onTertiaryContainer,
    );
  }

  // Desc
  Widget getDesc(BuildContext context) {
    return Text(desc!, style: _Styles.getDescTextStyle(context));
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Desc Text Style
  static TextStyle getDescTextStyle(BuildContext context) {
    return Quicksand.regular
        .withSize(FontSizes.extraSmall)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
