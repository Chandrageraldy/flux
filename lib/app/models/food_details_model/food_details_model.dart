// ignore_for_file: invalid_annotation_target

import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/full_nutrients_model/full_nutrients_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_details_model.freezed.dart';
part 'food_details_model.g.dart';

@freezed
class FoodDetailsModel with _$FoodDetailsModel {
  factory FoodDetailsModel({
    @JsonKey(name: 'food_name') String? foodName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'serving_qty') double? servingQty,
    @JsonKey(name: 'serving_unit') String? servingUnit,
    @JsonKey(name: 'serving_weight_grams') double? servingWeightGrams,
    @JsonKey(name: 'nf_calories') double? calorieKcal,
    @JsonKey(name: 'nf_total_fat') double? fatG,
    @JsonKey(name: 'nf_total_carbohydrate') double? carbsG,
    @JsonKey(name: 'nf_protein') double? proteinG,
    @JsonKey(name: 'nix_brand_name') String? nixBrandName,
    @JsonKey(name: 'nix_item_name') String? nixItemName,
    @JsonKey(name: 'nix_item_id') String? nixItemId,
    @JsonKey(name: 'tag_id') String? tagId,
    @JsonKey(name: 'nf_ingredient_statement') String? ingredientStatement,
    @JsonKey(name: 'full_nutrients') List<FullNutrient>? fullNutrients,
    @JsonKey(name: 'alt_measures') List<AltMeasureModel>? altMeasures,
  }) = _FoodDetailsModel;

  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) => _$FoodDetailsModelFromJson(json);
}
