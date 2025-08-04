import 'package:flux/app/viewmodels/base_view_model.dart';

class NutritionGoalsViewModel extends BaseViewModel {
  NutritionGoalsViewModel() {
    _init();
  }

  void _init() {
    // Initialize any necessary data or state for the Nutrition Goals ViewModel
    // This could include fetching initial nutrition goals, setting default values, etc.
    notifyListeners();
  }
}
