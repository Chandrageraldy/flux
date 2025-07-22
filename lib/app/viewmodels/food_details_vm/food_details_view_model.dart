import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/repositories/food_repo/food_repo.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodDetailsViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  Future<bool> saveFood(FoodResponseModel foodSearchModel) async {
    final response = await foodRepository.saveFood(foodSearchModel);
    return response.status == ResponseStatus.COMPLETE;
  }
}
