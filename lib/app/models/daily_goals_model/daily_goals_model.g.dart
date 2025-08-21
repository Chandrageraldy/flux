// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_goals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyGoalsModelImpl _$$DailyGoalsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyGoalsModelImpl(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      goalType: json['goalType'] as String?,
      goalDesc: json['goalDesc'] as String?,
      energyReward: (json['energyReward'] as num?)?.toInt(),
      isClaimed: json['isClaimed'] as bool?,
      currentValue: (json['currentValue'] as num?)?.toInt(),
      targetValue: (json['targetValue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DailyGoalsModelImplToJson(
        _$DailyGoalsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'goalType': instance.goalType,
      'goalDesc': instance.goalDesc,
      'energyReward': instance.energyReward,
      'isClaimed': instance.isClaimed,
      'currentValue': instance.currentValue,
      'targetValue': instance.targetValue,
    };
