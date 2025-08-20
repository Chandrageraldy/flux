// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_user_pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveUserPetModelImpl _$$ActiveUserPetModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveUserPetModelImpl(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      petId: (json['petId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      currentExp: (json['currentExp'] as num?)?.toInt(),
      virtualPet: json['virtual_pets'] == null
          ? null
          : VirtualPetsModel.fromJson(
              json['virtual_pets'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ActiveUserPetModelImplToJson(
        _$ActiveUserPetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'petId': instance.petId,
      'isActive': instance.isActive,
      'currentExp': instance.currentExp,
      'virtual_pets': instance.virtualPet,
    };
