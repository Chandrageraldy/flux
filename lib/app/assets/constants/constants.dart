import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class Env {
  static const String file = '.env';
  static const String supabaseUrl = 'SUPABASE_URL';
  static const String supabaseAnonKey = 'SUPABASE_ANON_KEY';
}

class ImagePath {
  static const String fluxLogo = 'lib/app/assets/images/flux.png';
  static const String onboarding1 = 'lib/app/assets/images/onboarding1.png';
  static const String onboarding2 = 'lib/app/assets/images/onboarding2.png';
  static const String onboarding3 = 'lib/app/assets/images/onboarding3.png';
}

class AnimationPath {
  static const String loadingAnimation = 'lib/app/assets/animations/loading.json';
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
}

class TableCol {
  static String userId = 'userId';
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
}
