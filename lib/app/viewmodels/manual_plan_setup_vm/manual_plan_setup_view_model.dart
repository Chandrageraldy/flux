import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ManualPlanSetupViewModel extends BaseViewModel {
  Map<String, String> bodyMetrics = {};

  void savebodyMetrics(String key, String value) {
    // Use this instead of 'bodyMetrics[key] = value' to provide new reference for notifying listener
    bodyMetrics = {...bodyMetrics, key: value};
    notifyListeners();
    print(bodyMetrics);
  }

  void cleanbodyMetrics() {
    String userWeight = bodyMetrics[PlanSelectionKey.weight.key] ?? '';
    String userTargetWeight = bodyMetrics[PlanSelectionKey.targetWeight.key] ?? '';
    if (userWeight == userTargetWeight) {
      bodyMetrics.remove(PlanSelectionKey.targetWeeklyGain.key);
      bodyMetrics[PlanSelectionKey.goal.key] = PlanSelectionValue.maintain.value;
    } else if (double.parse(userWeight) < double.parse(userTargetWeight)) {
      bodyMetrics[PlanSelectionKey.goal.key] = PlanSelectionValue.gain.value;
    } else {
      bodyMetrics[PlanSelectionKey.goal.key] = PlanSelectionValue.lose.value;
    }
    print(bodyMetrics);
  }
}
