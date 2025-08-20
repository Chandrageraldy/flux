import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_pet_model.freezed.dart';
part 'user_pet_model.g.dart';

@freezed
class UserPetModel with _$UserPetModel {
  factory UserPetModel({
    int? id,
    String? userId,
    int? petId,
    bool? isActive,
    int? currentExp,
  }) = _UserPetModel;

  factory UserPetModel.fromJson(Map<String, dynamic> json) => _$UserPetModelFromJson(json);
}
