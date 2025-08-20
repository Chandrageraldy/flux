// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPetModelImpl _$$UserPetModelImplFromJson(Map<String, dynamic> json) =>
    _$UserPetModelImpl(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      petId: (json['petId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      currentExp: (json['currentExp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserPetModelImplToJson(_$UserPetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'petId': instance.petId,
      'isActive': instance.isActive,
      'currentExp': instance.currentExp,
    };
