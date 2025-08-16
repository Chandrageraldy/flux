import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class AccountViewModel extends BaseViewModel {
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> account = {};

  AccountViewModel() {
    _init();
  }

  void _init() {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();

    account = {
      AccountSettings.username.key: user?.username ?? '',
      AccountSettings.email.key: user?.email ?? '',
    };

    notifyListeners();
  }

  void onConfirm(String key, String value) {
    account = {...account, key: value};
    notifyListeners();
  }
}
