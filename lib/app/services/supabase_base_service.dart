import 'dart:io';

import 'package:flux/app/models/error_model/error_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flux/app/assets/exporter/exporter_app_general.dart';

abstract class SupabaseBaseService {
  /// Authenticates a user based on the provided [authType] and optional [requestBody].
  /// - Supports email sign-up, email login, and logout operations.
  /// - Returns a [Response] containing the user data on success or an error response on failure.
  Future<Response> authenticate({Map<String, dynamic>? requestBody, required AuthType authType}) async {
    try {
      AuthResponse? response;
      final supabase = Supabase.instance.client;
      switch (authType) {
        case AuthType.EMAILSIGNUP:
          response = await supabase.auth.signUp(
            email: requestBody!['email'],
            password: requestBody['password'],
          );
        case AuthType.EMAILLOGIN:
          response = await supabase.auth.signInWithPassword(
            email: requestBody!['email'],
            password: requestBody['password'],
          );
        case AuthType.LOGOUT:
          await supabase.auth.signOut();
          return Response.complete(true);
      }
      return Response.complete(response.user);
    } on AuthException catch (e) {
      debugPrint(e.code);
      debugPrint(e.message);
      return _handleSupabaseException(e.code);
    } catch (e) {
      return Response.error(e);
    }
  }

  /// Executes a database operation on the specified [table] based on the [requestType].
  /// - Supports GET, POST, PUT, and DELETE requests.
  /// - Filters are required for PUT and DELETE operations to identify specific records.
  /// - Returns a [Response] with the retrieved or modified data or an error response if the operation fails.
  Future<Response> callSupabaseDB({
    required RequestType requestType,
    required String table,
    Map<dynamic, dynamic>? requestBody,
    Map<String, dynamic>? filters,
    String? column,
    String? orderBy,
    Map<String, Map<String, dynamic>>? rangeFilters,
    bool ascending = false,
    int? limit,
  }) async {
    try {
      final supabase = Supabase.instance.client;
      final PostgrestList response;
      dynamic filterBuilder;

      switch (requestType) {
        case RequestType.GET:
          if (column != null) {
            filterBuilder = supabase.from(table).select(column);
          } else {
            filterBuilder = supabase.from(table).select();
          }

          break;
        case RequestType.POST:
          filterBuilder = supabase.from(table).insert(requestBody as Object);
          break;
        case RequestType.PUT:
          filterBuilder = supabase.from(table).update(requestBody!);
          break;
        case RequestType.DELETE:
          filterBuilder = supabase.from(table).delete();
          break;
      }

      // Apply equality filters
      if (filters != null) {
        filters.forEach((key, value) {
          if (value != null) {
            filterBuilder = filterBuilder?.eq(key, value);
          }
        });
      }

      // Apply range filters
      if (rangeFilters != null) {
        rangeFilters.forEach((columnName, conditions) {
          conditions.forEach((operator, value) {
            if (value != null) {
              switch (operator) {
                case 'gte':
                  filterBuilder = filterBuilder?.gte(columnName, value);
                  break;
                case 'gt':
                  filterBuilder = filterBuilder?.gt(columnName, value);
                  break;
                case 'lte':
                  filterBuilder = filterBuilder?.lte(columnName, value);
                  break;
                case 'lt':
                  filterBuilder = filterBuilder?.lt(columnName, value);
                  break;
              }
            }
          });
        });
      }

      // Apply ordering
      if (orderBy != null) {
        filterBuilder = filterBuilder?.order(orderBy, ascending: ascending);
      }

      if (column != null) {
        response = await filterBuilder ?? [];
      } else if (limit != null) {
        response = await filterBuilder?.limit(limit) ?? [];
      } else {
        response = await filterBuilder?.select() ?? [];
      }

      // Return urgent error if response is empty
      // if (response.isEmpty) {
      //   return _handleSupabaseException(SupabaseExceptionType.permissionDenied);
      // }

      return Response.complete(response);
    } on PostgrestException catch (e) {
      debugPrint(e.code);
      debugPrint(e.message);
      return _handleSupabaseException(e.code);
    } catch (e) {
      return Response.error(e);
    }
  }

  Response _handleSupabaseException(String? e) {
    String message;
    switch (e) {
      case SupabaseExceptionType.invalidCredentials:
        message = S.current.invalidCredential;
      case SupabaseExceptionType.userAlreadyExists:
        message = S.current.usedEmail;
      case SupabaseExceptionType.permissionDenied:
        message = S.current.permissionDenied;
        return Response.error(ErrorModel(code: e, message: message, isUrgentError: true));
      default:
        message = S.current.requestError;
    }

    return Response.error(ErrorModel(code: e, message: message));
  }

  Future<Response> callSupabaseBucket({
    required BucketRequestType bucketRequestType,
    required String bucketName,
    required String filePath,
    File? file,
  }) async {
    try {
      final supabase = Supabase.instance.client;
      final storage = supabase.storage.from(bucketName);

      dynamic result;

      switch (bucketRequestType) {
        case BucketRequestType.upload:
          await storage.upload(filePath, file!);
          result = storage.getPublicUrl(filePath);
          break;
        case BucketRequestType.delete:
          result = await storage.remove([filePath]);
          break;
      }

      return Response.complete(result);
    } on StorageException catch (e) {
      debugPrint('Supabase Storage Error: ${e.error}');
      return Response.error(e.message);
    } catch (e) {
      debugPrint('Unknown Error: $e');
      return Response.error(e);
    }
  }
}

enum RequestType { GET, POST, PUT, DELETE }

enum AuthType { EMAILSIGNUP, EMAILLOGIN, LOGOUT }

class SupabaseExceptionType {
  static const invalidCredentials = 'invalid_credentials';
  static const userAlreadyExists = 'user_already_exists';
  static const permissionDenied = 'permission_denied';
}

enum BucketRequestType { upload, delete }
