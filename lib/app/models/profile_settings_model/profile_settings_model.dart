import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsModel {
  ProfileSettingsModel({
    this.icon,
    required this.label,
    this.desc,
    required this.onTap,
  });

  final IconData? icon;
  final String label;
  final String? desc;
  final VoidCallback onTap;
}

List<ProfileSettingsModel> personalInfo(BuildContext context, VoidCallback logoutPressed) => [
      ProfileSettingsModel(
        icon: FontAwesomeIcons.gear,
        label: S.current.accountLabel,
        onTap: () => context.router.push(AccountRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.arrowRightFromBracket,
        label: S.current.logOutLabel,
        onTap: logoutPressed,
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

enum PersonalDetailsSettings {
  dob,
  gender,
  weight,
  height,
  activityLevel,
  exerciseLevel;

  String get key {
    switch (this) {
      case PersonalDetailsSettings.dob:
        return 'dob';
      case PersonalDetailsSettings.gender:
        return 'gender';
      case PersonalDetailsSettings.weight:
        return 'weight';
      case PersonalDetailsSettings.height:
        return 'height';
      case PersonalDetailsSettings.activityLevel:
        return 'activityLevel';
      case PersonalDetailsSettings.exerciseLevel:
        return 'exerciseLevel';
    }
  }

  String get label {
    switch (this) {
      case PersonalDetailsSettings.dob:
        return S.current.dateOfBirthLabel;
      case PersonalDetailsSettings.gender:
        return S.current.genderLabel;
      case PersonalDetailsSettings.weight:
        return S.current.weightLabel;
      case PersonalDetailsSettings.height:
        return S.current.heightLabel;
      case PersonalDetailsSettings.activityLevel:
        return S.current.activityLevelLabel;
      case PersonalDetailsSettings.exerciseLevel:
        return S.current.exerciseLevelLabel;
    }
  }
}

class PersonalDetailsModel {
  PersonalDetailsModel({
    required this.label,
    required this.key,
    this.unit,
    required this.items,
  });

  final String label;
  final String key;
  final String? unit;
  final List<String> items;
}

List<PersonalDetailsModel> personalDetails(BuildContext context) => [
      PersonalDetailsModel(
        label: PersonalDetailsSettings.dob.label,
        key: PersonalDetailsSettings.dob.key,
        items: [],
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.gender.label,
        key: PersonalDetailsSettings.gender.key,
        items: [PlanSelectionValue.male.value, PlanSelectionValue.female.value],
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.weight.label,
        key: PersonalDetailsSettings.weight.key,
        unit: Unit.kg.label,
        // 20 to 150
        items: List.generate(131, (index) => (index + 20).toString()),
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.height.label,
        key: PersonalDetailsSettings.height.key,
        unit: Unit.cm.label,
        // 100 to 250
        items: List.generate(151, (index) => (index + 100).toString()),
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.activityLevel.label,
        key: PersonalDetailsSettings.activityLevel.key,
        items: [
          PlanSelectionValue.sedentary.value,
          PlanSelectionValue.lightlyActive.value,
          PlanSelectionValue.active.value,
          PlanSelectionValue.veryActive.value,
        ],
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.exerciseLevel.label,
        key: PersonalDetailsSettings.exerciseLevel.key,
        items: [
          PlanSelectionValue.light.value,
          PlanSelectionValue.moderate.value,
          PlanSelectionValue.frequent.value,
          PlanSelectionValue.never.value
        ],
      ),
    ];
