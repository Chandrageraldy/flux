import 'package:camera/camera.dart';
import 'package:flux/app/models/meal_scan_result_model.dart/meal_scan_result_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class MealScanViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  MealScanResultModel mealScanResult = MealScanResultModel();

  Future<void> getFoodDetailsFromMealScan({required XFile imageFile}) async {
    _isLoading = true;
    final response = await foodRepository.getFoodDetailsFromMealScan(imageFile: imageFile);
    checkError(response);
    mealScanResult = response.data as MealScanResultModel;
    _isLoading = false;
    notifyListeners();
    print(mealScanResult);
  }
}
