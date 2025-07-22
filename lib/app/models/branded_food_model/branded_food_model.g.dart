// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branded_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrandedFoodModelImpl _$$BrandedFoodModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BrandedFoodModelImpl(
      brandNameItemName: json['brand_name_item_name'] as String?,
      brandName: json['brand_name'] as String?,
      foodName: json['food_name'] as String?,
      nixItemId: json['nix_item_id'] as String?,
      calorieKcal: (json['nf_calories'] as num?)?.toDouble(),
      servingQty: (json['serving_qty'] as num?)?.toDouble(),
      servingUnit: json['serving_unit'] as String?,
    );

Map<String, dynamic> _$$BrandedFoodModelImplToJson(
        _$BrandedFoodModelImpl instance) =>
    <String, dynamic>{
      'brand_name_item_name': instance.brandNameItemName,
      'brand_name': instance.brandName,
      'food_name': instance.foodName,
      'nix_item_id': instance.nixItemId,
      'nf_calories': instance.calorieKcal,
      'serving_qty': instance.servingQty,
      'serving_unit': instance.servingUnit,
    };
