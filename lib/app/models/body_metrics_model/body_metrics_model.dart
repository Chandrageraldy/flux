import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_metrics_model.freezed.dart';
part 'body_metrics_model.g.dart';

@freezed
class BodyMetricsModel with _$BodyMetricsModel {
  factory BodyMetricsModel({
    String? goal,
    String? gender,
    String? height,
    String? weight,
    String? dob,
    String? targetWeight,
    String? targetWeekly,
    String? activityLevel,
    String? exerciseLevel,
  }) = _BodyMetricsModel;

  factory BodyMetricsModel.fromJson(Map<String, dynamic> json) => _$BodyMetricsModelFromJson(json);
}
