import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ReportSummaryViewModel extends BaseViewModel {
  final FoodRepository foodRepository = FoodRepository();

  List<LoggedFoodModel> loggedFoodsBetweenDates = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getLoggedFoodsBetweenDates({required DateTime startDate, required DateTime endDate}) async {
    _isLoading = true;
    notifyListeners();

    final response = await foodRepository.getLoggedFoodsBetweenDates(
      startDate: startDate,
      endDate: endDate,
    );
    checkError(response);
    loggedFoodsBetweenDates = response.data as List<LoggedFoodModel>;
    _isLoading = false;
    notifyListeners();
  }
}
