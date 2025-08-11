import 'package:camera/camera.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/models/meal_scan_result_model.dart/meal_scan_result_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class MealScanViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  MealScanResultModel mealScanResult = MealScanResultModel();

  IngredientModel currentSelectedModifiedIngredient = IngredientModel();
  IngredientModel currentSelectedUnmodifiedIngredient = IngredientModel();

  AltMeasureModel? selectedAltMeasure;

  Future<void> getFoodDetailsFromMealScan({required XFile imageFile}) async {
    _isLoading = true;
    final response = await foodRepository.getFoodDetailsFromMealScan(imageFile: imageFile);
    checkError(response);
    mealScanResult = response.data as MealScanResultModel;
    _isLoading = false;
    notifyListeners();
  }

  void setCurrentSelectedIngredient(IngredientModel ingredient) {
    // Keep original untouched
    currentSelectedUnmodifiedIngredient = ingredient.copyWith();

    // Create a working copy for user edits
    currentSelectedModifiedIngredient = ingredient.copyWith();

    if (ingredient.servingUnit != null && ingredient.altMeasures != null) {
      selectedAltMeasure = ingredient.altMeasures!.firstWhere(
        (alt) => alt.measure?.trim().toLowerCase() == ingredient.servingUnit!.trim().toLowerCase(),
        orElse: () => ingredient.altMeasures!.first,
      );
    } else {
      selectedAltMeasure = ingredient.altMeasures?.first;
    }

    notifyListeners();
  }

  void selectAltMeasureForCurrentSelectedIngredient({required AltMeasureModel selectedAltMeasure}) {
    this.selectedAltMeasure = selectedAltMeasure;
    notifyListeners();
  }

  void updateNutrientsDataForCurrentSelectedIngredient({double? servingQty}) {
    final baseWeight = currentSelectedUnmodifiedIngredient.servingWeight ?? 1;
    final altMeasureQty = selectedAltMeasure?.qty ?? 1;
    final totalWeightForQty = selectedAltMeasure?.servingWeight ?? 1;

    // Weight per unit of selectedAltMeasure
    final weightPerUnit = totalWeightForQty / altMeasureQty;

    // Use typed servingQty or fallback to selected qty
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

    currentSelectedModifiedIngredient = currentSelectedUnmodifiedIngredient.copyWith(
      // ✅ Update serving info so future calculations are correct
      servingQty: usedQty,
      servingUnit: selectedAltMeasure?.measure,
      servingWeight: newWeight,

      // ✅ Update nutrients according to the ratio
      calorie: roundDouble((currentSelectedUnmodifiedIngredient.calorie ?? 0) * ratio),
      fat: roundDouble((currentSelectedUnmodifiedIngredient.fat ?? 0) * ratio),
      carbs: roundDouble((currentSelectedUnmodifiedIngredient.carbs ?? 0) * ratio),
      protein: roundDouble((currentSelectedUnmodifiedIngredient.protein ?? 0) * ratio),

      fullNutrients: currentSelectedUnmodifiedIngredient.fullNutrients?.map((nutrient) {
        return nutrient.copyWith(value: roundDouble(nutrient.value! * ratio));
      }).toList(),
    );

    notifyListeners();
  }

  void updateIngredients(int index) {
    if (index < 0 || index >= mealScanResult.ingredients!.length) {
      return;
    }

    final updatedList = List<IngredientModel>.from(mealScanResult.ingredients!);
    updatedList[index] = currentSelectedModifiedIngredient.copyWith();
    mealScanResult = mealScanResult.copyWith(ingredients: updatedList);
    notifyListeners();
  }

  void clearCurrentSelectedIngredient() {
    currentSelectedModifiedIngredient = IngredientModel();
    currentSelectedUnmodifiedIngredient = IngredientModel();
    selectedAltMeasure = null;
    notifyListeners();
  }

  void deleteIngredient(int index) {
    if (index < 0 || index >= mealScanResult.ingredients!.length) {
      return;
    }

    final updatedList = List<IngredientModel>.from(mealScanResult.ingredients!);
    updatedList.removeAt(index);
    mealScanResult = mealScanResult.copyWith(ingredients: updatedList);
    notifyListeners();
  }
}
