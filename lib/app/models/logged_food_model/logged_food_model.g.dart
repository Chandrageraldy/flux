// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoggedFoodModelImpl _$$LoggedFoodModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoggedFoodModelImpl(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      foodName: json['foodName'] as String?,
      brandName: json['brandName'] as String?,
      servingQty: (json['servingQty'] as num?)?.toDouble(),
      servingUnit: json['servingUnit'] as String?,
      servingWeightGrams: (json['servingWeightGrams'] as num?)?.toDouble(),
      calorieKcal: (json['calorieKcal'] as num?)?.toDouble(),
      fatG: (json['fatG'] as num?)?.toDouble(),
      carbsG: (json['carbsG'] as num?)?.toDouble(),
      proteinG: (json['proteinG'] as num?)?.toDouble(),
      nixBrandName: json['nixBrandName'] as String?,
      nixItemName: json['nixItemName'] as String?,
      nixItemId: json['nixItemId'] as String?,
      tagId: json['tagId'] as String?,
      ingredientStatement: json['ingredientStatement'] as String?,
      fullNutrients: (json['fullNutrients'] as List<dynamic>?)
          ?.map((e) => FullNutrientsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      altMeasures: (json['altMeasures'] as List<dynamic>?)
          ?.map((e) => AltMeasureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      healthScore: (json['healthScore'] as num?)?.toDouble(),
      healthScoreDesc: json['healthScoreDesc'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      source: json['source'] as String?,
      mealType: json['mealType'] as String?,
      loggedAt: json['loggedAt'] == null
          ? null
          : DateTime.parse(json['loggedAt'] as String),
    );

Map<String, dynamic> _$$LoggedFoodModelImplToJson(
        _$LoggedFoodModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'foodName': instance.foodName,
      'brandName': instance.brandName,
      'servingQty': instance.servingQty,
      'servingUnit': instance.servingUnit,
      'servingWeightGrams': instance.servingWeightGrams,
      'calorieKcal': instance.calorieKcal,
      'fatG': instance.fatG,
      'carbsG': instance.carbsG,
      'proteinG': instance.proteinG,
      'nixBrandName': instance.nixBrandName,
      'nixItemName': instance.nixItemName,
      'nixItemId': instance.nixItemId,
      'tagId': instance.tagId,
      'ingredientStatement': instance.ingredientStatement,
      'fullNutrients': instance.fullNutrients,
      'altMeasures': instance.altMeasures,
      'healthScore': instance.healthScore,
      'healthScoreDesc': instance.healthScoreDesc,
      'quantity': instance.quantity,
      'ingredients': instance.ingredients,
      'source': instance.source,
      'mealType': instance.mealType,
      'loggedAt': instance.loggedAt?.toIso8601String(),
    };
