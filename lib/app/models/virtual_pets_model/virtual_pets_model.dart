import 'package:freezed_annotation/freezed_annotation.dart';

part 'virtual_pets_model.freezed.dart';
part 'virtual_pets_model.g.dart';

@freezed
class VirtualPetsModel with _$VirtualPetsModel {
  factory VirtualPetsModel({
    int? petId,
    String? name,
    String? lvl1Url,
    String? lvl2Url,
    String? lvl3Url,
    String? lvl4Url,
    int? requiredExpLvl1,
    int? requiredExpLvl2,
    int? requiredExpLvl3,
    int? energyCost,
  }) = _VirtualPetsModel;

  factory VirtualPetsModel.fromJson(Map<String, dynamic> json) => _$VirtualPetsModelFromJson(json);
}
