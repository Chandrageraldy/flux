import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/recent_food_model.dart/recent_food_model.dart';
import 'package:flux/app/models/saved_food_model.dart/saved_food_model.dart';
import 'package:flux/app/services/supabase_base_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodServiceSupabase extends SupabaseBaseService {
  final supabase = Supabase.instance.client;

  Future<Response> saveOrUnsaveFood({
    required SavedFoodModel savedFoodModel,
    required String userId,
    required bool isSaved,
  }) async {
    final requestBody = savedFoodModel.toJson();
    requestBody.remove(TableCol.id);

    if (isSaved) {
      final filters = {
        TableCol.userId: userId,
        if (savedFoodModel.tagId != null)
          TableCol.tagId: savedFoodModel.tagId
        else
          TableCol.nixItemId: savedFoodModel.nixItemId,
      };

      return callSupabaseDB(
        requestType: RequestType.DELETE,
        table: TableName.savedFood,
        filters: filters,
      );
    } else {
      return callSupabaseDB(
        requestType: RequestType.POST,
        table: TableName.savedFood,
        requestBody: requestBody,
      );
    }
  }

  Future<Response> checkIfSaved({
    required bool isCommonFood,
    String? tagId,
    String? nixItemId,
    required String userId,
  }) async {
    if (isCommonFood) {
      return callSupabaseDB(
        requestType: RequestType.GET,
        table: TableName.savedFood,
        filters: {TableCol.tagId: tagId, TableCol.userId: userId},
      );
    } else {
      return callSupabaseDB(
        requestType: RequestType.GET,
        table: TableName.savedFood,
        filters: {TableCol.nixItemId: nixItemId, TableCol.userId: userId},
      );
    }
  }

  Future<Response> getSavedFoods({required String userId}) async {
    return callSupabaseDB(requestType: RequestType.GET, table: TableName.savedFood, filters: {TableCol.userId: userId});
  }

  Future<Response> getRecentFoods({required String userId}) async {
    return callSupabaseDB(
      requestType: RequestType.GET,
      table: TableName.recentFood,
      filters: {TableCol.userId: userId},
      orderBy: TableCol.lastViewedAt,
    );
  }

  Future<Response> checkIfRecent({
    required bool isCommonFood,
    String? tagId,
    String? nixItemId,
    required String userId,
  }) {
    if (isCommonFood) {
      return callSupabaseDB(
        requestType: RequestType.GET,
        table: TableName.recentFood,
        filters: {TableCol.tagId: tagId, TableCol.userId: userId},
      );
    } else {
      return callSupabaseDB(
        requestType: RequestType.GET,
        table: TableName.recentFood,
        filters: {TableCol.nixItemId: nixItemId, TableCol.userId: userId},
      );
    }
  }

  Future<Response> deleteBasedOnId({
    required String table,
    required int id,
  }) {
    return callSupabaseDB(
      requestType: RequestType.DELETE,
      table: table,
      filters: {TableCol.id: id},
    );
  }

  Future<Response> saveAsRecent({required RecentFoodModel recentFoodModel}) async {
    final requestBody = recentFoodModel.toJson();
    requestBody.remove(TableCol.id);
    requestBody.remove(TableCol.lastViewedAt);

    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.recentFood,
      requestBody: requestBody,
    );
  }

  Future<Response> logFood({required LoggedFoodModel loggedFoodModel}) async {
    final requestBody = loggedFoodModel.toJson();
    requestBody.remove(TableCol.id);
    requestBody.remove(TableCol.loggedAt);

    return callSupabaseDB(
      requestType: RequestType.POST,
      table: TableName.loggedFood,
      requestBody: requestBody,
    );
  }
}
