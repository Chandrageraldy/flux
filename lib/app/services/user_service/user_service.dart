import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/auth_model/email_auth_request_model.dart';
import 'package:flux/app/models/response_model.dart';
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
}
