import 'dart:io';

import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class AccountViewModel extends BaseViewModel {
  UserRepository userRepository = UserRepository();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();
  Map<String, String> modifiedAccount = {};
  Map<String, String> unmodifiedAccount = {};

  AccountViewModel() {
    _init();
  }

  void _init() {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();

    modifiedAccount = {
      AccountSettings.username.key: user?.username ?? '',
      AccountSettings.email.key: user?.email ?? '',
    };

    unmodifiedAccount = modifiedAccount;

    notifyListeners();
  }

  void onConfirm(String key, String value) {
    modifiedAccount = {...modifiedAccount, key: value};
    notifyListeners();
  }

  Future<bool> updateAccount({required File? selectedImage}) async {
    if (modifiedAccount[AccountSettings.username.key] == unmodifiedAccount[AccountSettings.username.key] &&
        selectedImage == null) {
      return false;
    }

    final response = await userRepository.updateAccount(
      username: modifiedAccount[AccountSettings.username.key] ?? '',
      selectedImage: selectedImage,
    );
    checkError(response);

    return response.status == ResponseStatus.COMPLETE;
  }
}
