import 'package:flux/app/viewmodels/base_view_model.dart';

class ManualPlanSetupViewModel extends BaseViewModel {
  Map<String, String> userPlan = {};

  void saveUserPlan(String key, String value) {
    // Use this instead of 'userPlan[key] = value' to provide new reference for notifying listener
    userPlan = {...userPlan, key: value};
    notifyListeners();
    print(userPlan);
  }
}
