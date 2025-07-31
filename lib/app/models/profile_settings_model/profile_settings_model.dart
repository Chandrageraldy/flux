import 'package:flux/generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsModel {
  ProfileSettingsModel({
    required this.icon,
    required this.label,
    this.desc,
  });

  final FaIcon icon;
  final String label;
  final String? desc;
}

List<ProfileSettingsModel> profileSettings = [
  ProfileSettingsModel(
    icon: FaIcon(FontAwesomeIcons.solidUser),
    label: S.current.profileLabel,
  ),
  ProfileSettingsModel(
    icon: FaIcon(FontAwesomeIcons.gear),
    label: S.current.accountLabel,
  ),
];
