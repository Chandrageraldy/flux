import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/repositories/food_repo/food_repo.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodSearchViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  List<FoodResponseModel> foodSearchResults = [];

  Future<void> searchInstant(String query) async {
    final response = await foodRepository.searchInstant(query: query);
    checkError(response);
    foodSearchResults = response.data as List<FoodResponseModel>;
    notifyListeners();
  }
}
