// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_energy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEnergyModelImpl _$$UserEnergyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserEnergyModelImpl(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      energies: (json['energies'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserEnergyModelImplToJson(
        _$UserEnergyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'energies': instance.energies,
    };
