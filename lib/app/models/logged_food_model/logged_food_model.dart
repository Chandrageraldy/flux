import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/full_nutrients_model/full_nutrients_model.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logged_food_model.freezed.dart';
part 'logged_food_model.g.dart';

@freezed
class LoggedFoodModel with _$LoggedFoodModel {
  const factory LoggedFoodModel({
    int? id,
    String? userId,
    String? foodName,
    String? brandName,
    double? servingQty,
    String? servingUnit,
    double? servingWeightGrams,
    double? calorieKcal,
    double? fatG,
    double? carbsG,
    double? proteinG,
    String? nixBrandName,
    String? nixItemName,
    String? nixItemId,
    String? tagId,
    String? ingredientStatement,
    List<FullNutrientsModel>? fullNutrients,
    List<AltMeasureModel>? altMeasures,
    double? healthScore,
    String? healthScoreDesc,
    double? quantity,
    List<IngredientModel>? ingredients,
    String? source,
    String? mealType,
    DateTime? loggedAt,
    String? imageUrl,
  }) = _LoggedFoodModel;

  factory LoggedFoodModel.fromJson(Map<String, dynamic> json) => _$LoggedFoodModelFromJson(json);
}
