import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/services/plan_service/plan_service.dart';

class PlanRepository {
  final PlanService planService = PlanService();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();

  Future<Response> createPersonalizedPlan(Map<String, dynamic> personalizedPlan) async {
    // Add userId to the personalizedPlan map
    final userProfile = sharedPreferenceHandler.getUser();
    personalizedPlan[TableCol.userId] = userProfile?.userId ?? '';

    final response = await planService.createPersonalizedPlan(personalizedPlan: personalizedPlan);
    if (response.error == null) {
      await processPersonalizedPlan(response.data as List<Map<String, dynamic>>);
    }
    return response;
  }

  Future<Response> getPersonalizedPlan() async {
    final userProfile = sharedPreferenceHandler.getUser();
    final response = await planService.getPersonalizedPlan(userId: userProfile?.userId ?? '');
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
