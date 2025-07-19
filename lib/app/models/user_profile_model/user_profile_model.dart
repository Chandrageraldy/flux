import 'package:flux/app/models/body_metrics_model/body_metrics_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    String? userId,
    String? username,
    String? email,
    String? photoUrl,
    BodyMetricsModel? bodyMetrics,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
}
