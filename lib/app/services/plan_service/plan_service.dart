import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';

class PlanService extends SupabaseBaseService {
  Future<Response> createPersonalizedPlan({required Map<String, dynamic> completeNutrients}) {
    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.plan,
      requestBody: completeNutrients,
    );
  }
}
