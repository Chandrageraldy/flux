import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';

class EnergyService extends SupabaseBaseService {
  Future<Response> assignEnergies({required UserEnergyModel model}) async {
    final json = model.toJson();
    json.remove(TableCol.id);
    return callSupabaseDB(requestType: RequestType.POST, table: TableName.userEnergy, requestBody: json);
  }

  Future<Response> getUserEnergies({required String userId}) async {
    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.userEnergy,
      filters: {TableCol.userId: userId},
    );
  }
}
