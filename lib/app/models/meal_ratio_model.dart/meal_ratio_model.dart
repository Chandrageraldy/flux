import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_ratio_model.freezed.dart';
part 'meal_ratio_model.g.dart';

@freezed
class MealRatioModel with _$MealRatioModel {
  factory MealRatioModel({
    double? calorieKcal, // kcal
    double? proteinG, // g
    double? fatG, // g
    double? carbsG, // g
  }) = _MealRatioModel;

  factory MealRatioModel.fromJson(Map<String, Object?> json) => _$MealRatioModelFromJson(json);
}
