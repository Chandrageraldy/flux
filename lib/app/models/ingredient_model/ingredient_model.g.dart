// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IngredientModelImpl _$$IngredientModelImplFromJson(
        Map<String, dynamic> json) =>
    _$IngredientModelImpl(
      foodName: json['foodName'] as String?,
      servingQty: (json['servingQty'] as num?)?.toDouble(),
      servingUnit: json['servingUnit'] as String?,
      servingWeight: (json['servingWeight'] as num?)?.toDouble(),
      calorie: (json['calorie'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      fullNutrients: (json['fullNutrients'] as List<dynamic>?)
          ?.map((e) => FullNutrientsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      altMeasures: (json['altMeasures'] as List<dynamic>?)
          ?.map((e) => AltMeasureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$IngredientModelImplToJson(
        _$IngredientModelImpl instance) =>
    <String, dynamic>{
      'foodName': instance.foodName,
      'servingQty': instance.servingQty,
      'servingUnit': instance.servingUnit,
      'servingWeight': instance.servingWeight,
      'calorie': instance.calorie,
      'fat': instance.fat,
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fullNutrients': instance.fullNutrients,
      'altMeasures': instance.altMeasures,
    };
