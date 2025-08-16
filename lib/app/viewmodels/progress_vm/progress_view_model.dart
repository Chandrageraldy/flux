import 'package:flux/app/repositories/plan_repo/plan_repository.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ProgressViewModel extends BaseViewModel {
  final PlanRepository planRepository = PlanRepository();
  final UserRepository userRepository = UserRepository();

  Future<void> getPersonalizedPlan() async {
    final response = await planRepository.getPersonalizedPlan();
    checkError(response);
  }

  Future<void> getUserProfile() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await userRepository.getUserProfile(userId: user?.userId ?? '');
    print(response.data);
    checkError(response);
  }
}
