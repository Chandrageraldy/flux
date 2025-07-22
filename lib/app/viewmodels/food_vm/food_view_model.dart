import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  List<FoodSearchResultModel> foodSearchResults = [];

  Future<void> searchInstant(String query) async {
    final response = await foodRepository.searchInstant(query: query);
    checkError(response);
    foodSearchResults = response.data as List<FoodSearchResultModel>;
    notifyListeners();
  }
}
