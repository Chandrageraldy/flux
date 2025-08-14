import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/food_details_model/food_details_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class FoodDetailsViewModel extends BaseViewModel {
  FoodRepository foodRepository = FoodRepository();

  FoodDetailsModel unmodifiedFoodDetails = FoodDetailsModel();
  FoodDetailsModel modifiedFoodDetails = FoodDetailsModel();

  AltMeasureModel? selectedAltMeasure;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  double servingQty = 1.0;

  Future<bool> saveOrUnsaveFood({required FoodResponseModel foodResponseModel, required bool isSaved}) async {
    final response = await foodRepository.saveOrUnsaveFood(foodResponseModel: foodResponseModel, isSaved: isSaved);
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }

  Future<bool> checkIfSaved({required FoodResponseModel foodResponseModel}) async {
    final response = await foodRepository.checkIfSaved(foodResponseModel: foodResponseModel);
    checkError(response);
    return response.data;
  }

  Future<void> getFoodDetails({required FoodResponseModel foodResponseModel}) async {
    _isLoading = true;
    final response = await foodRepository.getFoodDetails(foodResponseModel: foodResponseModel);
    checkError(response);
    // To refer to base reference of food details
    unmodifiedFoodDetails = response.data as FoodDetailsModel;
    // To modify and display food details
    modifiedFoodDetails = response.data as FoodDetailsModel;

    // Pick the altMeasure whose measure matches the topLevel servingUnit
    // If none match, use the first altMeasure as fallback
    selectedAltMeasure = unmodifiedFoodDetails.altMeasures!.firstWhere(
      (alt) => alt.measure?.trim().toLowerCase() == unmodifiedFoodDetails.servingUnit!.trim().toLowerCase(),
      orElse: () => unmodifiedFoodDetails.altMeasures!.first,
    );

    // Update nutrients data based on the selected alt measure
    updateNutrientsData();
    _isLoading = false;
    notifyListeners();
  }

  void selectAltMeasure({required AltMeasureModel selectedAltMeasure}) {
    this.selectedAltMeasure = selectedAltMeasure;
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

  Future<void> saveToRecent({required FoodResponseModel foodResponseModel}) async {
    final response = await foodRepository.saveToRecent(foodResponseModel: foodResponseModel);
    checkError(response);
  }

  Future<bool> logFood({required String mealType}) async {
    final response = await foodRepository.logFoodWithFoodSearch(foodDetails: modifiedFoodDetails, mealType: mealType);
    checkError(response);
    return response.status == ResponseStatus.COMPLETE;
  }
}
