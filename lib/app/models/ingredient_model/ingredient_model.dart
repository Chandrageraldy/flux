import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/full_nutrients_model/full_nutrients_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
class IngredientModel with _$IngredientModel {
  factory IngredientModel({
    String? foodName,
    double? servingQty,
    String? servingUnit,
    double? servingWeight,
    double? calorie,
    double? fat,
    double? carbs,
    double? protein,
    List<FullNutrientsModel>? fullNutrients,
    List<AltMeasureModel>? altMeasures,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);
}
