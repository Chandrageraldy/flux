import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/repositories/plan_repo/plan_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class PlanViewModel extends BaseViewModel {
  final PlanRepository planRepository = PlanRepository();

  Future<bool> createPersonalizedPlan(Map<String, dynamic> personalizedPlan) async {
    final response = await planRepository.createPersonalizedPlan(personalizedPlan);
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<bool> getPersonalizedPlan() async {
    final response = await planRepository.getPersonalizedPlan();
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<bool> updatePersonalizedPlan(Map<String, dynamic> personalizedPlan) async {
    final response = await planRepository.updatePersonalizedPlan(personalizedPlan);
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }
}
