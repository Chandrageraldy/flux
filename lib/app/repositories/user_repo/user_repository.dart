import 'dart:io';

import 'package:flux/app/models/auth_model/email_auth_request_model.dart';
import 'package:flux/app/models/body_metrics_model/body_metrics_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/services/user_service/user_service.dart';

import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class UserRepository {
  final UserService userService = UserService();
  final SharedPreferenceHandler sharedPreferenceHandler = SharedPreferenceHandler();

  bool get isLoggedIn => sharedPreferenceHandler.getUser() != null;

  Future<Response> loginWithEmailAndPassword({required String email, required String password}) async {
    EmailAuthRequestModel model = EmailAuthRequestModel(email: email, password: password);
    final response = await userService.loginWithEmailAndPassword(model);
    return response;
  }

  Future<Response> signUpWithEmailAndPassword({required String email, required String password}) async {
    EmailAuthRequestModel model = EmailAuthRequestModel(email: email, password: password);
    final response = await userService.signUpWithEmailAndPassword(model);
    return response;
  }

  Future<Response> logout() async {
    final response = await userService.logout();
    sharedPreferenceHandler.logout();
    return response;
  }

  Future<Response> sendResetToken({required String email}) async {
    final response = await userService.sendResetToken(email: email);
    return response;
  }

  Future<Response> verifyOtp({required String email, required String otp}) async {
    final response = await userService.verifyOtp(email: email, otp: otp);
    return response;
  }

  Future<Response> resetPassword({required String password}) async {
    final response = await userService.resetPassword(password: password);
    sharedPreferenceHandler.logout();
    return response;
  }

  Future<Response> createUserProfile({
    required String userId,
    required String email,
    required String username,
    required Map<String, String> bodyMetrics,
  }) async {
    UserProfileModel model = UserProfileModel(
      userId: userId,
      email: email,
      username: username,
      photoUrl:
          'https://boatxsvwhwnhmbmuiesv.supabase.co/storage/v1/object/public/profile_image/profile-placeholder.png',
      bodyMetrics: BodyMetricsModel.fromJson(bodyMetrics),
    );
    final response = await userService.createUserProfile(model: model);
    if (response.error == null) {
      await processUserProfile(response.data as List<Map<String, dynamic>>);
    }
    return response;
  }

  Future<Response> getUserProfile({required String userId}) async {
    final response = await userService.getUserProfile(userId: userId);
    if (response.error == null) {
      await processUserProfile(response.data as List<Map<String, dynamic>>);
    }
    return response;
  }

  Future<Response> updateBodyMetrics({required Map<String, String> bodyMetrics}) async {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();

    final response = await userService.updateUserProfile(bodyMetrics: bodyMetrics, userId: user?.userId ?? '');
    if (response.error == null) {
      await processUserProfile(response.data as List<Map<String, dynamic>>);
    }
    return response;
  }

  Future<Response> updateAccount({required String username, required File? selectedImage}) async {
    final UserProfileModel? user = sharedPreferenceHandler.getUser();

    if (selectedImage != null) {
      final fileExtension = selectedImage.path.split('.').last;
      // Generate unique file path using userId and timestamp to prevent file name duplication
      final filePath = '${user?.userId}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      final uploadResponse = await userService.uploadProfileImage(imageFile: selectedImage, filePath: filePath);

      if (uploadResponse.error == null) {
        final response = await userService.updateAccount(
          username: username,
          selectedImage: uploadResponse.data,
          userId: user?.userId ?? '',
        );
        if (response.error == null) {
          await processUserProfile(response.data as List<Map<String, dynamic>>);
        }
        return response;
      }
      return uploadResponse;
    } else {
      final response = await userService.updateAccount(
        username: username,
        selectedImage: null,
        userId: user?.userId ?? '',
      );

      if (response.error == null) {
        await processUserProfile(response.data as List<Map<String, dynamic>>);
      }
      return response;
    }
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on UserRepository {
  Future<void> processUserProfile(List<Map<String, dynamic>> user) async {
    UserProfileModel model = UserProfileModel.fromJson(user[0]);

    await sharedPreferenceHandler.putUser(model);

    debugPrint('${sharedPreferenceHandler.getUser()}');
  }
}
