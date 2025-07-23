import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class NutritionMappingModel {
  final String label;
  final String unit;

  const NutritionMappingModel({required this.label, required this.unit});
}

Map<int, NutritionMappingModel> nutrientMapping = {
  208: NutritionMappingModel(label: S.current.calorieLabel, unit: NutritionUnit.kcal.label),
  203: NutritionMappingModel(label: S.current.proteinLabel, unit: NutritionUnit.g.label),
  204: NutritionMappingModel(label: S.current.fatLabel, unit: NutritionUnit.g.label),
  205: NutritionMappingModel(label: S.current.carbsLabel, unit: NutritionUnit.g.label),
  301: NutritionMappingModel(label: S.current.calciumLabel, unit: NutritionUnit.mg.label),
  303: NutritionMappingModel(label: S.current.ironLabel, unit: NutritionUnit.mg.label),
  304: NutritionMappingModel(label: S.current.magnesiumLabel, unit: NutritionUnit.mg.label),
  305: NutritionMappingModel(label: S.current.phosphorusLabel, unit: NutritionUnit.mg.label),
  306: NutritionMappingModel(label: S.current.potassiumLabel, unit: NutritionUnit.mg.label),
  307: NutritionMappingModel(label: S.current.sodiumLabel, unit: NutritionUnit.mg.label),
  309: NutritionMappingModel(label: S.current.zincLabel, unit: NutritionUnit.mg.label),
  312: NutritionMappingModel(label: S.current.copperLabel, unit: NutritionUnit.mg.label),
  315: NutritionMappingModel(label: S.current.manganeseLabel, unit: NutritionUnit.mg.label),
  317: NutritionMappingModel(label: S.current.seleniumLabel, unit: NutritionUnit.ug.label),
  318: NutritionMappingModel(label: S.current.vitaminALabel, unit: NutritionUnit.IU.label),
  323: NutritionMappingModel(label: S.current.vitaminELabel, unit: NutritionUnit.mg.label),
  324: NutritionMappingModel(label: S.current.vitaminDLabel, unit: NutritionUnit.IU.label),
  401: NutritionMappingModel(label: S.current.vitaminCLabel, unit: NutritionUnit.mg.label),
  404: NutritionMappingModel(label: S.current.thiaminLabel, unit: NutritionUnit.mg.label),
  405: NutritionMappingModel(label: S.current.riboflavinLabel, unit: NutritionUnit.mg.label),
  406: NutritionMappingModel(label: S.current.niacinLabel, unit: NutritionUnit.mg.label),
  415: NutritionMappingModel(label: S.current.vitaminB6Label, unit: NutritionUnit.mg.label),
  418: NutritionMappingModel(label: S.current.vitaminB12Label, unit: NutritionUnit.ug.label),
  421: NutritionMappingModel(label: S.current.cholineLabel, unit: NutritionUnit.mg.label),
  430: NutritionMappingModel(label: S.current.vitaminKLabel, unit: NutritionUnit.ug.label),
  417: NutritionMappingModel(label: S.current.folateLabel, unit: NutritionUnit.ug.label),
};
