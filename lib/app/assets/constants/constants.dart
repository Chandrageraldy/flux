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
  static const String onboarding1 = 'lib/app/assets/images/onboarding1.png';
  static const String onboarding2 = 'lib/app/assets/images/onboarding2.png';
  static const String onboarding3 = 'lib/app/assets/images/onboarding3.png';
  static const String fluxStar = 'lib/app/assets/images/flux_star.png';
}

class AnimationPath {
  static const String loadingAnimation = 'lib/app/assets/animations/loading.json';
  static const String orangeAnimation = 'lib/app/assets/animations/Walking Orange.json';
  static const String loadingSpinnerAnimation = 'lib/app/assets/animations/Loading Spinner.json';
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

enum FormFields { email, password, username, search, servingUnit, mealType }

class TableName {
  static String user = 'user';
  static String plan = 'plan';
  static String savedFood = 'saved_food';
}

class TableCol {
  static String userId = 'userId';
  static String id = 'id';
  static String tagId = 'tagId';
  static String nixItemId = 'nixItemId';
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
