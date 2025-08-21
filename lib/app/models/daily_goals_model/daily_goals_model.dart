import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_goals_model.freezed.dart';
part 'daily_goals_model.g.dart';

@freezed
class DailyGoalsModel with _$DailyGoalsModel {
  factory DailyGoalsModel({
    int? id,
    String? userId,
    DateTime? createdAt,
    String? goalType,
    String? goalDesc,
    int? energyReward,
    bool? isClaimed,
    int? currentValue,
    int? targetValue,
  }) = _DailyGoalsModel;

  factory DailyGoalsModel.fromJson(Map<String, dynamic> json) => _$DailyGoalsModelFromJson(json);
}

List<DailyGoalsModel> generateDailyGoals(
    {required int currentCalorie, required int currentProtein, required int currentMealCount}) {
  final today = DateTime.now();
  final user = SharedPreferenceHandler().getUser();
  final plan = SharedPreferenceHandler().getPlan();

  return [
    DailyGoalsModel(
      userId: user?.userId,
      createdAt: today,
      goalType: GoalType.CALORIE.value,
      goalDesc: S.current.calorieGoalDesc,
      energyReward: 10,
      isClaimed: false,
      currentValue: currentCalorie,
      targetValue: plan?.calorieKcal?.toInt(),
    ),
    DailyGoalsModel(
      userId: user?.userId,
      createdAt: today,
      goalType: GoalType.PROTEIN.value,
      goalDesc: S.current.proteinGoalDesc,
      energyReward: 10,
      isClaimed: false,
      currentValue: currentProtein,
      targetValue: plan?.proteinG?.toInt(),
    ),
    DailyGoalsModel(
      userId: user?.userId,
      createdAt: today,
      goalType: GoalType.MEALS.value,
      goalDesc: S.current.mealsGoalDesc,
      energyReward: 10,
      isClaimed: false,
      currentValue: currentMealCount,
      targetValue: 4,
    )
  ];
}

enum GoalType {
  CALORIE('calorie'),
  PROTEIN('protein'),
  MEALS('meals');

  final String value;
  const GoalType(this.value);
}
