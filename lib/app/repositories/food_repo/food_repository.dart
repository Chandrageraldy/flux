import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/branded_food_model/branded_food_model.dart';
import 'package:flux/app/models/common_food_model/common_food_model.dart';
import 'package:flux/app/models/food_details_model/food_details_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/meal_scan_result_model.dart/meal_scan_result_model.dart';
import 'package:flux/app/models/recent_food_model.dart/recent_food_model.dart';
import 'package:flux/app/models/saved_food_model.dart/saved_food_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/services/food_service/food_service_gemini.dart';
import 'package:flux/app/services/food_service/food_service_nutritionix.dart';
import 'package:flux/app/services/food_service/food_service_supabase.dart';

class FoodRepository {
  FoodServiceNutritionix foodServiceNutritionix = FoodServiceNutritionix();
  FoodServiceSupabase foodServiceSupabase = FoodServiceSupabase();
  FoodServiceGemini foodServiceGemini = FoodServiceGemini();
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

  Future<Response> getSavedFoods() async {
    UserProfileModel? userProfile = sharedPreferenceHandler.getUser();
    final response = await foodServiceSupabase.getSavedFoods(userId: userProfile?.userId ?? '');

    if (response.error == null) {
      List retrievedData = response.data ?? [];
      return Response.complete(retrievedData.map((item) => SavedFoodModel.fromJson(item)).toList());
    }

    return response;
  }

  Future<Response> getRecentFoods() async {
    UserProfileModel? userProfile = sharedPreferenceHandler.getUser();
    final response = await foodServiceSupabase.getRecentFoods(userId: userProfile?.userId ?? '');

    if (response.error == null) {
      List retrievedData = response.data ?? [];
      return Response.complete(retrievedData.map((item) => RecentFoodModel.fromJson(item)).toList());
    }

    return response;
  }

  Future<Response> getFoodDetailsWithUPC({required String upc}) async {
    final response = await foodServiceNutritionix.getFoodDetailsWithUPC(upc: upc);
    if (response.error == null) {
      final List foodDetails = response.data['foods'] ?? [];
      var foodDetail = FoodDetailsModel.fromJson(foodDetails.first);
      final foodResponseModel = FoodResponseModel(
        tagId: foodDetail.tagId,
        foodName: foodDetail.foodName,
        calorieKcal: foodDetail.calorieKcal,
        servingQty: foodDetail.servingQty,
        servingUnit: foodDetail.servingUnit,
        brandNameItemName: '${foodDetail.brandName} ${foodDetail.foodName}',
        brandName: foodDetail.brandName,
        nixItemId: foodDetail.nixItemId,
      );
      return Response.complete(foodResponseModel);
    }
    return response;
  }

  Future<Response> saveToRecent({required FoodResponseModel foodResponseModel}) async {
    UserProfileModel? userProfile = sharedPreferenceHandler.getUser();
    final isCommonFood = foodResponseModel.tagId != null;

    // Check if the item already exists in recent list
    final checkResponse = await foodServiceSupabase.checkIfRecent(
      isCommonFood: isCommonFood,
      tagId: foodResponseModel.tagId,
      nixItemId: foodResponseModel.nixItemId,
      userId: userProfile?.userId ?? '',
    );

    if (checkResponse.error != null) return checkResponse;

    final List retrievedData = checkResponse.data ?? [];

    // If item already exists → delete it to reinsert with the latest timestamp
    if (retrievedData.isNotEmpty) {
      final int retrievedId = retrievedData.first[TableCol.id];

      final deleteResponse = await foodServiceSupabase.deleteBasedOnId(table: TableName.recentFood, id: retrievedId);

      if (deleteResponse.error != null) return deleteResponse;
    }

    // If there are already 5 items, delete the oldest one based on lastViewedAt
    final checkCountResponse = await foodServiceSupabase.getRecentFoods(userId: userProfile?.userId ?? '');
    if (checkCountResponse.error != null) return checkCountResponse;

    final List recentList = checkCountResponse.data ?? [];

    if (recentList.length >= 5) {
      recentList
          .sort((a, b) => DateTime.parse(a[TableCol.lastViewedAt]).compareTo(DateTime.parse(b[TableCol.lastViewedAt])));
      final int oldestId = recentList.first[TableCol.id];

      final deleteOldestResponse = await foodServiceSupabase.deleteBasedOnId(table: TableName.recentFood, id: oldestId);
      if (deleteOldestResponse.error != null) return deleteOldestResponse;
    }

    // Save new item
    final recentFoodModel = RecentFoodModel(
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

    final saveResponse = await foodServiceSupabase.saveAsRecent(recentFoodModel: recentFoodModel);

    return saveResponse;
  }

  Future<Response> getFoodDetailsFromMealScan({required XFile imageFile}) async {
    final response = await foodServiceGemini.getFoodDetailsFromMealScan(imageFile: imageFile);

    if (response.error == null) {
      Map<String, dynamic> json = jsonDecode(response.data);
      final mealScanResult = MealScanResultModel.fromJson(json);
      return Response.complete(mealScanResult);
    }

    return response;
  }

  Future<Response> logFoodWithFoodSearch({required FoodDetailsModel foodDetails, required String mealType}) async {
    UserProfileModel? userProfile = sharedPreferenceHandler.getUser();
    final loggedFoodModel = LoggedFoodModel(
      foodName: foodDetails.foodName,
      brandName: foodDetails.brandName,
      servingQty: foodDetails.servingQty,
      servingUnit: foodDetails.servingUnit,
      servingWeightGrams: foodDetails.servingWeightGrams,
      calorieKcal: foodDetails.calorieKcal,
      fatG: foodDetails.fatG,
      carbsG: foodDetails.carbsG,
      proteinG: foodDetails.proteinG,
      nixBrandName: foodDetails.nixBrandName,
      nixItemName: foodDetails.nixItemName,
      nixItemId: foodDetails.nixItemId,
      tagId: foodDetails.tagId,
      ingredientStatement: foodDetails.ingredientStatement,
      fullNutrients: foodDetails.fullNutrients,
      altMeasures: foodDetails.altMeasures,
      userId: userProfile?.userId,
      source: LogSource.foodSearch.value,
      mealType: mealType,
    );

    final response = await foodServiceSupabase.logFood(loggedFoodModel: loggedFoodModel);

    return response;
  }
}
