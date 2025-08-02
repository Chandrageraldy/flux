import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/repositories/food_repo/food_repo.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class BarcodeScanViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  FoodResponseModel scannedFood = FoodResponseModel();

  Future<bool> getFoodDetailsWithUPC({required String upc}) async {
    final response = await foodRepository.getFoodDetailsWithUPC(upc: upc);
    checkError(response);
    scannedFood = (response.data as FoodResponseModel?)!;
    notifyListeners();
    return response.data is FoodResponseModel;
  }
}
