import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';
import 'package:flux/app/views/weekly_calorie_progress_page/weekly_calorie_progress_page.dart';
import 'package:intl/intl.dart';

class WeeklyCalorieProgressViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();
  Map<String, String> dates = {}; // For Picker
  Map<String, String> activeDates = {}; // For Chart Points

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WeeklyCalorieProgressViewModel() {
    _init();
  }

  void _init() {
    dates = {
      WeeklyCalorieProgressDateSettings.startDate.key:
          DateFormat('MM/dd/yy').format(DateTime.now().subtract(const Duration(days: 6))),
      WeeklyCalorieProgressDateSettings.endDate.key: DateFormat('MM/dd/yy').format(DateTime.now()),
    };
    activeDates = dates;
    notifyListeners();
  }

  List<LoggedFoodModel> loggedFoodsBetweenDates = [];

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

  Future<void> onDateSelected(String key, String value, BuildContext context) async {
    final dateFormat = DateFormat('MM/dd/yy');

    dates = {...dates, key: value};
    notifyListeners();

    final startStr = dates[WeeklyCalorieProgressDateSettings.startDate.key];
    final endStr = dates[WeeklyCalorieProgressDateSettings.endDate.key];

    final startDate = dateFormat.parse(startStr!);
    final endDate = dateFormat.parse(endStr!);

    // condition 1: start > end
    if (startDate.isAfter(endDate)) {
      WidgetUtils.showSnackBar(context, S.current.startEndDateErrorMessage1);
      return;
    }

    // condition 2: range must be exactly 7 days
    final difference = endDate.difference(startDate).inDays;
    if (difference > 6) {
      WidgetUtils.showSnackBar(context, S.current.startEndDateErrorMessage2);
      return;
    }

    // ✅ only when valid → update activeDates + fetch
    activeDates = {...dates};
    await getLoggedFoodsBetweenDates(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
