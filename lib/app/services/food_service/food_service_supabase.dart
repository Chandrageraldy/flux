import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodServiceSupabase extends SupabaseBaseService {
  final supabase = Supabase.instance.client;

  Future<Response> saveFood(FoodResponseModel foodSearchModel) {
    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.savedFood,
      requestBody: foodSearchModel.toJson(),
    );
  }
}
