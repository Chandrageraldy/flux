import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/branded_food_model/branded_food_model.dart';
import 'package:flux/app/models/common_food_model/common_food_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/services/food_service/food_service_nutritionix.dart';
import 'package:flux/app/services/food_service/food_service_supabase.dart';

class FoodRepository {
  FoodServiceNutritionix foodServiceNutritionix = FoodServiceNutritionix();
  FoodServiceSupabase foodServiceSupabase = FoodServiceSupabase();

  Future<Response> searchInstant({required String query}) async {
    final List<FoodResponseModel> foodSearchResponse = [];

    final response = await foodServiceNutritionix.searchInstant(query: query);
    // Nutrionix search instant API returns common foods that may have the same tagId, track tagIds to avoid food with same tagId
    final Set<String?> seenTagIds = {};

    final List commonList = response.data['common'] ?? [];
    for (final item in commonList) {
      final common = CommonFoodModel.fromJson(item);
      // ignore common foods with the same tagIds as the previous ones
      if (seenTagIds.contains(common.tagId)) continue;
      seenTagIds.add(common.tagId);
      foodSearchResponse.add(FoodResponseModel(
        tagId: common.tagId,
        foodName: common.foodName,
        calorieKcal: common.calorieKcal,
        servingQty: common.servingQty,
        servingUnit: common.servingUnit,
      ));
    }

    final List brandedList = response.data['branded'] ?? [];
    for (final item in brandedList) {
      final branded = BrandedFoodModel.fromJson(item);
      foodSearchResponse.add(FoodResponseModel(
        brandNameItemName: branded.brandNameItemName,
        brandName: branded.brandName,
        foodName: branded.foodName,
        nixItemId: branded.nixItemId,
        calorieKcal: branded.calorieKcal,
        servingQty: branded.servingQty,
        servingUnit: branded.servingUnit,
      ));
    }

    if (response.error == null) {
      return Response.complete(foodSearchResponse);
    }

    return response;
  }

  Future<Response> saveFood(FoodResponseModel foodSearchModel) async {
    final response = await foodServiceSupabase.saveFood(foodSearchModel);
    if (response.error == null) {
      return Response.complete(true);
    }
    return response;
  }
}
