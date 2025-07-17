import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);

  static final greyPalette = GreyPalette.greys;
  static final bluePalette = BluePalette.blues;
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
    200: Color(0xFF2B65D6), // 5863e8 2B65D6
    300: Color(0xFF272a3b),
  };
}

// Gradient
class GradientAppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFF9FBFD),
      Color(0xFFF4F7FC),
      Color(0xFFEAF2FB),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
