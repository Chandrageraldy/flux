import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class ImageConstant {
  static const String fluxLogo = 'lib/app/assets/images/flux.png';
  static const String onboarding1 = 'lib/app/assets/images/onboarding1.png';
  static const String onboarding2 = 'lib/app/assets/images/onboarding2.png';
  static const String onboarding3 = 'lib/app/assets/images/onboarding3.png';
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

class DateFormatConstant {}

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
