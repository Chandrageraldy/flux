import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_response_model.freezed.dart';
part 'food_response_model.g.dart';

@freezed
class FoodResponseModel with _$FoodResponseModel {
  const factory FoodResponseModel({
    String? tagId,
    String? brandNameItemName,
    String? brandName,
    String? foodName,
    String? nixItemId,
    double? calorieKcal,
    double? servingQty,
    String? servingUnit,
  }) = _FoodResponseModel;

  factory FoodResponseModel.fromJson(Map<String, dynamic> json) => _$FoodResponseModelFromJson(json);
}
