import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodSearchLoggedFoodDetailsViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  LoggedFoodModel unmodifiedFoodDetails = LoggedFoodModel();
  LoggedFoodModel modifiedFoodDetails = LoggedFoodModel();

  AltMeasureModel? selectedAltMeasure;

  FoodSearchLoggedFoodDetailsViewModel({required LoggedFoodModel loggedFood}) {
    init(loggedFood: loggedFood);
  }

  void init({required LoggedFoodModel loggedFood}) {
    unmodifiedFoodDetails = loggedFood;
    modifiedFoodDetails = loggedFood;
    selectedAltMeasure = unmodifiedFoodDetails.altMeasures!.firstWhere(
      (alt) => alt.measure?.trim().toLowerCase() == unmodifiedFoodDetails.servingUnit!.trim().toLowerCase(),
      orElse: () => unmodifiedFoodDetails.altMeasures!.first,
    );

    notifyListeners();
  }

  void selectAltMeasure({required AltMeasureModel selectedAltMeasure}) {
    this.selectedAltMeasure = selectedAltMeasure;
    notifyListeners();
  }

  void updateMealType({required String mealType}) {
    modifiedFoodDetails = modifiedFoodDetails.copyWith(mealType: mealType);
    notifyListeners();
  }

  void updateNutrientsData({double? servingQty}) {
    final baseWeight = unmodifiedFoodDetails.servingWeightGrams ?? 1;

    final altMeasureQty = selectedAltMeasure?.qty ?? 1;
    final totalWeightForQty = selectedAltMeasure?.servingWeight ?? 1;

    // Calculate weight per 1 unit of selectedAltMeasure
    final weightPerUnit = totalWeightForQty / altMeasureQty;

    // Use the typed servingQty or fallback to selected qty
    final usedQty = servingQty ?? altMeasureQty;

    // Total new weight = usedQty * weightPerUnit
    final newWeight = usedQty * weightPerUnit;

    // Ratio of weight to base serving weight
    final ratio = newWeight / baseWeight;

    double roundDouble(double value) {
      final fixed = value.toStringAsFixed(2);
      if (fixed.endsWith('0')) {
        return double.parse(value.toStringAsFixed(1));
      }
      return double.parse(fixed);
    }

    modifiedFoodDetails = unmodifiedFoodDetails.copyWith(
      // Update serving info
      servingQty: usedQty,
      servingUnit: selectedAltMeasure?.measure,
      servingWeightGrams: newWeight,

      // Update nutrients according to the ratio
      calorieKcal: roundDouble((unmodifiedFoodDetails.calorieKcal ?? 0) * ratio),
      fatG: roundDouble((unmodifiedFoodDetails.fatG ?? 0) * ratio),
      carbsG: roundDouble((unmodifiedFoodDetails.carbsG ?? 0) * ratio),
      proteinG: roundDouble((unmodifiedFoodDetails.proteinG ?? 0) * ratio),
      fullNutrients: unmodifiedFoodDetails.fullNutrients?.map((nutrient) {
        return nutrient.copyWith(value: roundDouble(nutrient.value! * ratio));
      }).toList(),
    );

    notifyListeners();
  }

  Future<bool?> editLoggedFood() async {
    if (modifiedFoodDetails == unmodifiedFoodDetails) return null;

    final response = await foodRepository.editLoggedFood(
      loggedFood: modifiedFoodDetails,
    );
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }
}
