import 'package:firebase_ai/firebase_ai.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class Env {
  static const String file = '.env';
  static const String supabaseUrl = 'SUPABASE_URL';
  static const String supabaseAnonKey = 'SUPABASE_ANON_KEY';
  static const String nutritionixAppId = 'NUTRITIONIX_APP_ID';
  static const String nutritionixAppKey = 'NUTRITIONIX_APP_KEY';
}

class ImagePath {
  static const String fluxLogo = 'lib/app/assets/images/flux.png';
  static const String fluxPadding = 'lib/app/assets/images/flux-padding.png';
  static const String onboarding1 = 'lib/app/assets/images/onboarding1.png';
  static const String onboarding2 = 'lib/app/assets/images/onboarding2.png';
  static const String onboarding3 = 'lib/app/assets/images/onboarding3.png';
  static const String fluxStar = 'lib/app/assets/images/flux-star.png';
  static const String profilePlaceholder = 'lib/app/assets/images/profile-placeholder.png';
  static const String pizza = 'lib/app/assets/images/pizza-30.png';
  static const String fastFood = 'lib/app/assets/images/fast-food-19.png';
  static const String fluxLogo2 = 'lib/app/assets/images/flux_logo2.png';
  static const String foodSample = 'lib/app/assets/images/food_sample.jpg';
}

class AnimationPath {
  static const String starAIAnimation = 'lib/app/assets/animations/Star AI loader activated state.json';
}

class NutritionixEndpoint {
  static const String instantSearch = '/search/instant';
  static const String searchItem = '/search/item';
  static const String naturalLanuageSearch = '/natural/nutrients';
}

class NutritionixParam {
  static const String query = 'query';
  static const String nixItemId = 'nix_item_id';
  static const String upc = 'upc';
}

enum Language {
  english('en'),
  simplifiedChinese('zh');

  final String languageCode;
  const Language(this.languageCode);

  String get label {
    switch (this) {
      case english:
        return S.current.englishLabel;
      case simplifiedChinese:
        return S.current.simplifiedChineseLabel;
    }
  }
}

enum FormFields {
  email,
  password,
  username,
  search,
  servingUnit,
  mealType,
  quantity,
  dietType,
  proteinRatio,
  carbsRatio,
  fatRatio,
  breakfastRatio,
  lunchRatio,
  dinnerRatio,
  snackRatio,
}

class TableName {
  static String user = 'user';
  static String plan = 'plan';
  static String savedFood = 'saved_food';
  static String recentFood = 'recent_food';
}

class TableCol {
  static String userId = 'userId';
  static String id = 'id';
  static String tagId = 'tagId';
  static String nixItemId = 'nixItemId';
  static String lastViewedAt = 'lastViewedAt';
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack;

  String get label {
    switch (this) {
      case breakfast:
        return S.current.breakfastLabel;
      case lunch:
        return S.current.lunchLabel;
      case dinner:
        return S.current.dinnerLabel;
      case snack:
        return S.current.snackLabel;
    }
  }

  String get key {
    switch (this) {
      case breakfast:
        return 'breakfast';
      case lunch:
        return 'lunch';
      case dinner:
        return 'dinner';
      case snack:
        return 'snack';
    }
  }
}

enum MacroNutrients {
  carbs('carbs'),
  protein('protein'),
  fat('fat');

  final String key;
  const MacroNutrients(this.key);

  double get multiplier {
    switch (this) {
      case carbs:
        return 4.0;
      case protein:
        return 4.0;
      case fat:
        return 9.0;
    }
  }

  String get label {
    switch (this) {
      case carbs:
        return S.current.carbsLabel;
      case protein:
        return S.current.proteinLabel;
      case fat:
        return S.current.fatLabel;
    }
  }

  String get tag {
    switch (this) {
      case carbs:
        return 'C';
      case protein:
        return 'P';
      case fat:
        return 'F';
    }
  }

  Color get color {
    switch (this) {
      case carbs:
        return const Color(0xFF4ba0ae);
      case protein:
        return const Color(0xFFec6b72);
      case fat:
        return const Color(0xFF9179ee);
    }
  }
}

enum Nutrition {
  calorie,
  protein,
  fat,
  carbs,
  calcium,
  iron,
  magnesium,
  phosphorus,
  potassium,
  sodium,
  zinc,
  copper,
  manganese,
  selenium,
  vitaminA,
  vitaminE,
  vitaminD,
  vitaminC,
  thiamin,
  riboflavin,
  niacin,
  vitaminB6,
  vitaminB12,
  choline,
  vitaminK,
  folate;

  String get key {
    switch (this) {
      case calorie:
        return 'calorieKcal';
      case protein:
        return 'proteinG';
      case fat:
        return 'fatG';
      case carbs:
        return 'carbsG';
      case calcium:
        return 'calciumMg';
      case iron:
        return 'ironMg';
      case magnesium:
        return 'magnesiumMg';
      case phosphorus:
        return 'phosphorusMg';
      case potassium:
        return 'potassiumMg';
      case sodium:
        return 'sodiumMg';
      case zinc:
        return 'zincMg';
      case copper:
        return 'copperMg';
      case manganese:
        return 'manganeseMg';
      case selenium:
        return 'seleniumUg';
      case vitaminA:
        return 'vitaminAIu';
      case vitaminE:
        return 'vitaminEMg';
      case vitaminD:
        return 'vitaminDIu';
      case vitaminC:
        return 'vitaminCMg';
      case thiamin:
        return 'thiaminMg';
      case riboflavin:
        return 'riboflavinMg';
      case niacin:
        return 'niacinMg';
      case vitaminB6:
        return 'vitaminB6Mg';
      case vitaminB12:
        return 'vitaminB12Ug';
      case choline:
        return 'cholineMg';
      case vitaminK:
        return 'vitaminKUg';
      case folate:
        return 'folateUg';
    }
  }

  String get label {
    switch (this) {
      case calorie:
        return S.current.calorieLabel;
      case protein:
        return S.current.proteinLabel;
      case fat:
        return S.current.fatLabel;
      case carbs:
        return S.current.carbsLabel;
      case calcium:
        return S.current.calciumLabel;
      case iron:
        return S.current.ironLabel;
      case magnesium:
        return S.current.magnesiumLabel;
      case phosphorus:
        return S.current.phosphorusLabel;
      case potassium:
        return S.current.potassiumLabel;
      case sodium:
        return S.current.sodiumLabel;
      case zinc:
        return S.current.zincLabel;
      case copper:
        return S.current.copperLabel;
      case manganese:
        return S.current.manganeseLabel;
      case selenium:
        return S.current.seleniumLabel;
      case vitaminA:
        return S.current.vitaminALabel;
      case vitaminE:
        return S.current.vitaminELabel;
      case vitaminD:
        return S.current.vitaminDLabel;
      case vitaminC:
        return S.current.vitaminCLabel;
      case thiamin:
        return S.current.thiaminLabel;
      case riboflavin:
        return S.current.riboflavinLabel;
      case niacin:
        return S.current.niacinLabel;
      case vitaminB6:
        return S.current.vitaminB6Label;
      case vitaminB12:
        return S.current.vitaminB12Label;
      case choline:
        return S.current.cholineLabel;
      case vitaminK:
        return S.current.vitaminKLabel;
      case folate:
        return S.current.folateLabel;
    }
  }
}

enum Unit {
  kg,
  cm;

  String get label {
    switch (this) {
      case kg:
        return 'Kg';
      case cm:
        return 'cm';
    }
  }
}

enum NutritionUnit {
  kcal,
  g,
  mg,
  ug,
  IU;

  String get label {
    switch (this) {
      case kcal:
        return 'kcal';
      case g:
        return 'g';
      case mg:
        return 'mg';
      case ug:
        return 'µg';
      case IU:
        return 'IU';
    }
  }
}

enum ActivityLevel {
  sedentary(1.2),
  lightlyActive(1.375),
  active(1.55),
  veryActive(1.725);

  final double factor;
  const ActivityLevel(this.factor);
}

enum ExerciseLevel {
  never(0.0),
  light(0.1),
  moderate(0.15),
  frequent(0.2);

  final double factor;
  const ExerciseLevel(this.factor);
}

class GeminiJsonSchema {
  static Schema mealScan = Schema.object(
    properties: {
      'foodName': Schema.string(), // main meal name
      'healthScoreDescription': Schema.string(), // extra: description of the meal
      'healthScore': Schema.number(minimum: 1, maximum: 10), // extra: health score out of 10
      'quantity': Schema.number(description: 'must always be set to 1'), // added for meal scan quantity

      // ingredients list (each one uses full base food details model)
      'ingredients': Schema.array(
        items: Schema.object(
          properties: {
            'food_name': Schema.string(),
            'serving_qty': Schema.number(),
            'serving_unit': Schema.string(),
            'serving_weight_grams': Schema.number(),
            'nf_calories': Schema.number(),
            'nf_total_fat': Schema.number(),
            'nf_total_carbohydrate': Schema.number(),
            'nf_protein': Schema.number(),
            'full_nutrients': Schema.array(
              items: Schema.object(
                properties: {
                  'attr_id': Schema.number(),
                  'value': Schema.number(),
                },
              ),
            ),
            'alt_measures': Schema.array(
              items: Schema.object(
                properties: {
                  'serving_weight': Schema.number(),
                  'measure': Schema.string(),
                  'qty': Schema.number(),
                },
              ),
            ),
          },
        ),
      ),
    },
  );
}

class GeminiSystemInstruction {
  static const String mealScan = '''
  You are a nutrition analysis AI that receives a meal image and optional text description. Your task is to analyze the food and return a structured JSON strictly following the provided schema.

  Instructions:
  1.  **Identify the meal**:
      -   Accurately name the dish or food item in "foodName".
      -   If multiple foods are present, name the main meal and break down the components into "ingredients".
  
  2.  **Estimate portion size and volume**:
      -   For each item in the "ingredients" array, provide its individual primary serving size using **"serving_qty"**, **"serving_unit"**, and **"serving_weight_grams"**.
      -   Use real-world visual references (e.g., "the piece of chicken is about the size of a deck of cards" → ~85g).
      -   Consider the density of the food for accurate gram estimation (e.g., cooked rice is ~200g per cup).
      -   **New Rule for `serving_qty` for each ingredient**: When there are multiple individual items of the same food (e.g., three chicken wings, five strawberries), set **"serving_qty"** to the total count of those items. The **"serving_unit"** should then be the singular form of the item (e.g., "wing," "strawberry"). The **"serving_weight_grams"** should be the total weight of all items combined.

  3.  **Nutrition data**:
      -   For each item in the "ingredients" array, include its own **"full_nutrients"** array with all micronutrients, using the correct **"attr_id"** and value from the mapping table below.

  4.  **Alternative measures**:
      -   For each ingredient, provide exactly **3 alternative serving measures** in the **"alt_measures"** array.
      -   One of the `alt_measures` for each ingredient **must** correspond to the primary serving size defined by its **"serving_qty"**, **"serving_unit"**, and **"serving_weight_grams"**. Another measure must be a weight in grams, and the last measure must be different from the other measures.

  5.  **Health score**:
      -   Provide a **"health_score"** from **1-10**, where 10 is very healthy (nutrient-dense, low in added sugar/salt) and 1 is unhealthy.
      -   Also, provide a **"healthScoreDescription"** explaining the score.

  6.  **Ingredients**:
      -   Each item in the **"ingredients"** array must be a complete JSON object with its own name, primary serving size, macros, micronutrients, and `alt_measures`.

  7.  **Unit consistency**:
      -   Use the following units:
          -   kcal for calories
          -   g for protein, fat, carbs
          -   mg for calcium, iron, magnesium, phosphorus, potassium, sodium, zinc, copper, manganese, vitamin E, vitamin C, thiamin, riboflavin, niacin, vitamin B6, choline
          -   µg for selenium, vitamin B12, vitamin K, folate
          -   IU for vitamin A and vitamin D

  Nutrient Mapping (attr_id → label, unit):
  208: Calories (kcal)
  203: Protein (g)
  204: Total Fat (g)
  205: Total Carbohydrate (g)
  301: Calcium (mg)
  303: Iron (mg)
  304: Magnesium (mg)
  305: Phosphorus (mg)
  306: Potassium (mg)
  307: Sodium (mg)
  309: Zinc (mg)
  312: Copper (mg)
  315: Manganese (mg)
  317: Selenium (µg)
  318: Vitamin A (IU)
  323: Vitamin E (mg)
  324: Vitamin D (IU)
  401: Vitamin C (mg)
  404: Thiamin (mg)
  405: Riboflavin (mg)
  406: Niacin (mg)
  415: Vitamin B6 (mg)
  418: Vitamin B12 (µg)
  421: Choline (mg)
  430: Vitamin K (µg)
  417: Folate (µg)

  Return only valid JSON matching the provided schema. Do not include any extra commentary.
    ''';
}
