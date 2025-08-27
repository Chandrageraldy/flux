import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/models/weight_log_model/weight_log_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';

class PlanService extends SupabaseBaseService {
  Future<Response> createPersonalizedPlan({required Map<String, dynamic> personalizedPlan}) {
    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.plan,
      requestBody: personalizedPlan,
    );
  }

  Future<Response> getPersonalizedPlan({required String userId}) {
    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.plan,
      filters: {TableCol.userId: userId},
    );
  }

  Future<Response> updatePersonalizedPlan({required Map<String, dynamic> personalizedPlan, required String userId}) {
    return callSupabaseDB(
      requestType: RequestType.PUT,
      table: TableName.plan,
      requestBody: personalizedPlan,
      filters: {TableCol.userId: userId},
    );
  }

  Future<Response> createWeightLog({required WeightLogModel model}) {
    final json = model.toJson();
    json.remove(TableCol.id);
    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.weightLog,
      requestBody: json,
    );
  }

  Future<Response> getWeightLogs({required String userId}) {
    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.weightLog,
      filters: {TableCol.userId: userId},
      orderBy: TableCol.createdAt,
      ascending: false,
      limit: 5,
    );
  }
}
