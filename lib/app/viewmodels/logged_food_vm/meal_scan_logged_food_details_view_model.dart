import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/services/gemini_base_service.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class MealScanLoggedFoodDetailsViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LoggedFoodModel modifiedMealScanResult = LoggedFoodModel();
  LoggedFoodModel unmodifiedMealScanResult = LoggedFoodModel();

  AltMeasureModel? selectedAltMeasure;

  IngredientModel currentSelectedModifiedIngredient = IngredientModel();
  IngredientModel currentSelectedUnmodifiedIngredient = IngredientModel();

  MealScanLoggedFoodDetailsViewModel({required LoggedFoodModel loggedFood}) {
    init(loggedFood: loggedFood);
  }

  void init({required LoggedFoodModel loggedFood}) {
    modifiedMealScanResult = loggedFood;
    unmodifiedMealScanResult = loggedFood;
  }

  void incrementMealQuantity() {
    final currentQty = modifiedMealScanResult.quantity ?? 0;
    final newQty = currentQty + 0.5;

    updateMealQuantitiesAndNutrients(newQty);
  }

  void decrementMealQuantity() {
    final currentQty = modifiedMealScanResult.quantity ?? 0.5;
    final newQty = (currentQty - 0.5).clamp(0.5, double.infinity).toDouble();

    updateMealQuantitiesAndNutrients(newQty);
  }

  void updateMealQuantitiesAndNutrients(double newQty) {
    final oldQty = modifiedMealScanResult.quantity ?? 1;

    final ratio = newQty / oldQty;

    final updatedIngredients = List<IngredientModel>.from(modifiedMealScanResult.ingredients!);

    double roundDouble(double value) {
      final fixed = value.toStringAsFixed(2);
      if (fixed.endsWith('0')) {
        return double.parse(value.toStringAsFixed(1));
      }
      return double.parse(fixed);
    }

    // Iterate through each ingredient and update its nutrients
    for (int i = 0; i < updatedIngredients.length; i++) {
      final ingredient = updatedIngredients[i];

      final updatedFullNutrients = ingredient.fullNutrients?.map((nutrient) {
        return nutrient.copyWith(value: roundDouble(nutrient.value! * ratio));
      }).toList();

      updatedIngredients[i] = ingredient.copyWith(
        calorie: roundDouble((ingredient.calorie ?? 0) * ratio),
        fat: roundDouble((ingredient.fat ?? 0) * ratio),
        carbs: roundDouble((ingredient.carbs ?? 0) * ratio),
        protein: roundDouble((ingredient.protein ?? 0) * ratio),
        fullNutrients: updatedFullNutrients,
      );
    }

    modifiedMealScanResult = modifiedMealScanResult.copyWith(
      quantity: newQty,
      ingredients: updatedIngredients,
    );

    notifyListeners();
  }

  void setCurrentSelectedIngredient(IngredientModel ingredient) {
    // Keep original untouched
    currentSelectedUnmodifiedIngredient = ingredient.copyWith();

    // Create a working copy for user edits
    currentSelectedModifiedIngredient = ingredient.copyWith();

    // Pick the altMeasure whose measure matches the ingredient's servingUnit
    // If none match, use the first altMeasure as fallback
    selectedAltMeasure = ingredient.altMeasures!.firstWhere(
      (alt) => alt.measure?.trim().toLowerCase() == ingredient.servingUnit!.trim().toLowerCase(),
      orElse: () => ingredient.altMeasures!.first,
    );

    notifyListeners();
  }

  // Keep the current selected ingredient fresh after disposing
  void clearCurrentSelectedIngredient() {
    currentSelectedModifiedIngredient = IngredientModel();
    currentSelectedUnmodifiedIngredient = IngredientModel();
    selectedAltMeasure = null;
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
      // Update serving info so future calculations are correct
      servingQty: usedQty,
      servingUnit: selectedAltMeasure?.measure,
      servingWeight: newWeight,

      // Update nutrients according to the ratio
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

  void deleteIngredient(int index) {
    // Clone list
    final updatedList = List<IngredientModel>.from(modifiedMealScanResult.ingredients!);
    // Remove the ingredient based on index in the cloned list
    updatedList.removeAt(index);
    // Update meal scan result with the updated list
    modifiedMealScanResult = modifiedMealScanResult.copyWith(ingredients: updatedList);
    notifyListeners();
  }

  void updateIngredients(int index) {
    // Clone list
    final updatedList = List<IngredientModel>.from(modifiedMealScanResult.ingredients!);
    // Replace the ingredient based on index in the cloned list
    updatedList[index] = currentSelectedModifiedIngredient.copyWith();
    // Update meal scan result with the updated list
    modifiedMealScanResult = modifiedMealScanResult.copyWith(ingredients: updatedList);
    notifyListeners();
  }

  void updateMealType({required String mealType}) {
    modifiedMealScanResult = modifiedMealScanResult.copyWith(mealType: mealType);
    notifyListeners();
  }

  Future<bool?> editLoggedFood({required Map<String, double> nutritionTotals}) async {
    if (unmodifiedMealScanResult == modifiedMealScanResult) return null;

    final response = await foodRepository.editLoggedFood(
      loggedFood: modifiedMealScanResult,
      nutritionTotals: nutritionTotals,
    );
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<bool> deleteLoggedFood() async {
    final response = await foodRepository.deleteLoggedFood(
      loggedFood: unmodifiedMealScanResult,
    );
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<GeminiMealScanStatus> enhanceWithAI({required String userInstruction}) async {
    _isLoading = true;
    notifyListeners();
    final response = await foodRepository.enhanceWithAIForLoggedFood(
      userInstruction: userInstruction,
      loggedFood: modifiedMealScanResult,
    );

    if (response.status == ResponseStatus.COMPLETE) {
      modifiedMealScanResult = response.data as LoggedFoodModel;
    } else if (response.status == ResponseStatus.ERROR) {
      if (response.error == GeminiMealScanStatus.INSTRUCTIONSUNCLEAR.type) {
        _isLoading = false;
        notifyListeners();
        return GeminiMealScanStatus.INSTRUCTIONSUNCLEAR;
      } else {
        checkError(response);
      }
    }
    _isLoading = false;
    notifyListeners();
    return GeminiMealScanStatus.COMPLETE;
  }
}
