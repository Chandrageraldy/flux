import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/saved_food_model.dart/saved_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repo.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodSearchViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  List<FoodResponseModel> foodSearchResults = [];
  List<SavedFoodModel> savedFoodResults = [];

  Future<void> searchInstant(String query) async {
    final response = await foodRepository.searchInstant(query: query);
    checkError(response);
    foodSearchResults = response.data as List<FoodResponseModel>;
    notifyListeners();
  }

  Future<void> getSavedFoods() async {
    final response = await foodRepository.getSavedFoods();
    checkError(response);
    savedFoodResults = response.data as List<SavedFoodModel>;
    notifyListeners();
  }
}
