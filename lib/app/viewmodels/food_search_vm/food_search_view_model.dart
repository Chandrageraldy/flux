import 'package:flux/app/models/food_search_model/food_search_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodSearchViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  List<FoodSearchModel> foodSearchResults = [];

  Future<void> searchInstant(String query) async {
    final response = await foodRepository.searchInstant(query: query);
    checkError(response);
    foodSearchResults = response.data as List<FoodSearchModel>;
    notifyListeners();
  }
}
