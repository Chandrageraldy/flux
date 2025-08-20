import 'package:flux/app/repositories/energy_repo/energy_repository.dart';
import 'package:flux/app/repositories/pet_repo/pet_repository.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserViewModel extends BaseViewModel {
  final UserRepository userRepository = UserRepository();
  final PetRepository petRepository = PetRepository();
  final EnergyRepository energyRepository = EnergyRepository();

  bool get isLoggedIn => userRepository.isLoggedIn;

  Future<bool> loginWithEmailAndPassword({required String email, required String password}) async {
    final response = await userRepository.loginWithEmailAndPassword(email: email, password: password);
    checkError(response);

    if (response.data is User) {
      User user = response.data;
      await getUserProfile(userId: user.id);
    }

    return response.data is User;
  }

  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required Map<String, String> bodyMetrics,
  }) async {
    final response = await userRepository.signUpWithEmailAndPassword(email: email, password: password);
    checkError(response);

    if (response.data is User) {
      User user = response.data;
      await createUserProfile(userId: user.id, email: user.email!, username: username, bodyMetrics: bodyMetrics);
      await assignVirtualPet(userId: user.id);
      await assignEnergies(userId: user.id);
    }

    return response.data is User;
  }

  Future<bool> logout() async {
    final response = await userRepository.logout();
    checkError(response);
    return response.data;
  }

  Future<void> createUserProfile({
    required String userId,
    required String email,
    required String username,
    required Map<String, String> bodyMetrics,
  }) async {
    final response = await userRepository.createUserProfile(
        userId: userId, email: email, username: username, bodyMetrics: bodyMetrics);
    checkError(response);
  }

  Future<void> getUserProfile({required String userId}) async {
    final response = await userRepository.getUserProfile(userId: userId);
    checkError(response);
  }

  Future<void> assignVirtualPet({required String userId}) async {
    final response = await petRepository.assignVirtualPet(userId: userId);
    checkError(response);
  }

  Future<void> assignEnergies({required String userId}) async {
    final response = await energyRepository.assignEnergies(userId: userId);
    checkError(response);
  }
}
