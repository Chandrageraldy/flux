import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_search_model.freezed.dart';
part 'food_search_model.g.dart';

@freezed
class FoodSearchModel with _$FoodSearchModel {
  const factory FoodSearchModel({
    String? tagId,
    String? brandNameItemName,
    String? brandName,
    String? foodName,
    String? nixItemId,
    double? calorieKcal,
    double? servingQty,
    String? servingUnit,
  }) = _FoodSearchModel;

  factory FoodSearchModel.fromJson(Map<String, dynamic> json) => _$FoodSearchModelFromJson(json);
}
