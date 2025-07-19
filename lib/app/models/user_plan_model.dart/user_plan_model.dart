import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_plan_model.freezed.dart';
part 'user_plan_model.g.dart';

@freezed
class UserPlanModel with _$UserPlanModel {
  factory UserPlanModel({
    String? goal,
    String? gender,
    String? height,
    String? weight,
    String? targetWeight,
    String? targetWeekly,
    String? activityLevel,
    String? exerciseLevel,
  }) = _UserPlanModel;

  factory UserPlanModel.fromJson(Map<String, dynamic> json) => _$UserPlanModelFromJson(json);
}
