import 'dart:io';

import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/auth_model/email_auth_request_model.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/models/user_pet_model/user_pet_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService extends SupabaseBaseService {
  final supabase = Supabase.instance.client;

  Future<Response> loginWithEmailAndPassword(EmailAuthRequestModel model) {
    return authenticate(authType: AuthType.EMAILLOGIN, requestBody: model.toJson());
  }

  Future<Response> signUpWithEmailAndPassword(EmailAuthRequestModel model) {
    return authenticate(authType: AuthType.EMAILSIGNUP, requestBody: model.toJson());
  }

  Future<Response> logout() {
    return authenticate(authType: AuthType.LOGOUT);
  }

  Future<Response> sendResetToken({required String email}) {
    return authenticate(authType: AuthType.SENDRESETTOKEN, requestBody: {'email': email});
  }

  Future<Response> verifyOtp({required String email, required String otp}) {
    return authenticate(authType: AuthType.VERIFYOTP, requestBody: {'email': email, 'otp': otp});
  }

  Future<Response> resetPassword({required String password}) {
    return authenticate(authType: AuthType.RESETPASSWORD, requestBody: {'password': password});
  }

  Future<Response> createUserProfile({required UserProfileModel model}) {
    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.user,
      requestBody: model.toJson(),
    );
  }

  Future<Response> getUserProfile({required String userId}) {
    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.user,
      filters: {TableCol.userId: userId},
    );
  }

  Future<Response> updateUserProfile({required Map<String, dynamic> bodyMetrics, required String userId}) {
    return callSupabaseDB(
      requestType: RequestType.PUT,
      table: TableName.user,
      requestBody: {
        TableCol.bodyMetrics: bodyMetrics,
      },
      filters: {TableCol.userId: userId},
    );
  }

  Future<Response> assignVirtualPet({required UserPetModel userPet}) {
    final json = userPet.toJson();
    json.remove(TableCol.id);

    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.userPet,
      requestBody: json,
    );
  }

  Future<Response> updateAccount({required String username, required String? selectedImage, required String userId}) {
    if (selectedImage == null) {
      return callSupabaseDB(
        requestType: RequestType.PUT,
        table: TableName.user,
        requestBody: {
          TableCol.username: username,
        },
        filters: {TableCol.userId: userId},
      );
    }

    return callSupabaseDB(
      requestType: RequestType.PUT,
      table: TableName.user,
      requestBody: {
        TableCol.username: username,
        TableCol.photoUrl: selectedImage,
      },
      filters: {TableCol.userId: userId},
    );
  }

  Future<Response> uploadProfileImage({required File imageFile, required String filePath}) async {
    return callSupabaseBucket(
      bucketRequestType: BucketRequestType.upload,
      bucketName: BucketName.profileImageBucket,
      filePath: filePath,
      file: imageFile,
    );
  }
}
