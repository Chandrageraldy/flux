// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPlanModelImpl _$$UserPlanModelImplFromJson(Map<String, dynamic> json) =>
    _$UserPlanModelImpl(
      goal: json['goal'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      targetWeight: json['targetWeight'] as String?,
      targetWeekly: json['targetWeekly'] as String?,
      activityLevel: json['activityLevel'] as String?,
      exerciseLevel: json['exerciseLevel'] as String?,
    );

Map<String, dynamic> _$$UserPlanModelImplToJson(_$UserPlanModelImpl instance) =>
    <String, dynamic>{
      'goal': instance.goal,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'targetWeight': instance.targetWeight,
      'targetWeekly': instance.targetWeekly,
      'activityLevel': instance.activityLevel,
      'exerciseLevel': instance.exerciseLevel,
    };
