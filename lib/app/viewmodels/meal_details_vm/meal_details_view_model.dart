import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class MealDetailsViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();
  List<LoggedFoodModel> loggedFoodsList = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getLoggedFoodsByMeals({required DateTime selectedDate, required String mealType}) async {
    _isLoading = true;
    final response = await foodRepository.getLoggedFoodsByMeals(
      selectedDate: selectedDate,
      mealType: mealType,
    );
    checkError(response);
    loggedFoodsList = response.data as List<LoggedFoodModel>;
    _isLoading = false;
    notifyListeners();
  }
}
