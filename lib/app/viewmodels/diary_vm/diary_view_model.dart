// import 'dart:developer';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class DiaryViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  List<LoggedFoodModel> loggedFoodsList = [];

  Future<void> getLoggedFoods({required DateTime selectedDate}) async {
    final response = await foodRepository.getLoggedFoods(selectedDate: selectedDate);
    checkError(response);
    loggedFoodsList = response.data as List<LoggedFoodModel>;
    notifyListeners();
  }
}
