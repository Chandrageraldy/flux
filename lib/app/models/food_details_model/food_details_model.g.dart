// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodDetailsModelImpl _$$FoodDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FoodDetailsModelImpl(
      foodName: json['food_name'] as String?,
      brandName: json['brand_name'] as String?,
      servingQty: (json['serving_qty'] as num?)?.toDouble(),
      servingUnit: json['serving_unit'] as String?,
      servingWeightGrams: (json['serving_weight_grams'] as num?)?.toDouble(),
      calorieKcal: (json['nf_calories'] as num?)?.toDouble(),
      fatG: (json['nf_total_fat'] as num?)?.toDouble(),
      carbsG: (json['nf_total_carbohydrate'] as num?)?.toDouble(),
      proteinG: (json['nf_protein'] as num?)?.toDouble(),
      nixBrandName: json['nix_brand_name'] as String?,
      nixItemName: json['nix_item_name'] as String?,
      nixItemId: json['nix_item_id'] as String?,
      tagId: json['tag_id'] as String?,
      ingredientStatement: json['nf_ingredient_statement'] as String?,
      fullNutrients: (json['full_nutrients'] as List<dynamic>?)
          ?.map((e) => FullNutrientsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      altMeasures: (json['alt_measures'] as List<dynamic>?)
          ?.map((e) => AltMeasureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FoodDetailsModelImplToJson(
        _$FoodDetailsModelImpl instance) =>
    <String, dynamic>{
      'food_name': instance.foodName,
      'brand_name': instance.brandName,
      'serving_qty': instance.servingQty,
      'serving_unit': instance.servingUnit,
      'serving_weight_grams': instance.servingWeightGrams,
      'nf_calories': instance.calorieKcal,
      'nf_total_fat': instance.fatG,
      'nf_total_carbohydrate': instance.carbsG,
      'nf_protein': instance.proteinG,
      'nix_brand_name': instance.nixBrandName,
      'nix_item_name': instance.nixItemName,
      'nix_item_id': instance.nixItemId,
      'tag_id': instance.tagId,
      'nf_ingredient_statement': instance.ingredientStatement,
      'full_nutrients': instance.fullNutrients,
      'alt_measures': instance.altMeasures,
    };
