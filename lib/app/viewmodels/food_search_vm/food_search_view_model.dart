import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/recent_food_model.dart/recent_food_model.dart';
import 'package:flux/app/models/saved_food_model.dart/saved_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repo.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodSearchViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  List<FoodResponseModel> foodSearchResults = [];
  List<SavedFoodModel> savedFoodResults = [];
  List<RecentFoodModel> recentFoodResults = [];

  bool isSearching = false;

  bool _isSavedFoodLoading = false;
  bool get isSavedFoodLoading => _isSavedFoodLoading;

  bool _isRecentFoodLoading = false;
  bool get isRecentFoodLoading => _isRecentFoodLoading;

  Future<void> searchInstant(String query) async {
    isSearching = true;
    final response = await foodRepository.searchInstant(query: query);
    checkError(response);
    foodSearchResults = response.data as List<FoodResponseModel>;
    notifyListeners();
  }

  Future<void> getSavedFoods() async {
    _isSavedFoodLoading = true;
    final response = await foodRepository.getSavedFoods();
    checkError(response);
    savedFoodResults = response.data as List<SavedFoodModel>;
    _isSavedFoodLoading = false;
    notifyListeners();
  }

  Future<void> getRecentFoods() async {
    isSearching = false;
    _isRecentFoodLoading = true;
    foodSearchResults = [];
    final response = await foodRepository.getRecentFoods();
    checkError(response);
    recentFoodResults = response.data as List<RecentFoodModel>;
    _isRecentFoodLoading = false;
    notifyListeners();
  }
}
