import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/widgets/dialog/adaptive_alert_dialog.dart';

import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/dialog/custom_date_picker_dialog.dart';
import 'package:flux/app/widgets/dialog/custom_field_dialog.dart';
import 'package:flux/app/widgets/dialog/custom_picker_dialog.dart';

class WidgetUtils {
  static Future<void> showDefaultErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async {
    final List<Widget> actionBuilders = [
      TextButton(
        onPressed: () => context.router.maybePop(),
        child: Text(S.current.okLabel.capitalize()),
      ),
    ];
    if (context.mounted) {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (context) => AdaptiveAlertDialog(errorMessage: errorMessage, actionBuilders: actionBuilders),
        useRootNavigator: false,
      );
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: context.theme.colorScheme.onPrimary, size: AppStyles.kSize16),
            SizedBox(width: AppStyles.kSpac8),
            Expanded(
              child: Text(
                message,
                style: Quicksand.medium.withSize(FontSizes.extraSmall),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () => messenger.hideCurrentSnackBar(),
              child: Text(
                S.current.dismissLabel,
                style: Quicksand.medium
                    .withSize(FontSizes.extraSmall)
                    .copyWith(color: context.theme.colorScheme.secondary),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff262727),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
        padding: AppStyles.kPadd12,
        elevation: 4,
      ),
    );
  }

  static void showFieldDialog({
    required BuildContext context,
    required String label,
    required FormFields formField,
    String? desc,
    String initialValue = '',
    String? buttonLabel,
    IconData? icon,
    required VoidCallback onPressed,
    required GlobalKey<FormBuilderState> formKey,
    double? textFieldHeight,
    int maxLines = 1,
    int? minLines,
    EdgeInsets? textFieldPadding,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomFieldDialog(
          context: context,
          label: label,
          desc: desc,
          formField: formField,
          initialValue: initialValue,
          buttonLabel: buttonLabel ?? S.current.confirmLabel,
          icon: icon,
          onPressed: onPressed,
          formKey: formKey,
          textFieldHeight: textFieldHeight,
          maxLines: maxLines,
          minLines: minLines,
          textFieldPadding: textFieldPadding,
        );
      },
    );
  }

  static void showPickerDialog({
    required BuildContext context,
    required String label,
    required List<String> items,
    String? desc,
    String unit = '',
    int initialItem = 0,
    required void Function(int value) onItemSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomPickerDialog(
          context: context,
          items: items,
          label: label,
          desc: desc,
          onItemSelected: onItemSelected,
          initialItem: initialItem,
          unit: unit,
        );
      },
    );
  }

  static void showDatePickerDialog({
    required BuildContext context,
    required String label,
    String? desc,
    required DateTime initialDate,
    required Function(DateTime date) onDateSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDatePickerDialog(
          context: context,
          label: label,
          desc: desc,
          initialDate: initialDate,
          onDateSelected: onDateSelected,
        );
      },
    );
  }

  static void showCupertinoPicker(
    BuildContext context,
    List<String> items, {
    String unit = '',
    int initialItem = 0,
    String? title,
    String? description,
    required void Function(int value) onItemSelected,
  }) {
    int selectedItem = initialItem;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(borderRadius: AppStyles.kRadVT24, color: context.theme.colorScheme.onPrimary),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: AppStyles.kDoubleInfinity,
                child: Padding(
                  padding: AppStyles.kPaddSH28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStyles.kSizedBoxH16,
                      Text(
                        title ?? '',
                        style: Quicksand.medium
                            .withSize(FontSizes.large)
                            .copyWith(color: context.theme.colorScheme.primary),
                      ),
                      Text(
                        description ?? '',
                        style: Quicksand.light.withCustomSize(13).copyWith(color: context.theme.colorScheme.primary),
                      )
                    ],
                  ),
                ),
              ),
              AppStyles.kSizedBoxH12,
              SizedBox(
                height: AppStyles.kSize150,
                child: CupertinoPicker(
                  itemExtent: AppStyles.kSize40,
                  scrollController: FixedExtentScrollController(initialItem: initialItem),
                  onSelectedItemChanged: (int value) {
                    selectedItem = value;
                  },
                  children: items.map((item) => Center(child: Text('$item $unit'))).toList(),
                ),
              ),
              AppStyles.kSizedBoxH12,
              Padding(
                padding: AppStyles.kPaddSH28,
                child: Row(
                  children: [
                    Expanded(
                      child: AppDefaultButton(
                        label: S.current.cancelLabel,
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: context.theme.colorScheme.tertiary,
                        labelColor: context.theme.colorScheme.primary,
                        borderColor: context.theme.colorScheme.tertiary,
                        padding: AppStyles.kPaddSV12,
                      ),
                    ),
                    AppStyles.kSizedBoxW12,
                    Expanded(
                      child: AppDefaultButton(
                        label: S.current.selectLabel,
                        onPressed: () {
                          Navigator.of(context).pop();
                          onItemSelected(selectedItem);
                        },
                        padding: AppStyles.kPaddSV12,
                      ),
                    ),
                  ],
                ),
              ),
              AppStyles.kSizedBoxH12
            ],
          ),
        ),
      ),
    );
  }

  static void showDateCupertinoPicker(
    BuildContext context, {
    required DateTime initialDate,
    String? title,
    String? description,
    required void Function(DateTime date) onDateSelected,
  }) {
    DateTime selectedDate = initialDate;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: AppStyles.kRadVT24,
          color: context.theme.colorScheme.onPrimary,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title & Description
              SizedBox(
                width: AppStyles.kDoubleInfinity,
                child: Padding(
                  padding: AppStyles.kPaddSH28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStyles.kSizedBoxH16,
                      Text(
                        title ?? '',
                        style: Quicksand.medium
                            .withSize(FontSizes.large)
                            .copyWith(color: context.theme.colorScheme.primary),
                      ),
                      Text(
                        description ?? '',
                        style: Quicksand.light.withCustomSize(13).copyWith(color: context.theme.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
              AppStyles.kSizedBoxH12,
              SizedBox(
                height: AppStyles.kSize150,
                child: CupertinoDatePicker(
                  itemExtent: AppStyles.kSize40,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
              ),
              AppStyles.kSizedBoxH12,
              Padding(
                padding: AppStyles.kPaddSH28,
                child: Row(
                  children: [
                    Expanded(
                      child: AppDefaultButton(
                        label: S.current.cancelLabel,
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: context.theme.colorScheme.tertiary,
                        labelColor: context.theme.colorScheme.primary,
                        borderColor: context.theme.colorScheme.tertiary,
                        padding: AppStyles.kPaddSV12,
                      ),
                    ),
                    AppStyles.kSizedBoxW12,
                    Expanded(
                      child: AppDefaultButton(
                        label: S.current.selectLabel,
                        onPressed: () {
                          Navigator.of(context).pop();
                          onDateSelected(selectedDate);
                        },
                        padding: AppStyles.kPaddSV12,
                      ),
                    ),
                  ],
                ),
              ),
              AppStyles.kSizedBoxH12
            ],
          ),
        ),
      ),
    );
  }
}

class FunctionUtils {
  static Map<String, double> calculateMacronutrientPercentage({
    required double carbs,
    required double fat,
    required double protein,
  }) {
    // Calories per gram
    final carbCaloriesPerGram = MacroNutrients.carbs.multiplier;
    final proteinCaloriesPerGram = MacroNutrients.protein.multiplier;
    final fatCaloriesPerGram = MacroNutrients.fat.multiplier;

    // Total calories for each macro
    final carbCalories = carbs * carbCaloriesPerGram;
    final proteinCalories = protein * proteinCaloriesPerGram;
    final fatCalories = fat * fatCaloriesPerGram;

    // Total calories
    final totalCalories = carbCalories + proteinCalories + fatCalories;

    // Handle zero calories case
    if (totalCalories == 0) {
      return {
        'carbs': 0.0,
        'fat': 0.0,
        'protein': 0.0,
      };
    }

    // Raw percentages
    double carbPercent = carbCalories / totalCalories;
    double fatPercent = fatCalories / totalCalories;
    double proteinPercent = proteinCalories / totalCalories;

    // Rounding helper
    double roundTo(double value, [int places = 6]) => double.parse(value.toStringAsFixed(places));

    // Round values first
    carbPercent = roundTo(carbPercent);
    fatPercent = roundTo(fatPercent);
    proteinPercent = roundTo(proteinPercent);

    // Normalize to ensure total is exactly 1.0
    final total = roundTo(carbPercent + fatPercent + proteinPercent);
    final correction = roundTo(1.0 - total);

    // Apply correction to the largest macro
    final macroMap = {
      'carbs': carbPercent,
      'fat': fatPercent,
      'protein': proteinPercent,
    };

    final largestKey = macroMap.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    macroMap[largestKey] = roundTo(macroMap[largestKey]! + correction);

    return macroMap;
  }

  static int calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  static double getActivityFactor(String level) {
    switch (level) {
      case 'sedentary':
        return 1.2;
      case 'lightly active':
        return 1.375;
      case 'active':
        return 1.55;
      case 'very active':
        return 1.725;
      default:
        return 1.2;
    }
  }

  static double getExerciseFactor(String exerciseLevel) {
    switch (exerciseLevel) {
      case 'never':
        return 0.0;
      case 'light':
        return 0.1;
      case 'moderate':
        return 0.15;
      case 'frequent':
        return 0.2;
      default:
        return 0.0;
    }
  }

  static double adjustCaloriesForTargetWeeklyChange({
    required double tdee,
    required double targetWeeklyChange,
  }) {
    double calorieAdjustment = targetWeeklyChange * 7700 / 7;
    return tdee + calorieAdjustment;
  }

  static String getMacronutrientValueInGrams({
    required double totalCalories,
    required double ratio,
    required MacroNutrients macro,
  }) {
    return ((totalCalories * (ratio / 100)) / macro.multiplier).toStringAsFixed(0);
  }

  static String getMacronutrientValueInKcal({
    required double totalCalories,
    required double ratio,
  }) {
    return (totalCalories * (ratio / 100)).toStringAsFixed(0);
  }

  static Map<String, double> getMacroRatio(
    String dietType, {
    double? customProteinRatio,
    double? customFatRatio,
    double? customCarbsRatio,
  }) {
    late double proteinRatio;
    late double fatRatio;
    late double carbsRatio;

    switch (dietType) {
      case 'balanced':
        proteinRatio = 0.25;
        fatRatio = 0.25;
        carbsRatio = 0.50;
        break;
      case 'keto':
        proteinRatio = 0.20;
        fatRatio = 0.70;
        carbsRatio = 0.10;
        break;
      case 'mediterranean':
        proteinRatio = 0.15;
        fatRatio = 0.30;
        carbsRatio = 0.55;
        break;
      case 'vegetarian':
        proteinRatio = 0.30;
        fatRatio = 0.20;
        carbsRatio = 0.50;
        break;
      case 'paleo':
        proteinRatio = 0.30;
        fatRatio = 0.35;
        carbsRatio = 0.35;
        break;
      case 'low carbs':
        proteinRatio = 0.45;
        fatRatio = 0.35;
        carbsRatio = 0.20;
        break;
      default:
        proteinRatio = (customProteinRatio ?? 25) / 100;
        fatRatio = (customFatRatio ?? 25) / 100;
        carbsRatio = (customCarbsRatio ?? 50) / 100;
    }

    return {
      NutritionGoalsSettings.proteinRatio.key: proteinRatio * 100,
      NutritionGoalsSettings.fatRatio.key: fatRatio * 100,
      NutritionGoalsSettings.carbsRatio.key: carbsRatio * 100,
    };
  }

  static Map<int, double> calculateTotalFullNutrients(List<LoggedFoodModel> loggedFoods) {
    final Map<int, double> totals = {};

    for (final loggedFood in loggedFoods) {
      if (loggedFood.fullNutrients != null) {
        for (final nutrient in loggedFood.fullNutrients!) {
          if (nutrient.attrId != null) {
            totals[nutrient.attrId!] = (totals[nutrient.attrId!] ?? 0) + (nutrient.value ?? 0);
          }
        }
      }

      if (loggedFood.ingredients != null) {
        for (final ingredient in loggedFood.ingredients!) {
          if (ingredient.fullNutrients != null) {
            for (final nutrient in ingredient.fullNutrients!) {
              if (nutrient.attrId != null) {
                totals[nutrient.attrId!] = (totals[nutrient.attrId!] ?? 0) + (nutrient.value ?? 0);
              }
            }
          }
        }
      }
    }

    return totals;
  }

  static Map<String, int> calculateTotalNutrition(List<LoggedFoodModel>? meals) {
    int totalCalories = 0;
    int totalProtein = 0;
    int totalCarbs = 0;
    int totalFat = 0;

    if (meals != null) {
      for (final meal in meals) {
        totalCalories += (meal.calorieKcal ?? 0).round();
        totalProtein += (meal.proteinG ?? 0).round();
        totalCarbs += (meal.carbsG ?? 0).round();
        totalFat += (meal.fatG ?? 0).round();
      }
    }

    return {
      Nutrition.calorie.key: totalCalories,
      Nutrition.protein.key: totalProtein,
      Nutrition.carbs.key: totalCarbs,
      Nutrition.fat.key: totalFat,
    };
  }

  static Map<Nutrition, int> calculateAverageNutrients({
    required List<LoggedFoodModel> loggedFoods,
    required int dayRange,
    required List<Nutrition> wantedNutrients,
  }) {
    if (dayRange <= 0) return {};

    final totals = <Nutrition, double>{
      for (var n in wantedNutrients) n: 0.0,
    };

    for (final food in loggedFoods) {
      if (food.fullNutrients == null) continue;

      for (final nutrient in food.fullNutrients!) {
        for (final nutrition in wantedNutrients) {
          if (nutrient.attrId == nutrition.attrId) {
            totals[nutrition] = (totals[nutrition] ?? 0) + (nutrient.value ?? 0);
          }
        }
      }
    }

    final averages = <Nutrition, int>{};
    totals.forEach((nutrition, total) {
      averages[nutrition] = (total / dayRange).round();
    });

    return averages;
  }
}
