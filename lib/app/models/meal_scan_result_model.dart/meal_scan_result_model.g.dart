// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_scan_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealScanResultModelImpl _$$MealScanResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MealScanResultModelImpl(
      foodName: json['foodName'] as String?,
      healthScore: (json['healthScore'] as num?)?.toDouble(),
      healthScoreDesc: json['healthScoreDesc'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MealScanResultModelImplToJson(
        _$MealScanResultModelImpl instance) =>
    <String, dynamic>{
      'foodName': instance.foodName,
      'healthScore': instance.healthScore,
      'healthScoreDesc': instance.healthScoreDesc,
      'quantity': instance.quantity,
      'ingredients': instance.ingredients,
    };
