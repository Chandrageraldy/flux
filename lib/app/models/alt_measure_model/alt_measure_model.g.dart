// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alt_measure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AltMeasureModelImpl _$$AltMeasureModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AltMeasureModelImpl(
      servingWeight: (json['serving_weight'] as num?)?.toDouble(),
      measure: json['measure'] as String?,
      qty: (json['qty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AltMeasureModelImplToJson(
        _$AltMeasureModelImpl instance) =>
    <String, dynamic>{
      'serving_weight': instance.servingWeight,
      'measure': instance.measure,
      'qty': instance.qty,
    };
