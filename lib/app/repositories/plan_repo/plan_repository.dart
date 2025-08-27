import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/weight_log_model/weight_log_model.dart';
import 'package:flux/app/services/plan_service/plan_service.dart';

class PlanRepository {
  final PlanService planService = PlanService();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();

  Future<Response> createPersonalizedPlan({required Map<String, dynamic> personalizedPlan}) async {
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

  Future<Response> updatePersonalizedPlan({required Map<String, dynamic> personalizedPlan}) async {
    final userProfile = sharedPreferenceHandler.getUser();
    personalizedPlan[TableCol.userId] = userProfile?.userId ?? '';

    final response =
        await planService.updatePersonalizedPlan(personalizedPlan: personalizedPlan, userId: userProfile?.userId ?? '');
    if (response.error == null) {
      await processPersonalizedPlan(response.data as List<Map<String, dynamic>>);
    }
    return response;
  }

  Future<Response> createWeightLog() async {
    final userProfile = sharedPreferenceHandler.getUser();
    int initialWeight = int.tryParse(userProfile?.bodyMetrics?.weight ?? '') ?? 0;
    WeightLogModel model =
        WeightLogModel(userId: userProfile?.userId ?? '', weight: initialWeight, createdAt: DateTime.now());
    final response = await planService.createWeightLog(model: model);
    return response;
  }

  Future<Response> getWeightLogs() async {
    final userProfile = sharedPreferenceHandler.getUser();
    final response = await planService.getWeightLogs(userId: userProfile?.userId ?? '');

    if (response.error == null) {
      List retrievedData = response.data ?? [];
      return Response.complete(retrievedData.map((item) => WeightLogModel.fromJson(item)).toList());
    }

    return response;
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on PlanRepository {
  Future<void> processPersonalizedPlan(List<Map<String, dynamic>> plan) async {
    PlanModel model = PlanModel.fromJson(plan[0]);

    await sharedPreferenceHandler.putPlan(model);

    debugPrint('${sharedPreferenceHandler.getPlan()}');
  }
}
