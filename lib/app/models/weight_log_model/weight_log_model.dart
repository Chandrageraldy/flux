import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_log_model.freezed.dart';
part 'weight_log_model.g.dart';

@freezed
class WeightLogModel with _$WeightLogModel {
  factory WeightLogModel({
    int? id,
    int? weight,
    String? userId,
    DateTime? createdAt,
  }) = _WeightLogModel;

  factory WeightLogModel.fromJson(Map<String, dynamic> json) => _$WeightLogModelFromJson(json);
}
