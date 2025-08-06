import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_food_model.freezed.dart';
part 'recent_food_model.g.dart';

@freezed
class RecentFoodModel with _$RecentFoodModel {
  factory RecentFoodModel({
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
    DateTime? lastViewedAt,
  }) = _RecentFoodModel;

  factory RecentFoodModel.fromJson(Map<String, dynamic> json) => _$RecentFoodModelFromJson(json);
}
