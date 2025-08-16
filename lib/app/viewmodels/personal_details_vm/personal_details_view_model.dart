import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/body_metrics_model/body_metrics_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class PersonalDetailsViewModel extends BaseViewModel {
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> personalDetails = {};

  bool isTargetWeeklyChangeEnabled = true;

  PersonalDetailsViewModel() {
    _init();
  }

  void _init() {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;

    personalDetails = {
      PersonalDetailsSettings.dob.key: bodyMetrics?.dob ?? '',
      PersonalDetailsSettings.gender.key: bodyMetrics?.gender ?? '',
      PersonalDetailsSettings.weight.key: bodyMetrics?.weight ?? '',
      PersonalDetailsSettings.height.key: bodyMetrics?.height ?? '',
      PersonalDetailsSettings.activityLevel.key: bodyMetrics?.activityLevel ?? '',
      PersonalDetailsSettings.exerciseLevel.key: bodyMetrics?.exerciseLevel ?? '',
      PersonalDetailsSettings.targetWeight.key: bodyMetrics?.targetWeight ?? '',
      PersonalDetailsSettings.targetWeeklyChange.key: bodyMetrics?.targetWeeklyChange ?? '',
    };

    isTargetWeeklyChangeEnabled = (personalDetails[PersonalDetailsSettings.weight.key] ?? '') !=
        (personalDetails[PersonalDetailsSettings.targetWeight.key] ?? '');

    notifyListeners();
  }

  void onItemSelected(String key, String value) {
    // Use this instead of 'personalDetails[key] = value' to provide new reference for notifying listener
    personalDetails = {...personalDetails, key: value};
    isTargetWeeklyChangeEnabled = (personalDetails[PersonalDetailsSettings.weight.key] ?? '') !=
        (personalDetails[PersonalDetailsSettings.targetWeight.key] ?? '');

    if (!isTargetWeeklyChangeEnabled) {
      personalDetails[PersonalDetailsSettings.targetWeeklyChange.key] = '';
    }

    notifyListeners();
  }
}
