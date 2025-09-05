import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/repositories/plan_repo/plan_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class PlanViewModel extends BaseViewModel {
  final PlanRepository planRepository = PlanRepository();

  Future<bool> createPersonalizedPlan(Map<String, dynamic> personalizedPlan, bool isEdit) async {
    if (!isEdit) {
      final createPlanResponse = await planRepository.createPersonalizedPlan(personalizedPlan: personalizedPlan);
      checkError(createPlanResponse);

      if (createPlanResponse.status == ResponseStatus.COMPLETE) {
        final createLogResponse = await createWeightLog();
        checkError(createLogResponse);
        return createLogResponse.status == ResponseStatus.COMPLETE;
      }

      return createPlanResponse.status == ResponseStatus.COMPLETE;
    } else {
      final updatePlanResponse = await planRepository.updatePersonalizedPlan(personalizedPlan: personalizedPlan);
      checkError(updatePlanResponse);

      if (updatePlanResponse.status == ResponseStatus.COMPLETE) {
        final createLogResponse = await createWeightLog();
        checkError(createLogResponse);
        return createLogResponse.status == ResponseStatus.COMPLETE;
      }

      return updatePlanResponse.status == ResponseStatus.COMPLETE;
    }
  }

  Future<bool> getPersonalizedPlan() async {
    final response = await planRepository.getPersonalizedPlan();
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<bool> updatePersonalizedPlan(Map<String, dynamic> personalizedPlan) async {
    final response = await planRepository.updatePersonalizedPlan(personalizedPlan: personalizedPlan);
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<Response> createWeightLog() async {
    final response = await planRepository.createWeightLog();
    checkError(response);
    return response;
  }
}
