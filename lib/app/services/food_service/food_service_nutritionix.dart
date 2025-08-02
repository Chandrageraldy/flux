import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/services/nutritionix_base_service.dart';

class FoodServiceNutritionix extends NutritionixBaseService {
  FoodServiceNutritionix() : super();

  Future<Response> searchInstant({required String query}) async {
    return callNutritionixAPI(
      HttpRequestType.get,
      NutritionixEndpoint.instantSearch,
      queryParameters: {NutritionixParam.query: query},
    );
  }

  Future<Response> getFoodDetails({required bool isCommonFood, String? foodName, String? nixItemId}) async {
    if (isCommonFood) {
      return callNutritionixAPI(
        HttpRequestType.post,
        NutritionixEndpoint.naturalLanuageSearch,
        body: {NutritionixParam.query: foodName},
      );
    } else {
      return callNutritionixAPI(
        HttpRequestType.get,
        NutritionixEndpoint.searchItem,
        queryParameters: {NutritionixParam.nixItemId: nixItemId},
      );
    }
  }

  Future<Response> getFoodDetailsWithUPC({required String upc}) async {
    return callNutritionixAPI(
      HttpRequestType.get,
      NutritionixEndpoint.searchItem,
      queryParameters: {NutritionixParam.upc: upc},
    );
  }
}
