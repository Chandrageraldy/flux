// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_food_model.freezed.dart';
part 'common_food_model.g.dart';

@freezed
class CommonFoodModel with _$CommonFoodModel {
  const factory CommonFoodModel({
    @JsonKey(name: 'tag_id') String? tagId,
    @JsonKey(name: 'food_name') String? foodName,
    @JsonKey(name: 'nf_calories') double? calorieKcal,
    @JsonKey(name: 'serving_qty') double? servingQty,
    @JsonKey(name: 'serving_unit') String? servingUnit,
  }) = _CommonFoodModel;

  factory CommonFoodModel.fromJson(Map<String, dynamic> json) => _$CommonFoodModelFromJson(json);
}
