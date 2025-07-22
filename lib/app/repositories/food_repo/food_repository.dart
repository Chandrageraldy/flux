import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/branded_food_model/branded_food_model.dart';
import 'package:flux/app/models/common_food_model/common_food_model.dart';
import 'package:flux/app/services/food_service/food_service.dart';

class FoodRepository {
  FoodService foodService = FoodService();

  Future<Response> searchInstant({required String query}) async {
    final List<FoodSearchResultModel> foodSearchResponse = [];

    final response = await foodService.searchInstant(query: query);

    final List commonList = response.data['common'] ?? [];
    for (final item in commonList) {
      final common = CommonFoodModel.fromJson(item);
      foodSearchResponse.add(FoodSearchResultModel(
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
      foodSearchResponse.add(FoodSearchResultModel(
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
}

class FoodSearchResultModel {
  String? tagId;
  String? brandNameItemName;
  String? brandName;
  String? foodName;
  String? nixItemId;
  double? calorieKcal;
  int? servingQty;
  String? servingUnit;

  FoodSearchResultModel({
    this.tagId,
    this.brandNameItemName,
    this.brandName,
    this.foodName,
    this.nixItemId,
    this.calorieKcal,
    this.servingQty,
    this.servingUnit,
  });
}
