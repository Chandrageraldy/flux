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
  static const String notFound = 'lib/app/assets/images/404.png';
  static const String aiStar = 'lib/app/assets/images/ai-star.png';
  static const String vpBackground = 'lib/app/assets/images/vp-background.png';
  static const String egg = 'lib/app/assets/images/egg.png';
  static const String energy = 'lib/app/assets/images/energy.png';
  static const String feed = 'lib/app/assets/images/feed.png';
  static const String play = 'lib/app/assets/images/play.png';
  static const String groom = 'lib/app/assets/images/groom.png';
  static const String diary = 'lib/app/assets/images/diary.png';
  static const String profile = 'lib/app/assets/images/profile.png';
}

class AnimationPath {
  static const String starAIAnimation = 'lib/app/assets/animations/Star AI loader activated state.json';
  static const String loadingDotsBlue = 'lib/app/assets/animations/Loading Dots Blue.json';
  static const String loadingAnimation = 'lib/app/assets/animations/Loading animation.json';
  static const String chick = 'lib/app/assets/animations/Chick.json';
  static const String walkingOrange = 'lib/app/assets/animations/Walking Orange.json';
}

class AnimationUrl {
  static const String crackedEgg =
      'https://boatxsvwhwnhmbmuiesv.supabase.co/storage/v1/object/public/virtual_pets/Cracked%20Egg.json';
  static const String confetti =
      'https://boatxsvwhwnhmbmuiesv.supabase.co/storage/v1/object/public/virtual_pets/Confetti.json';
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
  enhanceWithAi,
  prompt,
}

class TableName {
  static String user = 'user';
  static String plan = 'plan';
  static String savedFood = 'saved_food';
  static String recentFood = 'recent_food';
  static String loggedFood = 'logged_food';
  static String userPet = 'user_pet';
  static String userEnergy = 'user_energy';
  static String dailyGoals = 'daily_goals';
  static String virtualPets = 'virtual_pets';
}

class TableCol {
  static String userId = 'userId';
  static String id = 'id';
  static String tagId = 'tagId';
  static String nixItemId = 'nixItemId';
  static String lastViewedAt = 'lastViewedAt';
  static String loggedAt = 'loggedAt';
  static String mealType = 'mealType';
  static String bodyMetrics = 'bodyMetrics';
  static String username = 'username';
  static String email = 'email';
  static String photoUrl = 'photoUrl';
  static String dietType = 'dietType';
  static String goal = 'goal';
  static String isActive = 'isActive';
  static String currentExp = 'currentExp';
  static String energies = 'energies';
  static String createdAt = 'createdAt';
  static String currentValue = 'currentValue';
  static String isClaimed = 'isClaimed';
  static String petId = 'petId';
}

class BucketName {
  static String loggedFoodImageBucket = 'logged_food_image_bucket';
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

  String get value {
    switch (this) {
      case breakfast:
        return 'Breakfast';
      case lunch:
        return 'Lunch';
      case dinner:
        return 'Dinner';
      case snack:
        return 'Snack';
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

  int get attrId {
    switch (this) {
      case calorie:
        return 208;
      case protein:
        return 203;
      case fat:
        return 204;
      case carbs:
        return 205;
      case calcium:
        return 301;
      case iron:
        return 303;
      case magnesium:
        return 304;
      case phosphorus:
        return 305;
      case potassium:
        return 306;
      case sodium:
        return 307;
      case zinc:
        return 309;
      case copper:
        return 312;
      case manganese:
        return 315;
      case selenium:
        return 317;
      case vitaminA:
        return 318;
      case vitaminE:
        return 323;
      case vitaminD:
        return 324;
      case vitaminC:
        return 401;
      case thiamin:
        return 404;
      case riboflavin:
        return 405;
      case niacin:
        return 406;
      case vitaminB6:
        return 415;
      case vitaminB12:
        return 418;
      case choline:
        return 421;
      case vitaminK:
        return 430;
      case folate:
        return 417;
    }
  }

  String get unit {
    switch (this) {
      case calorie:
        return NutritionUnit.kcal.label;
      case protein:
      case fat:
      case carbs:
      case vitaminE:
      case vitaminC:
      case thiamin:
      case riboflavin:
      case niacin:
      case vitaminB6:
        return NutritionUnit.g.label;
      case calcium:
      case iron:
      case magnesium:
      case phosphorus:
      case potassium:
      case sodium:
      case zinc:
      case copper:
      case manganese:
      case choline:
        return NutritionUnit.mg.label;
      case selenium:
      case vitaminB12:
      case vitaminK:
      case folate:
        return NutritionUnit.ug.label;
      case vitaminA:
      case vitaminD:
        return NutritionUnit.IU.label;
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
      'healthScoreDesc': Schema.string(), // extra: description of the meal
      'healthScore': Schema.number(minimum: 1, maximum: 10), // extra: health score out of 10
      'quantity': Schema.number(description: 'must always be set to 1'), // added for meal scan quantity

      // ingredients list (each one uses full base food details model)
      'ingredients': Schema.array(
        items: Schema.object(
          properties: {
            'foodName': Schema.string(),
            'servingQty': Schema.number(
              description:
                  'When there are multiple individual items of the same food (e.g., three chicken wings, five strawberries), set **"servingQty"** to the total count of those items.',
            ),
            'servingUnit': Schema.string(
                description:
                    'The **"servingUnit"** must always be the **singular form** of the item (e.g., "cup," "wing," "strawberry").'),
            'servingWeight': Schema.number(),
            'calorie': Schema.number(),
            'fat': Schema.number(),
            'carbs': Schema.number(),
            'protein': Schema.number(),
            'fullNutrients': Schema.array(
              items: Schema.object(properties: {
                'attr_id': Schema.number(),
                'value': Schema.number(),
              }, description: '''
                  Nutrient Mapping (attr_id: label (unit)):
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
                '''),
            ),
            'altMeasures': Schema.array(
              items: Schema.object(
                properties: {
                  'serving_weight': Schema.number(),
                  'measure': Schema.string(
                    description:
                        'The **"measure"** must always be the **singular form** of the item (e.g., "cup," "wing," "strawberry").',
                  ),
                  'qty': Schema.number(
                    description:
                        'When there are multiple individual items of the same food (e.g., three chicken wings, five strawberries), set **"qty"** to the total count of those items.',
                  ),
                },
                description: '''
                - Provide exactly **2 alternative serving measures** in the **"altMeasures"** array.
                - One of the `altMeasures` for each ingredient **must** correspond to the primary serving size defined by its **"servingQty"**, **"servingUnit"**, and **"servingWeight"**. Another measure must be a weight in grams.
                ''',
              ),
            ),
          },
        ),
      ),
    },
  );
}

class GeminiSystemInstruction {
  static const String mealScan =
      'Analyze the provided image for any food items. First, determine if the image is a photograph of a screen (e.g., a monitor, television, or phone display). If so, return a JSON object where the "foodName" is "Image taken from a screen". If no food is detected otherwise, return a JSON object where the "foodName" is "No food detected". If food is detected, generate a JSON object based on the given schema, detailing the meal and its ingredients.';
  static String enhanceWithAI({required String userInstruction}) {
    return 'The provided prompt includes an existing JSON object that describes a meal and its ingredients. '
        'Your task is to enhance this JSON according to the user\'s instructions, while strictly maintaining JSON format. '
        'Enhancements may involve adding ingredients, adjusting quantities, updating nutritional information, or making other relevant modifications based on the prompt. '
        'If the user\'s instructions are unclear, return a JSON object where the "foodName" is "Instructions unclear". '
        'Return only the final updated JSON object without additional text or explanations. '
        'The instructions are: $userInstruction';
  }

  static String chatBot({required String userInformation}) {
    return 'You are a helpful and professional AI assistant named "NutriBot," specialized in providing information about nutrition, food science, and general health-related topics. Your purpose is to educate users on the nutritional content of foods and healthy eating habits.\n\n'
        '**Crucial Directive:** You are not a medical professional. You must always preface responses about specific health conditions or personalized dietary plans with the following disclaimer: "Please consult a healthcare professional or registered dietitian for personalized medical or nutritional advice."\n\n'
        '**Knowledge & Response Guidelines:**\n'
        '* Draw information exclusively from scientifically backed and verified sources.\n'
        '* When a user provides a food or meal, give a detailed breakdown of its calories, macronutrients (protein, carbohydrates, fats), and notable micronutrients.\n'
        '* When discussing healthy eating, provide general, balanced advice. For example, "A balanced diet includes a variety of fruits, vegetables, lean proteins, and whole grains."\n'
        '* The tone should be encouraging, clear, and easy to understand. Avoid overly technical or academic jargon.\n'
        '* Use lists and headings to make complex information digestible.\n\n'
        '**Limitations & Safety:**\n'
        '* Never provide a diagnosis or recommend specific treatments for medical conditions.\n'
        '* Do not speculate or provide information you are not 100% certain about. If a user asks about an unknown food or topic, state that you do not have information on it.\n'
        '* Politely decline to answer questions unrelated to nutrition and health.\n'
        '* If a user mentions a food allergy, immediately provide a strong warning and advise them to consult a professional.'
        '* User Information: $userInformation';
  }
}

enum LogSource {
  foodSearch,
  mealScan;

  String get value {
    switch (this) {
      case foodSearch:
        return 'Food Search';
      case mealScan:
        return 'Meal Scan';
    }
  }
}
