import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/daily_goals_model/daily_goals_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';

class DailyGoalsService extends SupabaseBaseService {
  Future<Response> checkIfDailyGoalsExist({required String userId}) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final startOfNextDay = startOfDay.add(Duration(days: 1));

    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.dailyGoals,
      filters: {TableCol.userId: userId},
      rangeFilters: {
        TableCol.createdAt: {
          'gte': startOfDay.toIso8601String(),
          'lt': startOfNextDay.toIso8601String(),
        },
      },
    );
  }

  Future<Response> createDailyGoal({required DailyGoalsModel goal}) async {
    final json = goal.toJson();
    json.remove(TableCol.id);

    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.dailyGoals,
      requestBody: json,
    );
  }

  Future<Response> updateCurrentValue({required int id, required int currentValue}) {
    return callSupabaseDB(
      requestType: RequestType.PUT,
      table: TableName.dailyGoals,
      filters: {TableCol.id: id},
      requestBody: {
        TableCol.currentValue: currentValue,
      },
    );
  }

  Future<Response> claimReward({required String userId, required int goalId}) {
    return callSupabaseDB(
      requestType: RequestType.PUT,
      table: TableName.dailyGoals,
      filters: {TableCol.id: goalId, TableCol.userId: userId},
      requestBody: {TableCol.isClaimed: true},
    );
  }
}
