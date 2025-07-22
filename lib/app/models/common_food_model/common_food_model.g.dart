// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommonFoodModelImpl _$$CommonFoodModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CommonFoodModelImpl(
      tagId: json['tag_id'] as String?,
      foodName: json['food_name'] as String?,
      calorieKcal: (json['nf_calories'] as num?)?.toDouble(),
      servingQty: (json['serving_qty'] as num?)?.toInt(),
      servingUnit: json['serving_unit'] as String?,
    );

Map<String, dynamic> _$$CommonFoodModelImplToJson(
        _$CommonFoodModelImpl instance) =>
    <String, dynamic>{
      'tag_id': instance.tagId,
      'food_name': instance.foodName,
      'nf_calories': instance.calorieKcal,
      'serving_qty': instance.servingQty,
      'serving_unit': instance.servingUnit,
    };
