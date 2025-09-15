import 'package:flux/app/models/daily_goals_model/daily_goals_model.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/services/daily_goals_service/daily_goals_service.dart';

class DailyGoalsRepository {
  DailyGoalsService dailyGoalsService = DailyGoalsService();

  Future<Response> getDailyGoals({
    required String userId,
    required int totalCalories,
    required int totalProtein,
    required int totalMeals,
  }) async {
    final checkResponse = await dailyGoalsService.checkIfDailyGoalsExist(userId: userId);

    List<DailyGoalsModel> updatedOrCreatedGoals = [];

    if (checkResponse.error == null) {
      List retrievedData = checkResponse.data ?? [];

      if (retrievedData.isNotEmpty) {
        for (var row in retrievedData) {
          final goal = DailyGoalsModel.fromJson(row);

          int newCurrentValue = 0;
          if (goal.goalType == GoalType.CALORIE.value) {
            newCurrentValue = totalCalories;
          } else if (goal.goalType == GoalType.PROTEIN.value) {
            newCurrentValue = totalProtein;
          } else if (goal.goalType == GoalType.MEALS.value) {
            newCurrentValue = totalMeals;
          }

          final updateResponse =
              await dailyGoalsService.updateCurrentValue(id: goal.id!, currentValue: newCurrentValue);

          if (updateResponse.error == null) {
            final row = updateResponse.data[0];
            updatedOrCreatedGoals.add(DailyGoalsModel.fromJson(row));
          } else {
            return updateResponse;
          }
        }

        return Response.complete(updatedOrCreatedGoals);
      } else {
        // Create new goals
        final dailyGoals = generateDailyGoals(
          currentCalorie: totalCalories,
          currentProtein: totalProtein,
          currentMealCount: totalMeals,
        );

        for (var goal in dailyGoals) {
          final createResponse = await dailyGoalsService.createDailyGoal(goal: goal);

          if (createResponse.error == null) {
            final row = createResponse.data[0];
            updatedOrCreatedGoals.add(DailyGoalsModel.fromJson(row));
          } else {
            return createResponse;
          }
        }

        return Response.complete(updatedOrCreatedGoals);
      }
    }

    return checkResponse;
  }

  Future<Response> claimReward({
    required String userId,
    required int goalId,
  }) async {
    final response = await dailyGoalsService.claimReward(userId: userId, goalId: goalId);
    if (response.error == null) {
      List<Map<String, dynamic>> updatedResponse = response.data;
      DailyGoalsModel model = DailyGoalsModel.fromJson(updatedResponse[0]);
      return Response.complete(model);
    }

    return response;
  }
}
