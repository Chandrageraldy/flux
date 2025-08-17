import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/body_metrics_model/body_metrics_model.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class PersonalDetailsViewModel extends BaseViewModel {
  final UserRepository userRepository = UserRepository();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> modifiedPersonalDetails = {};
  Map<String, String> unmodifiedPersonalDetails = {};

  bool isTargetWeeklyChangeEnabled = true;

  PersonalDetailsViewModel() {
    _init();
  }

  void _init() {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;

    modifiedPersonalDetails = {
      PersonalDetailsSettings.dob.key: bodyMetrics?.dob ?? '',
      PersonalDetailsSettings.gender.key: bodyMetrics?.gender ?? '',
      PersonalDetailsSettings.weight.key: bodyMetrics?.weight ?? '',
      PersonalDetailsSettings.height.key: bodyMetrics?.height ?? '',
      PersonalDetailsSettings.activityLevel.key: bodyMetrics?.activityLevel ?? '',
      PersonalDetailsSettings.exerciseLevel.key: bodyMetrics?.exerciseLevel ?? '',
      PersonalDetailsSettings.targetWeight.key: bodyMetrics?.targetWeight ?? '',
      PersonalDetailsSettings.targetWeeklyChange.key: bodyMetrics?.targetWeeklyChange ?? '',
      TableCol.dietType: bodyMetrics?.dietType ?? '',
      TableCol.goal: bodyMetrics?.goal ?? '',
    };

    unmodifiedPersonalDetails = modifiedPersonalDetails;

    isTargetWeeklyChangeEnabled = (modifiedPersonalDetails[PersonalDetailsSettings.weight.key] ?? '') !=
        (modifiedPersonalDetails[PersonalDetailsSettings.targetWeight.key] ?? '');

    notifyListeners();
  }

  void onItemSelected(String key, String value) {
    // Use this instead of 'personalDetails[key] = value' to provide new reference for notifying listener
    modifiedPersonalDetails = {...modifiedPersonalDetails, key: value};
    isTargetWeeklyChangeEnabled = (modifiedPersonalDetails[PersonalDetailsSettings.weight.key] ?? '') !=
        (modifiedPersonalDetails[PersonalDetailsSettings.targetWeight.key] ?? '');

    if (!isTargetWeeklyChangeEnabled) {
      modifiedPersonalDetails[PersonalDetailsSettings.targetWeeklyChange.key] = '';
    } else {
      modifiedPersonalDetails[PersonalDetailsSettings.targetWeeklyChange.key] = '0.5';
    }

    final weightStr = modifiedPersonalDetails[PersonalDetailsSettings.weight.key];
    final targetWeightStr = modifiedPersonalDetails[PersonalDetailsSettings.targetWeight.key];

    final weight = double.tryParse(weightStr ?? '');
    final targetWeight = double.tryParse(targetWeightStr ?? '');

    if (weight! > targetWeight!) {
      modifiedPersonalDetails[TableCol.goal] = PlanSelectionValue.lose.value;
    } else if (weight < targetWeight) {
      modifiedPersonalDetails[TableCol.goal] = PlanSelectionValue.gain.value;
    } else {
      modifiedPersonalDetails[TableCol.goal] = PlanSelectionValue.maintain.value;
    }

    notifyListeners();
  }

  Future<bool> updateBodyMetrics() async {
    if (modifiedPersonalDetails == unmodifiedPersonalDetails) {
      return false;
    }

    final response = await userRepository.updateBodyMetrics(bodyMetrics: modifiedPersonalDetails);
    return response.status == ResponseStatus.COMPLETE;
  }
}
