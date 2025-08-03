import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsModel {
  ProfileSettingsModel({
    required this.icon,
    required this.label,
    this.desc,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? desc;
  final VoidCallback onTap;
}

List<ProfileSettingsModel> personalInfo(BuildContext context) => [
      ProfileSettingsModel(
          icon: FontAwesomeIcons.gear, label: S.current.accountLabel, onTap: () => context.router.push(AccountRoute())),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.arrowRightFromBracket,
        label: S.current.logOutLabel,
        onTap: () {},
      ),
    ];

List<ProfileSettingsModel> planCustomization(
        String currentCalorieRequired, String currentDietType, BuildContext context) =>
    [
      ProfileSettingsModel(
        icon: FontAwesomeIcons.solidUser,
        label: S.current.personalDetailsLabel,
        onTap: () => context.router.push(PersonalDetailsRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.fire,
        label: S.current.adjustCalorieIntakeLabel,
        desc: '$currentCalorieRequired ${S.current.adjustCalorieIntakeDesc}',
        onTap: () => context.router.push(AdjustCalorieIntakeRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.puzzlePiece,
        label: S.current.adjustMacroNutrientsLabel,
        desc: S.current.adjustMacroNutrientsDesc,
        onTap: () => context.router.push(AdjustMacronutrientsRatioRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.percent,
        label: S.current.mealRatioLabel,
        desc: S.current.mealRatioDesc,
        onTap: () => context.router.push(MealRatioRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.apple,
        label: S.current.dietTypeLabel,
        desc: currentDietType,
        onTap: () => context.router.push(DietTypeRoute()),
      ),
    ];
