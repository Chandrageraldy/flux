// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodResponseModelImpl _$$FoodResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FoodResponseModelImpl(
      tagId: json['tagId'] as String?,
      brandNameItemName: json['brandNameItemName'] as String?,
      brandName: json['brandName'] as String?,
      foodName: json['foodName'] as String?,
      nixItemId: json['nixItemId'] as String?,
      calorieKcal: (json['calorieKcal'] as num?)?.toDouble(),
      servingQty: (json['servingQty'] as num?)?.toDouble(),
      servingUnit: json['servingUnit'] as String?,
    );

Map<String, dynamic> _$$FoodResponseModelImplToJson(
        _$FoodResponseModelImpl instance) =>
    <String, dynamic>{
      'tagId': instance.tagId,
      'brandNameItemName': instance.brandNameItemName,
      'brandName': instance.brandName,
      'foodName': instance.foodName,
      'nixItemId': instance.nixItemId,
      'calorieKcal': instance.calorieKcal,
      'servingQty': instance.servingQty,
      'servingUnit': instance.servingUnit,
    };
