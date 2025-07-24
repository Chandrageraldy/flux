// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'alt_measure_model.freezed.dart';
part 'alt_measure_model.g.dart';

@freezed
class AltMeasureModel with _$AltMeasureModel {
  factory AltMeasureModel({
    @JsonKey(name: 'serving_weight') double? servingWeight,
    String? measure,
    double? seq,
    double? qty,
  }) = _AltMeasureModel;

  factory AltMeasureModel.fromJson(Map<String, dynamic> json) => _$AltMeasureModelFromJson(json);
}
