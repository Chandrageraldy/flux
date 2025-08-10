// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_nutrients_model.freezed.dart';
part 'full_nutrients_model.g.dart';

@freezed
class FullNutrientsModel with _$FullNutrientsModel {
  factory FullNutrientsModel({
    @JsonKey(name: 'attr_id') int? attrId,
    double? value,
  }) = _FullNutrientsModel;

  factory FullNutrientsModel.fromJson(Map<String, dynamic> json) => _$FullNutrientsModelFromJson(json);
}
