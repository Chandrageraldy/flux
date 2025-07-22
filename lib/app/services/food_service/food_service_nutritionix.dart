import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/services/nutritionix_base_service.dart';

class FoodServiceNutritionix extends NutritionixBaseService {
  FoodServiceNutritionix() : super();

  Future<Response> searchInstant({required String query}) async {
    return callNutritionixAPI(HttpRequestType.get, '/search/instant', queryParameters: {'query': query});
  }
}
