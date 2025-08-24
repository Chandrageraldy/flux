import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/user_pet_model/user_pet_model.dart';
import 'package:flux/app/models/virtual_pets_model/virtual_pets_model.dart';
import 'package:flux/app/repositories/energy_repo/energy_repository.dart';
import 'package:flux/app/repositories/pet_repo/pet_repository.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class VirtualPetShopViewModel extends BaseViewModel {
  final PetRepository petRepository = PetRepository();
  final UserRepository userRepository = UserRepository();
  final EnergyRepository energyRepository = EnergyRepository();

  List<VirtualPetsModel> virtualPets = [];
  List<UserPetModel> userPets = [];
  List<ShopPetItem> shopPets = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserEnergyModel userEnergy = UserEnergyModel();

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      final futures = [
        getVirtualPets(),
        getUserEnergies(),
      ];
      await Future.wait(futures);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getVirtualPets() async {
    final getVirtualPetsResponse = await petRepository.getVirtualPets();
    checkError(getVirtualPetsResponse);
    virtualPets = getVirtualPetsResponse.data as List<VirtualPetsModel>;

    if (getVirtualPetsResponse.status == ResponseStatus.COMPLETE) {
      final user = userRepository.sharedPreferenceHandler.getUser();
      final getUserPetsResponse = await petRepository.getUserPets(userId: user?.userId ?? '');
      checkError(getUserPetsResponse);
      userPets = getUserPetsResponse.data as List<UserPetModel>;

      final ownedPetIds = userPets.map((e) => e.petId).toSet();

      shopPets = virtualPets.map((virtualPet) {
        final userPet = userPets.firstWhere(
          (uPet) => uPet.petId == virtualPet.petId,
          orElse: () => UserPetModel(),
        );
        return ShopPetItem(
          pet: virtualPet,
          isOwned: ownedPetIds.contains(virtualPet.petId),
          isActive: userPet.isActive ?? false,
        );
      }).toList();

      // Sort so active pets is on top of the list
      shopPets.sort((a, b) {
        if (a.isActive == b.isActive) return 0;
        return a.isActive ? -1 : 1;
      });

      notifyListeners();
    }
  }

  Future<void> getUserEnergies() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await energyRepository.getUserEnergies(userId: user?.userId ?? '');
    checkError(response);
    userEnergy = response.data as UserEnergyModel;
    notifyListeners();
  }

  Future<void> buyPet({required int petId, required int energyCost}) async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final buyPetResponse = await petRepository.buyPet(userId: user?.userId ?? '', petId: petId);
    checkError(buyPetResponse);

    if (buyPetResponse.status == ResponseStatus.COMPLETE) {
      final totalEnergy = (userEnergy.energies ?? 0) - energyCost;
      final addEnergyResponse =
          await energyRepository.addUserEnergy(userId: user?.userId ?? '', totalEnergy: totalEnergy);

      checkError(addEnergyResponse);
      final updatedEnergy = addEnergyResponse.data as UserEnergyModel;
      userEnergy = updatedEnergy;
      notifyListeners();
    }

    await getVirtualPets();
  }

  Future<void> equipPet({required int petId}) async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final unequipResponse = await petRepository.unequipAllUserPets(userId: user?.userId ?? '');
    checkError(unequipResponse);

    if (unequipResponse.status == ResponseStatus.COMPLETE) {
      final equipResponse = await petRepository.equipUserPet(userId: user?.userId ?? '', petId: petId);
      checkError(equipResponse);

      if (equipResponse.status == ResponseStatus.COMPLETE) {
        await getVirtualPets();
      }
    }
  }
}

class ShopPetItem {
  final VirtualPetsModel pet;
  final bool isOwned;
  final bool isActive;

  ShopPetItem({
    required this.pet,
    required this.isOwned,
    required this.isActive,
  });
}
