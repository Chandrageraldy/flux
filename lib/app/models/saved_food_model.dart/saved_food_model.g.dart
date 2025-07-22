// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedFoodModelImpl _$$SavedFoodModelImplFromJson(Map<String, dynamic> json) =>
    _$SavedFoodModelImpl(
      id: (json['id'] as num?)?.toInt(),
      tagId: json['tagId'] as String?,
      brandNameItemName: json['brandNameItemName'] as String?,
      brandName: json['brandName'] as String?,
      foodName: json['foodName'] as String?,
      nixItemId: json['nixItemId'] as String?,
      calorieKcal: (json['calorieKcal'] as num?)?.toDouble(),
      servingQty: (json['servingQty'] as num?)?.toDouble(),
      servingUnit: json['servingUnit'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$SavedFoodModelImplToJson(
        _$SavedFoodModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagId': instance.tagId,
      'brandNameItemName': instance.brandNameItemName,
      'brandName': instance.brandName,
      'foodName': instance.foodName,
      'nixItemId': instance.nixItemId,
      'calorieKcal': instance.calorieKcal,
      'servingQty': instance.servingQty,
      'servingUnit': instance.servingUnit,
      'userId': instance.userId,
    };
