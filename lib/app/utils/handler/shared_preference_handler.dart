import 'dart:convert';

import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static SharedPreferences? _sharedPreferences;
  static final SharedPreferenceHandler _instance = SharedPreferenceHandler._internal();
  static const spLocale = 'locale';
  static const spIsDarkMode = 'isDarkMode';
  static const spHasOnboarded = 'hasOnboarded';
  static const spUser = 'user';
  static const spPlan = 'plan';
  static const spIsTutorialComplete = 'isTutorialComplete';

  // Factory constructor that returns the single instance.
  factory SharedPreferenceHandler() {
    return _instance;
  }

  SharedPreferenceHandler._internal();

  Future<void> initialize() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // Locale
  String getLocale() {
    return _sharedPreferences?.getString(spLocale) ?? '';
  }

  Future<bool?> putLocale(String? language) async {
    return _sharedPreferences?.setString(spLocale, language ?? '');
  }

  // Is Tutorial Complete
  bool? getIsTutorialComplete() {
    return _sharedPreferences?.getBool(spIsTutorialComplete);
  }

  Future<bool?> putIsTutorialComplete(bool isTutorialComplete) async {
    return _sharedPreferences?.setBool(spIsTutorialComplete, isTutorialComplete);
  }

  // Is Dark Mode
  bool getIsDarkMode() {
    return _sharedPreferences?.getBool(spIsDarkMode) ?? false;
  }

  Future<bool?> putIsDarkMode(bool isDarkMode) async {
    return _sharedPreferences?.setBool(spIsDarkMode, isDarkMode);
  }

  // Has Onboarded
  bool getHasOnboarded() {
    return _sharedPreferences?.getBool(spHasOnboarded) ?? false;
  }

  Future<bool?> putHasOnboarded(bool hasOnboarded) async {
    return _sharedPreferences?.setBool(spHasOnboarded, hasOnboarded);
  }

  // User
  UserProfileModel? getUser() {
    final String userString = _sharedPreferences?.getString(spUser) ?? '';
    if (userString.isNotEmpty) {
      final userMap = jsonDecode(userString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(userMap);
    }
    return null;
  }

  Future<bool?> putUser(UserProfileModel user) async {
    return _sharedPreferences?.setString(spUser, jsonEncode(user.toJson()));
  }

  // Plan
  PlanModel? getPlan() {
    final String planString = _sharedPreferences?.getString(spPlan) ?? '';
    if (planString.isNotEmpty) {
      final planMap = jsonDecode(planString) as Map<String, dynamic>;
      return PlanModel.fromJson(planMap);
    }
    return null;
  }

  Future<bool?> putPlan(PlanModel plan) async {
    return _sharedPreferences?.setString(spPlan, jsonEncode(plan.toJson()));
  }

  // Remove All
  Future<void> removeAll() async {
    if (_sharedPreferences == null) return;

    await Future.wait([
      _sharedPreferences!.remove(spHasOnboarded),
      _sharedPreferences!.remove(spIsDarkMode),
      _sharedPreferences!.remove(spLocale),
      _sharedPreferences!.remove(spUser),
    ]);
  }

  // Logout
  Future<void> logout() async {
    if (_sharedPreferences == null) return;

    await Future.wait([
      _sharedPreferences!.remove(spIsDarkMode),
      _sharedPreferences!.remove(spLocale),
      _sharedPreferences!.remove(spUser),
      _sharedPreferences!.remove(spPlan),
      _sharedPreferences!.remove(spIsTutorialComplete),
    ]);
  }
}
