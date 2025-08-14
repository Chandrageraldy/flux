import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/assets/constants/constants.dart';

class NutrientProgressModel {
  final Nutrition nutrition;
  final int currentValue;
  final int targetValue;

  NutrientProgressModel({
    required this.nutrition,
    required this.currentValue,
    required this.targetValue,
  });

  int get attrId => nutrition.attrId;
  String get label => nutrition.label;
  String get unit => nutrition.unit;
}

List<NutrientProgressModel> getNutrientProgressList(
  List<LoggedFoodModel> loggedFoods,
  PlanModel? plan,
  List<Nutrition> wantedNutrients,
) {
  final totals = FunctionUtils.calculateTotalFullNutrients(loggedFoods);

  final Map<int, double?> targets = {
    Nutrition.calorie.attrId: plan?.calorieKcal ?? 0,
    Nutrition.protein.attrId: plan?.proteinG ?? 0,
    Nutrition.fat.attrId: plan?.fatG ?? 0,
    Nutrition.carbs.attrId: plan?.carbsG ?? 0,
    Nutrition.calcium.attrId: plan?.calciumMg ?? 0,
    Nutrition.iron.attrId: plan?.ironMg ?? 0,
    Nutrition.magnesium.attrId: plan?.magnesiumMg ?? 0,
    Nutrition.phosphorus.attrId: plan?.phosphorusMg ?? 0,
    Nutrition.potassium.attrId: plan?.potassiumMg ?? 0,
    Nutrition.sodium.attrId: plan?.sodiumMg ?? 0,
    Nutrition.zinc.attrId: plan?.zincMg ?? 0,
    Nutrition.copper.attrId: plan?.copperMg ?? 0,
    Nutrition.manganese.attrId: plan?.manganeseMg ?? 0,
    Nutrition.selenium.attrId: plan?.seleniumUg ?? 0,
    Nutrition.vitaminA.attrId: plan?.vitaminAIu ?? 0,
    Nutrition.vitaminE.attrId: plan?.vitaminEMg ?? 0,
    Nutrition.vitaminD.attrId: plan?.vitaminDIu ?? 0,
    Nutrition.vitaminC.attrId: plan?.vitaminCMg ?? 0,
    Nutrition.thiamin.attrId: plan?.thiaminMg ?? 0,
    Nutrition.riboflavin.attrId: plan?.riboflavinMg ?? 0,
    Nutrition.niacin.attrId: plan?.niacinMg ?? 0,
    Nutrition.vitaminB6.attrId: plan?.vitaminB6Mg ?? 0,
    Nutrition.vitaminB12.attrId: plan?.vitaminB12Ug ?? 0,
    Nutrition.choline.attrId: plan?.cholineMg ?? 0,
    Nutrition.vitaminK.attrId: plan?.vitaminKUg ?? 0,
    Nutrition.folate.attrId: plan?.folateUg ?? 0,
  };

  return wantedNutrients.map((nutrient) {
    final currentValue = (totals[nutrient.attrId] ?? 0).round();
    final targetValue = (targets[nutrient.attrId] ?? 0).round();

    return NutrientProgressModel(
      nutrition: nutrient,
      currentValue: currentValue,
      targetValue: targetValue,
    );
  }).toList();
}
