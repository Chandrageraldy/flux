import 'package:flutter/material.dart';
import 'package:flux/app/assets/app_router/app_router.dart';
import 'package:flux/generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsModel {
  ProfileSettingsModel({
    required this.icon,
    required this.label,
    this.desc,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String? desc;
  final dynamic route;
}

List<ProfileSettingsModel> personalInfo = [
  ProfileSettingsModel(
    icon: FontAwesomeIcons.gear,
    label: S.current.accountLabel,
    route: AccountRoute(),
  ),
  ProfileSettingsModel(
    icon: FontAwesomeIcons.arrowRightFromBracket,
    label: S.current.logOutLabel,
    route: '',
  ),
];

List<ProfileSettingsModel> planCustomization(String currentCalorieRequired, String currentDietType) => [
      ProfileSettingsModel(
          icon: FontAwesomeIcons.solidUser, label: S.current.personalDetailsLabel, route: PersonalDetailsRoute()),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.fire,
        label: S.current.adjustCalorieIntakeLabel,
        desc: '$currentCalorieRequired ${S.current.adjustCalorieIntakeDesc}',
        route: AdjustCalorieIntakeRoute(),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.puzzlePiece,
        label: S.current.adjustMacroNutrientsLabel,
        desc: S.current.adjustMacroNutrientsDesc,
        route: AdjustMacronutrientsRatioRoute(),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.percent,
        label: S.current.mealRatioLabel,
        desc: S.current.mealRatioDesc,
        route: MealRatioRoute(),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.apple,
        label: S.current.dietTypeLabel,
        desc: currentDietType,
        route: DietTypeRoute(),
      ),
    ];
