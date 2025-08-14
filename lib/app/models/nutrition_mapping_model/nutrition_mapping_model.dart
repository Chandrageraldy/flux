import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class NutritionMappingModel {
  final String label;
  final String unit;

  const NutritionMappingModel({required this.label, required this.unit});
}

Map<int, NutritionMappingModel> nutrientsMapping = {
  Nutrition.calorie.attrId: NutritionMappingModel(label: Nutrition.calorie.label, unit: NutritionUnit.kcal.label),
  Nutrition.protein.attrId: NutritionMappingModel(label: Nutrition.protein.label, unit: NutritionUnit.g.label),
  Nutrition.fat.attrId: NutritionMappingModel(label: Nutrition.fat.label, unit: NutritionUnit.g.label),
  Nutrition.carbs.attrId: NutritionMappingModel(label: Nutrition.carbs.label, unit: NutritionUnit.g.label),
  Nutrition.calcium.attrId: NutritionMappingModel(label: Nutrition.calcium.label, unit: NutritionUnit.mg.label),
  Nutrition.iron.attrId: NutritionMappingModel(label: Nutrition.iron.label, unit: NutritionUnit.mg.label),
  Nutrition.magnesium.attrId: NutritionMappingModel(label: Nutrition.magnesium.label, unit: NutritionUnit.mg.label),
  Nutrition.phosphorus.attrId: NutritionMappingModel(label: Nutrition.phosphorus.label, unit: NutritionUnit.mg.label),
  Nutrition.potassium.attrId: NutritionMappingModel(label: Nutrition.potassium.label, unit: NutritionUnit.mg.label),
  Nutrition.sodium.attrId: NutritionMappingModel(label: Nutrition.sodium.label, unit: NutritionUnit.mg.label),
  Nutrition.zinc.attrId: NutritionMappingModel(label: Nutrition.zinc.label, unit: NutritionUnit.mg.label),
  Nutrition.copper.attrId: NutritionMappingModel(label: Nutrition.copper.label, unit: NutritionUnit.mg.label),
  Nutrition.manganese.attrId: NutritionMappingModel(label: Nutrition.manganese.label, unit: NutritionUnit.mg.label),
  Nutrition.selenium.attrId: NutritionMappingModel(label: Nutrition.selenium.label, unit: NutritionUnit.ug.label),
  Nutrition.vitaminA.attrId: NutritionMappingModel(label: Nutrition.vitaminA.label, unit: NutritionUnit.IU.label),
  Nutrition.vitaminE.attrId: NutritionMappingModel(label: Nutrition.vitaminE.label, unit: NutritionUnit.mg.label),
  Nutrition.vitaminD.attrId: NutritionMappingModel(label: Nutrition.vitaminD.label, unit: NutritionUnit.IU.label),
  Nutrition.vitaminC.attrId: NutritionMappingModel(label: Nutrition.vitaminC.label, unit: NutritionUnit.mg.label),
  Nutrition.thiamin.attrId: NutritionMappingModel(label: Nutrition.thiamin.label, unit: NutritionUnit.mg.label),
  Nutrition.riboflavin.attrId: NutritionMappingModel(label: Nutrition.riboflavin.label, unit: NutritionUnit.mg.label),
  Nutrition.niacin.attrId: NutritionMappingModel(label: Nutrition.niacin.label, unit: NutritionUnit.mg.label),
  Nutrition.vitaminB6.attrId: NutritionMappingModel(label: Nutrition.vitaminB6.label, unit: NutritionUnit.mg.label),
  Nutrition.vitaminB12.attrId: NutritionMappingModel(label: Nutrition.vitaminB12.label, unit: NutritionUnit.ug.label),
  Nutrition.choline.attrId: NutritionMappingModel(label: Nutrition.choline.label, unit: NutritionUnit.mg.label),
  Nutrition.vitaminK.attrId: NutritionMappingModel(label: Nutrition.vitaminK.label, unit: NutritionUnit.ug.label),
  Nutrition.folate.attrId: NutritionMappingModel(label: Nutrition.folate.label, unit: NutritionUnit.ug.label),
};
