import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppThemes {
  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Color(0xFFf7f6f6),
      surfaceBright: AppColors.bluePalette[50]!,
      primary: AppColors.bluePalette[300]!,
      onPrimary: AppColors.whiteColor,
      secondary: AppColors.bluePalette[200]!,
      onSecondary: AppColors.whiteColor,
      tertiary: AppColors.greyPalette[200]!,
      onTertiary: AppColors.blackColor,
      // Icon Container
      tertiaryContainer: AppColors.greyPalette[100]!,
      // Unselected Bar Item
      tertiaryFixed: AppColors.greyPalette[300]!,
      // Search Container
      tertiaryFixedDim: AppColors.greyPalette[50]!,
      // Grey Text
      onTertiaryContainer: AppColors.greyPalette[400]!,
    ),
    fontFamily: AltmannGrotesk.name,
  );

  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(surface: Colors.black, primary: Color(0xFF1570EF)),
    fontFamily: AltmannGrotesk.name,
  );
}
