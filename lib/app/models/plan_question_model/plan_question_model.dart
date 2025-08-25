import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PlanSelectionQuestionType { options, picker }

enum PlanSelectionKey {
  goal,
  physique,
  gender,
  height,
  weight,
  dob,
  targetWeight,
  targetWeeklyChange,
  activityLevel,
  exerciseLevel,
  dietType;

  String get key {
    switch (this) {
      case goal:
        return 'goal';
      case PlanSelectionKey.physique:
        return 'physique';
      case PlanSelectionKey.gender:
        return 'gender';
      case PlanSelectionKey.height:
        return 'height';
      case PlanSelectionKey.weight:
        return 'weight';
      case PlanSelectionKey.dob:
        return 'dob';
      case PlanSelectionKey.targetWeight:
        return 'targetWeight';
      case PlanSelectionKey.targetWeeklyChange:
        return 'targetWeeklyChange';
      case PlanSelectionKey.activityLevel:
        return 'activityLevel';
      case PlanSelectionKey.exerciseLevel:
        return 'exerciseLevel';
      case PlanSelectionKey.dietType:
        return 'dietType';
    }
  }
}

enum PlanSelectionValue {
  male,
  female,
  lose,
  maintain,
  gain,
  sedentary,
  lightlyActive,
  active,
  veryActive,
  never,
  light,
  moderate,
  frequent,
  balanced,
  keto,
  mediterranean,
  paleo,
  vegetarian,
  lowCarbs,
  custom;

  String get value {
    switch (this) {
      case PlanSelectionValue.lose:
        return 'lose';
      case PlanSelectionValue.maintain:
        return 'maintain';
      case PlanSelectionValue.gain:
        return 'gain';
      case PlanSelectionValue.sedentary:
        return 'sedentary';
      case PlanSelectionValue.lightlyActive:
        return 'lightly active';
      case PlanSelectionValue.active:
        return 'active';
      case PlanSelectionValue.veryActive:
        return 'very active';
      case PlanSelectionValue.never:
        return 'never';
      case PlanSelectionValue.light:
        return 'light';
      case PlanSelectionValue.moderate:
        return 'moderate';
      case PlanSelectionValue.frequent:
        return 'frequent';
      case PlanSelectionValue.balanced:
        return 'balanced';
      case PlanSelectionValue.keto:
        return 'keto';
      case PlanSelectionValue.mediterranean:
        return 'mediterranean';
      case PlanSelectionValue.paleo:
        return 'paleo';
      case PlanSelectionValue.vegetarian:
        return 'vegetarian';
      case PlanSelectionValue.lowCarbs:
        return 'low carbs';
      case PlanSelectionValue.custom:
        return 'custom';
      case PlanSelectionValue.male:
        return 'male';
      case PlanSelectionValue.female:
        return 'female';
    }
  }
}

class PlanQuestion {
  final String key;
  final String title;
  final String description;
  final PlanSelectionQuestionType type;
  final List<PlanOption>? options;
  final List<PlanPicker>? pickers;

  PlanQuestion({
    required this.key,
    required this.title,
    required this.description,
    required this.type,
    this.options,
    this.pickers,
  });
}

class PlanOption {
  final String value;
  final String title;
  final String description;
  final FaIcon icon;

  PlanOption({
    required this.value,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class PlanPicker {
  final String key;
  final String title;
  final String description;
  final String? unit;
  final FaIcon icon;
  final List<String> items;

  PlanPicker({
    required this.key,
    required this.title,
    required this.description,
    this.unit,
    required this.icon,
    required this.items,
  });
}

final List<PlanQuestion> planQuestionData = [
  PlanQuestion(
    key: PlanSelectionKey.physique.key,
    title: S.current.planQuestion1,
    description: S.current.planDescription1,
    type: PlanSelectionQuestionType.picker,
    pickers: [
      PlanPicker(
        key: PlanSelectionKey.gender.key,
        title: S.current.genderLabel,
        description: S.current.genderDesc,
        icon: FaIcon(FontAwesomeIcons.venusMars, size: AppStyles.kSize16),
        items: [PlanSelectionValue.male.value, PlanSelectionValue.female.value],
      ),
      PlanPicker(
        key: PlanSelectionKey.height.key,
        title: S.current.heightLabel,
        description: S.current.heightDesc,
        unit: Unit.cm.label,
        icon: FaIcon(FontAwesomeIcons.person, size: AppStyles.kSize16),
        // 100 to 250
        items: List.generate(151, (index) => (index + 100).toString()),
      ),
      PlanPicker(
        key: PlanSelectionKey.weight.key,
        title: S.current.weightLabel,
        description: S.current.weightDesc,
        unit: Unit.kg.label,
        icon: FaIcon(FontAwesomeIcons.weightScale, size: AppStyles.kSize16),
        // 20 to 150
        items: List.generate(131, (index) => (index + 20).toString()),
      ),
      PlanPicker(
        key: PlanSelectionKey.dob.key,
        title: S.current.dateOfBirthLabel,
        description: S.current.dateOfBirthDesc,
        icon: FaIcon(FontAwesomeIcons.calendar, size: AppStyles.kSize16),
        items: [],
      ),
    ],
  ),
  PlanQuestion(
    key: PlanSelectionKey.targetWeight.key,
    title: S.current.planQuestion2,
    description: S.current.planDescription2,
    type: PlanSelectionQuestionType.picker,
    pickers: [
      PlanPicker(
        key: PlanSelectionKey.targetWeight.key,
        title: S.current.targetWeightLabel,
        description: S.current.targetWeightDesc,
        unit: Unit.kg.label,
        icon: FaIcon(FontAwesomeIcons.bullseye, size: AppStyles.kSize16),
        // 20 to 150
        items: List.generate(131, (index) => (index + 20).toString()),
      ),
    ],
  ),
  PlanQuestion(
    key: PlanSelectionKey.targetWeeklyChange.key,
    title: S.current.planQuestion3,
    description: S.current.planDescription3,
    type: PlanSelectionQuestionType.picker,
    pickers: [
      PlanPicker(
        key: PlanSelectionKey.targetWeeklyChange.key,
        title: S.current.targetWeightWeeklyLabel,
        description: S.current.targetWeightWeeklyDesc,
        unit: Unit.kg.label,
        icon: FaIcon(FontAwesomeIcons.bullseye, size: AppStyles.kSize16),
        // 0.10 to 1
        items: List.generate(19, (index) => (0.1 + index * 0.05).toStringAsFixed(2)),
      ),
    ],
  ),
  PlanQuestion(
    key: PlanSelectionKey.activityLevel.key,
    title: S.current.planQuestion4,
    description: S.current.planDescription4,
    type: PlanSelectionQuestionType.options,
    options: [
      PlanOption(
        value: PlanSelectionValue.sedentary.value,
        title: S.current.sedentaryLabel,
        description: S.current.sedentaryDesc,
        icon: FaIcon(FontAwesomeIcons.couch, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.lightlyActive.value,
        title: S.current.lightlyActiveLabel,
        description: S.current.lightlyActiveDesc,
        icon: FaIcon(FontAwesomeIcons.personWalking, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.active.value,
        title: S.current.activeLabel,
        description: S.current.activeDesc,
        icon: FaIcon(FontAwesomeIcons.personRunning, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.veryActive.value,
        title: S.current.veryActiveLabel,
        description: S.current.veryActiveDesc,
        icon: FaIcon(FontAwesomeIcons.dumbbell, size: AppStyles.kSize16),
      ),
    ],
  ),
  PlanQuestion(
    key: PlanSelectionKey.exerciseLevel.key,
    title: S.current.planQuestion5,
    description: S.current.planDescription5,
    type: PlanSelectionQuestionType.options,
    options: [
      PlanOption(
        value: PlanSelectionValue.never.value,
        title: S.current.neverLabel,
        description: S.current.neverDesc,
        icon: FaIcon(FontAwesomeIcons.ban, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.light.value,
        title: S.current.lightLabel,
        description: S.current.lightDesc,
        icon: FaIcon(FontAwesomeIcons.shoePrints, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.moderate.value,
        title: S.current.moderateLabel,
        description: S.current.moderateDesc,
        icon: FaIcon(FontAwesomeIcons.personBiking, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.frequent.value,
        title: S.current.frequentLabel,
        description: S.current.frequentDesc,
        icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize16),
      ),
    ],
  ),
  PlanQuestion(
    key: PlanSelectionKey.dietType.key,
    title: S.current.planQuestion6,
    description: S.current.planDescription6,
    type: PlanSelectionQuestionType.options,
    options: [
      PlanOption(
        value: PlanSelectionValue.balanced.value,
        title: S.current.balancedLabel,
        description: S.current.balancedDesc,
        icon: FaIcon(FontAwesomeIcons.appleWhole, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.vegetarian.value,
        title: S.current.vegetarianLabel,
        description: S.current.vegetarianDesc,
        icon: FaIcon(FontAwesomeIcons.leaf, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.keto.value,
        title: S.current.ketoLabel,
        description: S.current.ketoDesc,
        icon: FaIcon(FontAwesomeIcons.egg, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.mediterranean.value,
        title: S.current.mediterraneanLabel,
        description: S.current.mediterraneanDesc,
        icon: FaIcon(FontAwesomeIcons.fish, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.paleo.value,
        title: S.current.paleoLabel,
        description: S.current.paleoDesc,
        icon: FaIcon(FontAwesomeIcons.drumstickBite, size: AppStyles.kSize16),
      ),
      PlanOption(
        value: PlanSelectionValue.lowCarbs.value,
        title: S.current.lowCarbsLabel,
        description: S.current.lowCarbsDesc,
        icon: FaIcon(FontAwesomeIcons.cheese, size: AppStyles.kSize16),
      ),
    ],
  ),
];
