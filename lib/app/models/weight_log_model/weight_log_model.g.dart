// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeightLogModelImpl _$$WeightLogModelImplFromJson(Map<String, dynamic> json) =>
    _$WeightLogModelImpl(
      id: (json['id'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$WeightLogModelImplToJson(
        _$WeightLogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
