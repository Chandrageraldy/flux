class FoodModel {
  // — Core fields you want to keep accessible directly
  final String foodName;
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double servingQuantity;
  final List<String> servingUnit;
  final String? brand;

  // — NEW: all nutrition facts (micro + macro + calories)
  final List<Nutrient> nutrients;

  const FoodModel({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.servingQuantity,
    required this.servingUnit,
    required this.nutrients,
    this.brand,
  });
}

// -----------------------------------------------------------------------------
//  Seed data (6 foods)
// -----------------------------------------------------------------------------
final List<FoodModel> foodList = [
  FoodModel(
    foodName: 'Grilled Chicken Breast',
    calories: 165,
    protein: 31.0,
    fat: 3.6,
    carbohydrate: 0.0,
    servingQuantity: 1,
    servingUnit: ['piece', 'gram'],
    brand: 'HealthyFarm',
    nutrients: [
      Nutrient(name: 'Calories', amount: 165, unit: 'kcal'),
      Nutrient(name: 'Protein', amount: 31.0, unit: 'g'),
      Nutrient(name: 'Fat', amount: 3.6, unit: 'g'),
      Nutrient(name: 'Carbohydrate', amount: 0.0, unit: 'g'),
      Nutrient(name: 'Vitamin A', amount: 13.0, unit: 'µg'),
      Nutrient(name: 'Vitamin C', amount: 0.0, unit: 'mg'),
      Nutrient(name: 'Iron', amount: 1.0, unit: 'mg'),
      Nutrient(name: 'Calcium', amount: 11.0, unit: 'mg'),
      Nutrient(name: 'Potassium', amount: 256.0, unit: 'mg'),
    ],
  ),
  FoodModel(
    foodName: 'Boiled Broccoli',
    calories: 55,
    protein: 3.7,
    fat: 0.6,
    carbohydrate: 11.2,
    servingQuantity: 1,
    servingUnit: ['cup', 'gram'],
    nutrients: [
      Nutrient(name: 'Calories', amount: 55, unit: 'kcal'),
      Nutrient(name: 'Protein', amount: 3.7, unit: 'g'),
      Nutrient(name: 'Fat', amount: 0.6, unit: 'g'),
      Nutrient(name: 'Carbohydrate', amount: 11.2, unit: 'g'),
      Nutrient(name: 'Vitamin A', amount: 567.0, unit: 'µg'),
      Nutrient(name: 'Vitamin C', amount: 101.2, unit: 'mg'),
      Nutrient(name: 'Iron', amount: 1.0, unit: 'mg'),
      Nutrient(name: 'Calcium', amount: 62.0, unit: 'mg'),
      Nutrient(name: 'Potassium', amount: 457.0, unit: 'mg'),
    ],
  ),
  FoodModel(
    foodName: 'White Rice',
    calories: 204,
    protein: 4.2,
    fat: 0.4,
    carbohydrate: 44.5,
    servingQuantity: 1,
    servingUnit: ['cup', 'tablespoon'],
    brand: 'SunRice',
    nutrients: [
      Nutrient(name: 'Calories', amount: 204, unit: 'kcal'),
      Nutrient(name: 'Protein', amount: 4.2, unit: 'g'),
      Nutrient(name: 'Fat', amount: 0.4, unit: 'g'),
      Nutrient(name: 'Carbohydrate', amount: 44.5, unit: 'g'),
      Nutrient(name: 'Vitamin A', amount: 0.0, unit: 'µg'),
      Nutrient(name: 'Vitamin C', amount: 0.0, unit: 'mg'),
      Nutrient(name: 'Iron', amount: 1.9, unit: 'mg'),
      Nutrient(name: 'Calcium', amount: 16.0, unit: 'mg'),
      Nutrient(name: 'Potassium', amount: 55.0, unit: 'mg'),
    ],
  ),
  FoodModel(
    foodName: 'Scrambled Eggs',
    calories: 91,
    protein: 6.7,
    fat: 6.7,
    carbohydrate: 1.0,
    servingQuantity: 1,
    servingUnit: ['egg'],
    nutrients: [
      Nutrient(name: 'Calories', amount: 91, unit: 'kcal'),
      Nutrient(name: 'Protein', amount: 6.7, unit: 'g'),
      Nutrient(name: 'Fat', amount: 6.7, unit: 'g'),
      Nutrient(name: 'Carbohydrate', amount: 1.0, unit: 'g'),
      Nutrient(name: 'Vitamin A', amount: 270.0, unit: 'µg'),
      Nutrient(name: 'Vitamin C', amount: 0.0, unit: 'mg'),
      Nutrient(name: 'Iron', amount: 0.9, unit: 'mg'),
      Nutrient(name: 'Calcium', amount: 56.0, unit: 'mg'),
      Nutrient(name: 'Potassium', amount: 66.0, unit: 'mg'),
    ],
  ),
  FoodModel(
    foodName: 'Apple',
    calories: 95,
    protein: 0.5,
    fat: 0.3,
    carbohydrate: 25.1,
    servingQuantity: 1,
    servingUnit: ['medium apple', 'slice'],
    brand: 'Pink Lady',
    nutrients: [
      Nutrient(name: 'Calories', amount: 95, unit: 'kcal'),
      Nutrient(name: 'Protein', amount: 0.5, unit: 'g'),
      Nutrient(name: 'Fat', amount: 0.3, unit: 'g'),
      Nutrient(name: 'Carbohydrate', amount: 25.1, unit: 'g'),
      Nutrient(name: 'Vitamin A', amount: 98.0, unit: 'µg'),
      Nutrient(name: 'Vitamin C', amount: 8.4, unit: 'mg'),
      Nutrient(name: 'Iron', amount: 0.2, unit: 'mg'),
      Nutrient(name: 'Calcium', amount: 11.0, unit: 'mg'),
      Nutrient(name: 'Potassium', amount: 195.0, unit: 'mg'),
    ],
  ),
  FoodModel(
    foodName: 'Salmon (Cooked)',
    calories: 206,
    protein: 22.1,
    fat: 12.4,
    carbohydrate: 0.0,
    servingQuantity: 1,
    servingUnit: ['fillet', 'gram'],
    nutrients: [
      Nutrient(name: 'Calories', amount: 206, unit: 'kcal'),
      Nutrient(name: 'Protein', amount: 22.1, unit: 'g'),
      Nutrient(name: 'Fat', amount: 12.4, unit: 'g'),
      Nutrient(name: 'Carbohydrate', amount: 0.0, unit: 'g'),
      Nutrient(name: 'Vitamin A', amount: 50.0, unit: 'µg'),
      Nutrient(name: 'Vitamin C', amount: 0.0, unit: 'mg'),
      Nutrient(name: 'Iron', amount: 0.7, unit: 'mg'),
      Nutrient(name: 'Calcium', amount: 12.0, unit: 'mg'),
      Nutrient(name: 'Potassium', amount: 555.0, unit: 'mg'),
    ],
  ),
];

class Nutrient {
  final String name; // e.g. "Protein"
  final double amount; // numeric amount
  final String unit; // e.g. "g", "kcal", "mg", "IU"

  const Nutrient({
    required this.name,
    required this.amount,
    required this.unit,
  });
}
