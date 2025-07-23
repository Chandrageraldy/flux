// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_nutrients_model.freezed.dart';
part 'full_nutrients_model.g.dart';

@freezed
class FullNutrient with _$FullNutrient {
  factory FullNutrient({
    @JsonKey(name: 'attr_id') int? attrId,
    double? value,
  }) = _FullNutrient;

  factory FullNutrient.fromJson(Map<String, dynamic> json) => _$FullNutrientFromJson(json);
}
