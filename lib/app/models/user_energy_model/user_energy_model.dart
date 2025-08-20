import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_energy_model.freezed.dart';
part 'user_energy_model.g.dart';

@freezed
class UserEnergyModel with _$UserEnergyModel {
  factory UserEnergyModel({
    int? id,
    String? userId,
    int? energies,
  }) = _UserEnergyModel;

  factory UserEnergyModel.fromJson(Map<String, dynamic> json) => _$UserEnergyModelFromJson(json);
}
