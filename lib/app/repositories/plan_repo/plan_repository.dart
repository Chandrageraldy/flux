import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/services/plan_service/plan_service.dart';

class PlanRepository {
  final PlanService planService = PlanService();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();

  Future<Response> createPersonalizedPlan(Map<String, dynamic> completeNutrients) async {
    // Add userId to the completeNutrients map
    final userProfile = sharedPreferenceHandler.getUser();
    completeNutrients[TableCol.userId] = userProfile?.userId ?? '';

    final response = await planService.createPersonalizedPlan(completeNutrients: completeNutrients);
    if (response.error == null) {
      await processPersonalizedPlan(response.data as List<Map<String, dynamic>>);
    }
    return response;
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on PlanRepository {
  Future<void> processPersonalizedPlan(List<Map<String, dynamic>> plan) async {
    PlanModel model = PlanModel.fromJson(plan[0]);

    await sharedPreferenceHandler.putPlan(model);
    // ignore: avoid_print
    print(sharedPreferenceHandler.getPlan());
  }
}
