import 'package:flux/app/models/meal_ratio_model.dart/meal_ratio_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
class PlanModel with _$PlanModel {
  factory PlanModel({
    int? planId,
    String? userId,
    double? calorieKcal, // kcal
    double? proteinG, // grams
    double? fatG, // grams
    double? carbsG, // grams
    double? calciumMg, // mg
    double? ironMg, // mg
    double? magnesiumMg, // mg
    double? phosphorusMg, // mg
    double? potassiumMg, // mg
    double? sodiumMg, // mg
    double? zincMg, // mg
    double? copperMg, // mg
    double? manganeseMg, // mg
    double? seleniumUg, // µg
    double? vitaminAIu, // IU
    double? vitaminEMg, // mg
    double? vitaminDIu, // IU
    double? vitaminCMg, // mg
    double? thiaminMg, // mg
    double? riboflavinMg, // mg
    double? niacinMg, // mg
    double? vitaminB6Mg, // mg
    double? vitaminB12Ug, // µg
    double? cholineMg, // mg
    double? vitaminKUg, // µg
    double? folateUg, // µg
    MealRatioModel? breakfast,
    MealRatioModel? lunch,
    MealRatioModel? dinner,
    MealRatioModel? snack,
    double? proteinRatio,
    double? fatRatio,
    double? carbsRatio,
  }) = _PlanModel;

  factory PlanModel.fromJson(Map<String, Object?> json) => _$PlanModelFromJson(json);
}
