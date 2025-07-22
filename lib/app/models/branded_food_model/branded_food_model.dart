// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'branded_food_model.freezed.dart';
part 'branded_food_model.g.dart';

@freezed
class BrandedFoodModel with _$BrandedFoodModel {
  const factory BrandedFoodModel({
    @JsonKey(name: 'brand_name_item_name') String? brandNameItemName,
    @JsonKey(name: 'brand_name') String? brandName,
    @JsonKey(name: 'food_name') String? foodName,
    @JsonKey(name: 'nix_item_id') String? nixItemId,
    @JsonKey(name: 'nf_calories') double? calorieKcal,
    @JsonKey(name: 'serving_qty') double? servingQty,
    @JsonKey(name: 'serving_unit') String? servingUnit,
  }) = _BrandedFoodModel;

  factory BrandedFoodModel.fromJson(Map<String, dynamic> json) => _$BrandedFoodModelFromJson(json);
}
