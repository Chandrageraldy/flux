import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsListTile extends StatelessWidget {
  const ProfileSettingsListTile({required this.icon, required this.label, this.desc, super.key});

  final IconData icon;
  final String label;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(height: AppStyles.kSize20, width: AppStyles.kSize20, child: getIcon(context)),
            AppStyles.kSizedBoxW10,
            getLabel(context),
          ],
        ),
        getChevronIcon(),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ProfileSettingsListTile {
  // Icon
  Widget getIcon(BuildContext context) {
    return FaIcon(icon, size: AppStyles.kSize20, color: context.theme.colorScheme.secondary);
  }

  // Label
  Widget getLabel(BuildContext context) {
    return Text(
      label,
      style: _Styles.getLabelTextStyle(context),
    );
  }

  // Chevron Icon
  Widget getChevronIcon() {
    return FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kSize12);
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }
}
