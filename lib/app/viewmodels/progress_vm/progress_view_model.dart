import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/repositories/energy_repo/energy_repository.dart';
import 'package:flux/app/repositories/pet_repo/pet_repository.dart';
import 'package:flux/app/repositories/plan_repo/plan_repository.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ProgressViewModel extends BaseViewModel {
  final PlanRepository planRepository = PlanRepository();
  final UserRepository userRepository = UserRepository();
  final PetRepository petRepository = PetRepository();
  final EnergyRepository energyRepository = EnergyRepository();

  ActiveUserPetModel activeUserPet = ActiveUserPetModel();
  UserEnergyModel userEnergy = UserEnergyModel();

  bool _isUpdatingCurrentExp = false;
  bool get isLoading => _isUpdatingCurrentExp;

  Future<void> getPersonalizedPlan() async {
    final response = await planRepository.getPersonalizedPlan();
    checkError(response);
  }

  Future<void> getUserProfile() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await userRepository.getUserProfile(userId: user?.userId ?? '');
    checkError(response);
  }

  Future<void> getActiveUserPet() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await petRepository.getActiveUserPet(userId: user?.userId ?? '');
    checkError(response);

    activeUserPet = response.data as ActiveUserPetModel;
    notifyListeners();
  }

  Future<void> updateCurrentExp({required int addedExp}) async {
    _isUpdatingCurrentExp = true;
    notifyListeners();
    final user = userRepository.sharedPreferenceHandler.getUser();
    final currentExp = activeUserPet.currentExp ?? 0;
    final totalExp = currentExp + addedExp;
    final response = await petRepository.updateCurrentExp(userId: user?.userId ?? '', totalExp: totalExp);
    checkError(response);

    activeUserPet = response.data as ActiveUserPetModel;
    _isUpdatingCurrentExp = false;
    notifyListeners();
  }

  Future<void> getUserEnergies() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await energyRepository.getUserEnergies(userId: user?.userId ?? '');
    checkError(response);
    userEnergy = response.data as UserEnergyModel;
    notifyListeners();
    print(userEnergy);
  }
}
