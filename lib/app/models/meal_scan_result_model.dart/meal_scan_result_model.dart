import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_scan_result_model.freezed.dart';
part 'meal_scan_result_model.g.dart';

@freezed
class MealScanResultModel with _$MealScanResultModel {
  factory MealScanResultModel({
    String? foodName,
    double? healthScore,
    String? healthScoreDesc,
    double? quantity,
  }) = _MealScanResultModel;

  factory MealScanResultModel.fromJson(Map<String, dynamic> json) => _$MealScanResultModelFromJson(json);
}
