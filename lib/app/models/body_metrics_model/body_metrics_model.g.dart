// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BodyMetricsModelImpl _$$BodyMetricsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BodyMetricsModelImpl(
      goal: json['goal'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      dob: json['dob'] as String?,
      targetWeight: json['targetWeight'] as String?,
      targetWeeklyGain: json['targetWeeklyGain'] as String?,
      activityLevel: json['activityLevel'] as String?,
      exerciseLevel: json['exerciseLevel'] as String?,
      dietType: json['dietType'] as String?,
    );

Map<String, dynamic> _$$BodyMetricsModelImplToJson(
        _$BodyMetricsModelImpl instance) =>
    <String, dynamic>{
      'goal': instance.goal,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'dob': instance.dob,
      'targetWeight': instance.targetWeight,
      'targetWeeklyGain': instance.targetWeeklyGain,
      'activityLevel': instance.activityLevel,
      'exerciseLevel': instance.exerciseLevel,
      'dietType': instance.dietType,
    };
