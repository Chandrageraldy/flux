import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/body_metrics_model/body_metrics_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class PersonalDetailsViewModel extends BaseViewModel {
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> personalDetails = {};

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
    };
    notifyListeners();
  }
}
