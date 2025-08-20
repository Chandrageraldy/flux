import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_pet_model/user_pet_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';

class PetService extends SupabaseBaseService {
  Future<Response> assignVirtualPet({required UserPetModel model}) {
    final json = model.toJson();
    json.remove(TableCol.id);
    return callSupabaseDB(requestType: RequestType.POST, table: TableName.userPet, requestBody: json);
  }

  Future<Response> getActiveUserPet({required String userId}) {
    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.userPet,
      column: '*, virtual_pets(*)',
      filters: {
        TableCol.userId: userId,
        TableCol.isActive: true,
      },
    );
  }

  Future<Response> updateCurrentExp({required String userId, required int totalExp}) {
    return callSupabaseDB(
      requestType: RequestType.PUT,
      table: TableName.userPet,
      filters: {TableCol.userId: userId, TableCol.isActive: true},
      requestBody: {TableCol.currentExp: totalExp},
    );
  }
}
