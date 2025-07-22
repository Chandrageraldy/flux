import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_food_model.freezed.dart';
part 'saved_food_model.g.dart';

@freezed
class SavedFoodModel with _$SavedFoodModel {
  factory SavedFoodModel({
    int? id,
    String? tagId,
    String? brandNameItemName,
    String? brandName,
    String? foodName,
    String? nixItemId,
    double? calorieKcal,
    double? servingQty,
    String? servingUnit,
    String? userId,
  }) = _SavedFoodModel;

  factory SavedFoodModel.fromJson(Map<String, dynamic> json) => _$SavedFoodModelFromJson(json);
}
