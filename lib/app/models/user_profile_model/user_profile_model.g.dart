// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      bodyMetrics: json['bodyMetrics'] == null
          ? null
          : BodyMetricsModel.fromJson(
              json['bodyMetrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'bodyMetrics': instance.bodyMetrics,
    };
