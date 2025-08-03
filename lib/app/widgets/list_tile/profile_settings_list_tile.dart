import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsListTile extends StatelessWidget {
  const ProfileSettingsListTile({required this.icon, required this.label, this.desc, required this.onTap, super.key});

  final IconData icon;
  final String label;
  final String? desc;
  final VoidCallback onTap;

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
              children: [
                SizedBox(height: AppStyles.kSize20, width: AppStyles.kSize20, child: getIcon(context)),
                AppStyles.kSizedBoxW10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [getLabel(context), getDesc(context)],
                ),
              ],
            ),
            getChevronIcon(context),
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ProfileSettingsListTile {
  // Icon
  Widget getIcon(BuildContext context) {
    return FaIcon(
      icon,
      size: AppStyles.kSize20,
      color: icon == FontAwesomeIcons.arrowRightFromBracket ? AppColors.redColor : context.theme.colorScheme.secondary,
    );
  }

  // Label
  Widget getLabel(BuildContext context) {
    return Text(
      label,
      style: _Styles.getLabelTextStyle(context),
    );
  }

  // Chevron Icon
  Widget getChevronIcon(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.chevronRight,
      size: AppStyles.kSize12,
      color: context.theme.colorScheme.onTertiaryContainer,
    );
  }

  // Desc
  Widget getDesc(BuildContext context) {
    if (desc == null) return const SizedBox.shrink();
    return Text(desc!, style: _Styles.getDescTextStyle(context));
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }

  // Desc Text Style
  static TextStyle getDescTextStyle(BuildContext context) {
    return Quicksand.regular
        .withSize(FontSizes.extraSmall)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
