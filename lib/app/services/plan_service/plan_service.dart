import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/response_model.dart';
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
}
