import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/branded_food_model/branded_food_model.dart';
import 'package:flux/app/models/common_food_model/common_food_model.dart';
import 'package:flux/app/models/food_details_model/food_details_model.dart';
import 'package:flux/app/models/saved_food_model.dart/saved_food_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/services/food_service/food_service_nutritionix.dart';
import 'package:flux/app/services/food_service/food_service_supabase.dart';

class FoodRepository {
  FoodServiceNutritionix foodServiceNutritionix = FoodServiceNutritionix();
  FoodServiceSupabase foodServiceSupabase = FoodServiceSupabase();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();

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

  Future<Response> saveOrUnsaveFood({required FoodResponseModel foodResponseModel, required bool isSaved}) async {
    UserProfileModel? userProfile = sharedPreferenceHandler.getUser();
    SavedFoodModel savedFoodModel = SavedFoodModel(
      tagId: foodResponseModel.tagId,
      foodName: foodResponseModel.foodName,
      calorieKcal: foodResponseModel.calorieKcal,
      servingQty: foodResponseModel.servingQty,
      servingUnit: foodResponseModel.servingUnit,
      brandNameItemName: foodResponseModel.brandNameItemName,
      brandName: foodResponseModel.brandName,
      nixItemId: foodResponseModel.nixItemId,
      userId: userProfile?.userId,
    );
    final response = await foodServiceSupabase.saveOrUnsaveFood(
      savedFoodModel: savedFoodModel,
      userId: userProfile?.userId ?? '',
      isSaved: isSaved,
    );
    return response;
  }

  Future<Response> checkIfSaved({required FoodResponseModel foodResponseModel}) async {
    UserProfileModel? userProfile = sharedPreferenceHandler.getUser();
    final isCommonFood = foodResponseModel.tagId != null;
    final response = await foodServiceSupabase.checkIfSaved(
      isCommonFood: isCommonFood,
      tagId: foodResponseModel.tagId,
      nixItemId: foodResponseModel.nixItemId,
      userId: userProfile?.userId ?? '',
    );

    if (response.error == null) {
      List retrievedData = response.data ?? [];
      return Response.complete(retrievedData.isNotEmpty);
    }

    return response;
  }

  Future<Response> getFoodDetails({required FoodResponseModel foodResponseModel}) async {
    final isCommonFood = foodResponseModel.tagId != null;
    final response = await foodServiceNutritionix.getFoodDetails(
      isCommonFood: isCommonFood,
      foodName: foodResponseModel.foodName,
      nixItemId: foodResponseModel.nixItemId,
    );

    if (response.error == null) {
      final List foodDetails = response.data['foods'] ?? [];
      var foodDetail = FoodDetailsModel.fromJson(foodDetails.first);
      // If the foodDetail does not have altMeasures (==null), create a default one using servingUnit, servingQty, and servingWeightGrams
      if (foodDetail.altMeasures == null) {
        foodDetail = foodDetail.copyWith(
          altMeasures: [
            AltMeasureModel(
              measure: foodDetail.servingUnit ?? 'serving',
              qty: foodDetail.servingQty ?? 1.0,
              servingWeight: foodDetail.servingWeightGrams ?? 100,
            ),
          ],
        );
      }
      return Response.complete(foodDetail);
    }

    return response;
  }
}
