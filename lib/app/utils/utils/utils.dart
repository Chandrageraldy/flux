import 'package:flutter/cupertino.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/widgets/alert_dialog/adaptive_alert_dialog.dart';

import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class WidgetUtils {
  static Future<void> showDefaultErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async {
    final List<Widget> actionBuilders = [
      TextButton(
        onPressed: () {
          context.router.maybePop();
        },
        child: Text(S.current.okLabel.capitalize()),
      ),
    ];
    if (context.mounted) {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (context) => AdaptiveAlertDialog(
          errorMessage: errorMessage,
          actionBuilders: actionBuilders,
        ),
        useRootNavigator: false,
      );
    }
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
                        style: Quicksand.semiBold
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
                        style: Quicksand.semiBold
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
    final carbCaloriesPerGram = MacroNutrients.carbs.multiplier;
    final proteinCaloriesPerGram = MacroNutrients.protein.multiplier;
    final fatCaloriesPerGram = MacroNutrients.fat.multiplier;

    final carbCalories = carbs * carbCaloriesPerGram;
    final proteinCalories = protein * proteinCaloriesPerGram;
    final fatCalories = fat * fatCaloriesPerGram;

    final totalCalories = carbCalories + proteinCalories + fatCalories;

    final carbPercent = (carbCalories / totalCalories);
    final fatPercent = (fatCalories / totalCalories);
    final proteinPercent = (proteinCalories / totalCalories);

    return {
      'carbs': carbPercent,
      'fat': fatPercent,
      'protein': proteinPercent,
    };
  }
}
