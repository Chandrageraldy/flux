import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/models/user_pet_model/user_pet_model.dart';
import 'package:flux/app/models/virtual_pets_model/virtual_pets_model.dart';
import 'package:flux/app/services/pet_service/pet_service.dart';

class PetRepository {
  final PetService petService = PetService();

  Future<Response> assignVirtualPet({required String userId}) async {
    final model = UserPetModel(userId: userId, petId: 1, isActive: true, currentExp: 0);

    final response = await petService.assignVirtualPet(model: model);
    return response;
  }

  Future<Response> getActiveUserPet({required String userId}) async {
    final response = await petService.getActiveUserPet(userId: userId);

    if (response.error == null) {
      List<Map<String, dynamic>> activeUserPet = response.data;
      ActiveUserPetModel model = ActiveUserPetModel.fromJson(activeUserPet[0]);
      return Response.complete(model);
    }

    return response;
  }

  Future<Response> updateCurrentExp({required String userId, required int totalExp}) async {
    final updateResponse = await petService.updateCurrentExp(userId: userId, totalExp: totalExp);

    if (updateResponse.error == null) {
      final getResponse = await petService.getActiveUserPet(userId: userId);

      if (getResponse.error == null) {
        List<Map<String, dynamic>> activeUserPet = getResponse.data;
        ActiveUserPetModel activePetModel = ActiveUserPetModel.fromJson(activeUserPet[0]);
        return Response.complete(activePetModel);
      } else {
        return getResponse;
      }
    }

    return updateResponse;
  }

  Future<Response> getVirtualPets() async {
    final response = await petService.getVirtualPets();

    if (response.error == null) {
      List<Map<String, dynamic>> virtualPets = response.data;
      List<VirtualPetsModel> petsList = virtualPets.map((e) => VirtualPetsModel.fromJson(e)).toList();
      return Response.complete(petsList);
    }

    return response;
  }

  Future<Response> getUserPets({required String userId}) async {
    final response = await petService.getUserPets(userId: userId);

    if (response.error == null) {
      List<Map<String, dynamic>> userPets = response.data;
      List<UserPetModel> petsList = userPets.map((e) => UserPetModel.fromJson(e)).toList();
      return Response.complete(petsList);
    }

    return response;
  }

  Future<Response> buyPet({required String userId, required int petId}) {
    final model = UserPetModel(userId: userId, petId: petId, isActive: false, currentExp: 0);
    final response = petService.buyPet(model: model);
    return response;
  }

  Future<Response> unequipAllUserPets({required String userId}) {
    final response = petService.unequipAllUserPets(userId: userId);
    return response;
  }

  Future<Response> equipUserPet({required String userId, required int petId}) {
    final response = petService.equipUserPet(userId: userId, petId: petId);
    return response;
  }
}
