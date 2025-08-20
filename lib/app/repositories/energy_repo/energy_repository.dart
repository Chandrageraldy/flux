import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/services/energy_service/energy_service.dart';

class EnergyRepository {
  EnergyService energyService = EnergyService();

  Future<Response> assignEnergies({required String userId}) async {
    final model = UserEnergyModel(userId: userId, energies: 10);
    final response = await energyService.assignEnergies(model: model);
    return response;
  }

  Future<Response> getUserEnergies({required String userId}) async {
    final response = await energyService.getUserEnergies(userId: userId);
    if (response.error == null) {
      List<Map<String, dynamic>> userEnergies = response.data;
      UserEnergyModel model = UserEnergyModel.fromJson(userEnergies[0]);
      return Response.complete(model);
    }
    return response;
  }
}
