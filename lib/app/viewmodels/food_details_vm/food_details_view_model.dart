import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_details_model/food_details_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/repositories/food_repo/food_repo.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodDetailsViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  FoodDetailsModel foodDetails = FoodDetailsModel();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<bool> saveOrUnsaveFood({required FoodResponseModel foodResponseModel, required bool isSaved}) async {
    final response = await foodRepository.saveOrUnsaveFood(foodResponseModel: foodResponseModel, isSaved: isSaved);
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<bool> checkIfSaved({required FoodResponseModel foodResponseModel}) async {
    final response = await foodRepository.checkIfSaved(foodResponseModel: foodResponseModel);
    checkError(response);
    return response.data;
  }

  Future<void> getFoodDetails({required FoodResponseModel foodResponseModel}) async {
    _isLoading = true;
    final response = await foodRepository.getFoodDetails(foodResponseModel: foodResponseModel);
    checkError(response);
    foodDetails = response.data as FoodDetailsModel;
    _isLoading = false;
    notifyListeners();
  }
}
