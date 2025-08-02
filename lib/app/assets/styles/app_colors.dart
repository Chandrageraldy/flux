import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);

  static final greyPalette = GreyPalette.greys;
  static final bluePalette = BluePalette.blues;

  static const redColor = Colors.red;
  static const transparentColor = Colors.transparent;
}

// Palette
class GreyPalette {
  static Map<int, Color> greys = {
    50: Color(0xFFE5E8EF),
    100: Color(0xFFF3F3F6),
    200: Color(0xFFD9D9D9),
    300: Color(0xFFC7CCD7),
    400: Color(0XFF636365),
  };
}

class BluePalette {
  static Map<int, Color> blues = {
    50: Color(0xFFF0F8FF),
    100: Color(0xFFf5f7fc),
    200: Color(0xFF558eed), // 5863e8 2B65D6 558eed
    300: Color(0xFF272a3b),
  };
}

// Gradient
class GradientAppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFf0f2f9),
      Color(0xFFFFFFFF),
    ],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7BAAF7),
      Color(0xFF6D7BE4),
    ],
  );
}
