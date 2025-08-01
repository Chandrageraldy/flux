import 'package:flutter/material.dart';
import 'package:flux/generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsModel {
  ProfileSettingsModel({
    required this.icon,
    required this.label,
    this.desc,
  });

  final IconData icon;
  final String label;
  final String? desc;
}

List<ProfileSettingsModel> profileSettings = [
  ProfileSettingsModel(
    icon: FontAwesomeIcons.gear,
    label: S.current.accountLabel,
  ),
  ProfileSettingsModel(
    icon: FontAwesomeIcons.solidUser,
    label: S.current.personalDetailsLabel,
  ),
];
