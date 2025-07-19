import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ManualPlanSetupViewModel extends BaseViewModel {
  Map<String, String> userPlan = {};

  void saveUserPlan(String key, String value) {
    // Use this instead of 'userPlan[key] = value' to provide new reference for notifying listener
    userPlan = {...userPlan, key: value};
    notifyListeners();
    print(userPlan);
  }

  void cleanUserPlan() {
    String userWeight = userPlan[PlanSelectionKey.weight.key] ?? '';
    String userTargetWeight = userPlan[PlanSelectionKey.targetWeight.key] ?? '';
    if (userWeight == userTargetWeight) {
      userPlan.remove(PlanSelectionKey.targetWeightWeekly.key);
      userPlan[PlanSelectionKey.goal.key] = PlanSelectionValue.maintain.value;
    } else if (double.parse(userWeight) < double.parse(userTargetWeight)) {
      userPlan[PlanSelectionKey.goal.key] = PlanSelectionValue.gain.value;
    } else {
      userPlan[PlanSelectionKey.goal.key] = PlanSelectionValue.lose.value;
    }
    print(userPlan);
  }
}
