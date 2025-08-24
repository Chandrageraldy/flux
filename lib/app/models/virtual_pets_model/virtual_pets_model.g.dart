// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_pets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VirtualPetsModelImpl _$$VirtualPetsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VirtualPetsModelImpl(
      petId: (json['petId'] as num?)?.toInt(),
      name: json['name'] as String?,
      lvl1Url: json['lvl1Url'] as String?,
      lvl2Url: json['lvl2Url'] as String?,
      lvl3Url: json['lvl3Url'] as String?,
      lvl4Url: json['lvl4Url'] as String?,
      requiredExpLvl1: (json['requiredExpLvl1'] as num?)?.toInt(),
      requiredExpLvl2: (json['requiredExpLvl2'] as num?)?.toInt(),
      requiredExpLvl3: (json['requiredExpLvl3'] as num?)?.toInt(),
      energyCost: (json['energyCost'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$VirtualPetsModelImplToJson(
        _$VirtualPetsModelImpl instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'name': instance.name,
      'lvl1Url': instance.lvl1Url,
      'lvl2Url': instance.lvl2Url,
      'lvl3Url': instance.lvl3Url,
      'lvl4Url': instance.lvl4Url,
      'requiredExpLvl1': instance.requiredExpLvl1,
      'requiredExpLvl2': instance.requiredExpLvl2,
      'requiredExpLvl3': instance.requiredExpLvl3,
      'energyCost': instance.energyCost,
      'imageUrl': instance.imageUrl,
    };
