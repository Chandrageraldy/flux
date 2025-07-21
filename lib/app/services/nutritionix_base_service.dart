import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

enum HttpRequestType { get, post, put, delete }

// Use dio. to distinguish the Response class from response_model.dart and dio itself
class NutritionixBaseService {
  final dio.Dio _dio;

  NutritionixBaseService({
    String? baseUrl,
  }) : _dio = dio.Dio(
          dio.BaseOptions(
            baseUrl: baseUrl ?? 'https://trackapi.nutritionix.com/v2',
            headers: {
              'Content-Type': 'application/json',
              'x-app-id': dotenv.env[Env.nutritionixAppId] ?? '',
              'x-app-key': dotenv.env[Env.nutritionixAppKey] ?? '',
            },
          ),
        );

  Future<Response<dynamic, String>> callAPI(
    HttpRequestType type,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      late dio.Response dioResponse;

      switch (type) {
        case HttpRequestType.get:
          dioResponse = await _dio.get(path, queryParameters: queryParameters);
          break;
        case HttpRequestType.post:
          dioResponse = await _dio.post(path, data: body);
          break;
        case HttpRequestType.put:
          dioResponse = await _dio.put(path, data: body);
          break;
        case HttpRequestType.delete:
          dioResponse = await _dio.delete(path, data: body);
          break;
      }

      final code = dioResponse.statusCode ?? 0;
      if (code == HttpStatus.ok || code == HttpStatus.created || code == HttpStatus.accepted) {
        return Response.complete(dioResponse.data);
      }

      return Response.error('Unexpected status code: $code');
    } on dio.DioException catch (e) {
      return Response.error(e.message ?? 'Dio error');
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
