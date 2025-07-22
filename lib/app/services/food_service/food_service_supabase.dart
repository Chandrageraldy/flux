import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/saved_food_model.dart/saved_food_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodServiceSupabase extends SupabaseBaseService {
  final supabase = Supabase.instance.client;

  Future<Response> saveFood(SavedFoodModel foodRequestModel) async {
    final requestBody = foodRequestModel.toJson();
    requestBody.remove(TableCol.id);

    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.savedFood,
      requestBody: requestBody,
    );
  }
}
