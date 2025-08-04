import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
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

List<ProfileSettingsModel> planCustomization(String currentCalorieRequired, BuildContext context) => [
      ProfileSettingsModel(
        icon: FontAwesomeIcons.solidUser,
        label: S.current.personalDetailsLabel,
        onTap: () => context.router.push(PersonalDetailsRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.puzzlePiece,
        label: S.current.nutritionGoalsLabel,
        desc: '$currentCalorieRequired ${S.current.adjustCalorieIntakeDesc}',
        onTap: () => context.router.push(PersonalDetailsRoute()),
      ),
      ProfileSettingsModel(
        icon: FontAwesomeIcons.percent,
        label: S.current.mealRatioLabel,
        desc: S.current.mealRatioDesc,
        onTap: () => context.router.push(MealRatioRoute()),
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
    this.desc,
  });

  final String label;
  final String key;
  final String? unit;
  final List<String> items;
  final String? desc;
}

List<PersonalDetailsModel> personalDetails(BuildContext context) => [
      PersonalDetailsModel(
        label: PersonalDetailsSettings.dob.label,
        key: PersonalDetailsSettings.dob.key,
        items: [],
        desc:
            '*"Your date of birth helps us tailor recommendations, track your progress accurately, and provide age-appropriate features. This information stays private."',
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.gender.label,
        key: PersonalDetailsSettings.gender.key,
        items: [PlanSelectionValue.male.value, PlanSelectionValue.female.value],
        desc:
            '*Some gender identities are not yet scientifically supported in existing research used for creating personalized plans. Please select the closest available option to proceed.',
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.weight.label,
        key: PersonalDetailsSettings.weight.key,
        unit: Unit.kg.label,
        // 20 to 150
        items: List.generate(131, (index) => (index + 20).toString()),
        desc:
            '*Used to estimate your daily calorie needs and track your progress. Please enter your current body weight as accurately as possible.',
      ),
      PersonalDetailsModel(
        label: PersonalDetailsSettings.height.label,
        key: PersonalDetailsSettings.height.key,
        unit: Unit.cm.label,
        // 100 to 250
        items: List.generate(151, (index) => (index + 100).toString()),
        desc:
            '*Helps calculate your body metrics like BMI and ideal caloric intake. Please provide your current height in centimeters.',
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
        desc: '*Your general daily movement:\n'
            '- Sedentary: Little to no physical activity.\n'
            '- Lightly Active: Occasional movement.\n'
            '- Active: Regular movement during the day.\n'
            '- Very Active: Physically demanding routine.',
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
        desc: '*How often you engage in intentional exercise:\n'
            '- Light: 1–2 times per week\n'
            '- Moderate: 3–4 times per week\n'
            '- Frequent: 5 or more times per week\n'
            '- Never: No regular exercise routine',
      ),
    ];
