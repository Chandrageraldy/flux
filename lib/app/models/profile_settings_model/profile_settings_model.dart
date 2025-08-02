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

List<ProfileSettingsModel> personalInfo = [
  ProfileSettingsModel(
    icon: FontAwesomeIcons.gear,
    label: S.current.accountLabel,
  ),
  ProfileSettingsModel(
    icon: FontAwesomeIcons.arrowRightFromBracket,
    label: S.current.logOutLabel,
  ),
];

List<ProfileSettingsModel> planCustomization(String currentCalorieRequired, String currentDietType) => [
      ProfileSettingsModel(
        icon: FontAwesomeIcons.solidUser,
        label: S.current.personalDetailsLabel,
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.fire,
        label: S.current.adjustCalorieIntakeLabel,
        desc: '$currentCalorieRequired ${S.current.adjustCalorieIntakeDesc}',
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.puzzlePiece,
        label: S.current.adjustMacroNutrientsLabel,
        desc: S.current.adjustMacroNutrientsDesc,
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.percent,
        label: S.current.mealRatioLabel,
        desc: S.current.mealRatioDesc,
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.apple,
        label: S.current.dietTypeLabel,
        desc: currentDietType,
      ),
    ];
