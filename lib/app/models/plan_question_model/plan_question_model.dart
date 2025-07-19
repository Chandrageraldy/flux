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
  targetWeightWeekly,
  activityLevel,
  exerciseLevel;

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
      case PlanSelectionKey.targetWeightWeekly:
        return 'targetWeekly';
      case PlanSelectionKey.activityLevel:
        return 'activityLevel';
      case PlanSelectionKey.exerciseLevel:
        return 'exerciseLevel';
    }
  }
}

enum PlanSelectionValue {
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
  frequent;

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
        icon: FaIcon(FontAwesomeIcons.venusMars),
        items: [S.current.maleLabel, S.current.femaleLabel],
      ),
      PlanPicker(
        key: PlanSelectionKey.height.key,
        title: S.current.heightLabel,
        description: S.current.heightDesc,
        unit: S.current.cmUnitLabel,
        icon: FaIcon(FontAwesomeIcons.person),
        // 100 to 250
        items: List.generate(151, (index) => (index + 100).toString()),
      ),
      PlanPicker(
        key: PlanSelectionKey.weight.key,
        title: S.current.weightLabel,
        description: S.current.weightDesc,
        unit: S.current.kgUnitLabel,
        icon: FaIcon(FontAwesomeIcons.weightScale),
        // 20 to 150
        items: List.generate(131, (index) => (index + 20).toString()),
      ),
      PlanPicker(
        key: PlanSelectionKey.dob.key,
        title: S.current.dateOfBirthLabel,
        description: S.current.dateOfBirthDesc,
        icon: FaIcon(FontAwesomeIcons.calendar),
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
        unit: S.current.kgUnitLabel,
        icon: FaIcon(FontAwesomeIcons.bullseye),
        // 20 to 150
        items: List.generate(131, (index) => (index + 20).toString()),
      ),
    ],
  ),
  PlanQuestion(
    key: PlanSelectionKey.targetWeightWeekly.key,
    title: S.current.planQuestion3,
    description: S.current.planDescription3,
    type: PlanSelectionQuestionType.picker,
    pickers: [
      PlanPicker(
        key: PlanSelectionKey.targetWeightWeekly.key,
        title: S.current.targetWeightWeeklyLabel,
        description: S.current.targetWeightWeeklyDesc,
        unit: S.current.kgUnitLabel,
        icon: FaIcon(FontAwesomeIcons.bullseye),
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
        icon: FaIcon(FontAwesomeIcons.couch),
      ),
      PlanOption(
        value: PlanSelectionValue.lightlyActive.value,
        title: S.current.lightlyActiveLabel,
        description: S.current.lightlyActiveDesc,
        icon: FaIcon(FontAwesomeIcons.personWalking),
      ),
      PlanOption(
        value: PlanSelectionValue.active.value,
        title: S.current.activeLabel,
        description: S.current.activeDesc,
        icon: FaIcon(FontAwesomeIcons.personRunning),
      ),
      PlanOption(
        value: PlanSelectionValue.veryActive.value,
        title: S.current.veryActiveLabel,
        description: S.current.veryActiveDesc,
        icon: FaIcon(FontAwesomeIcons.dumbbell),
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
        icon: FaIcon(FontAwesomeIcons.ban),
      ),
      PlanOption(
        value: PlanSelectionValue.light.value,
        title: S.current.lightLabel,
        description: S.current.lightDesc,
        icon: FaIcon(FontAwesomeIcons.shoePrints),
      ),
      PlanOption(
        value: PlanSelectionValue.moderate.value,
        title: S.current.moderateLabel,
        description: S.current.moderateDesc,
        icon: FaIcon(FontAwesomeIcons.personBiking),
      ),
      PlanOption(
        value: PlanSelectionValue.frequent.value,
        title: S.current.frequentLabel,
        description: S.current.frequentDesc,
        icon: FaIcon(FontAwesomeIcons.fire),
      ),
    ],
  ),
];
