import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/manual_plan_setup_vm/manual_plan_setup_view_model.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/manual_plan_setup/manual_plan_setup_option_button.dart';
import 'package:flux/app/widgets/manual_plan_setup/manual_plan_setup_picker_button.dart';
import 'package:intl/intl.dart';

import 'package:percent_indicator/percent_indicator.dart';

@RoutePage()
class ManualPlanSetupPage extends StatelessWidget {
  const ManualPlanSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ManualPlanSetupViewModel(), child: _ManualPlanSetupPage());
  }
}

class _ManualPlanSetupPage extends BaseStatefulPage {
  @override
  State<_ManualPlanSetupPage> createState() => _ManualPlanSetupPageState();
}

class _ManualPlanSetupPageState extends BaseStatefulState<_ManualPlanSetupPage> {
  int _currentQuestionIndex = 0;

  @override
  PreferredSizeWidget? appbar() {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          if (_currentQuestionIndex == 0) {
            context.router.maybePop();
          } else {
            _onBackNavigationPressed();
          }
        },
        child: Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }

  @override
  Color backgroundColor() => context.theme.colorScheme.onPrimary;

  @override
  bool useGradientBackground() => false;

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget body() {
    final bodyMetrics = context.select((ManualPlanSetupViewModel vm) => vm.bodyMetrics);
    final currentQuestion = planQuestionData[_currentQuestionIndex];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppStyles.kPaddOB20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getQuestionTitleLabel(),
                AppStyles.kSizedBoxH4,
                getQuestionDescriptionLabel(),
                AppStyles.kSizedBoxH32,
                currentQuestion.type == PlanSelectionQuestionType.options
                    ? getQuestionOptions(bodyMetrics, currentQuestion)
                    : getQuestionPickers(bodyMetrics, currentQuestion),
              ],
            ),
          ),
        ),
        getLinearPercentIndicator(),
        AppStyles.kSizedBoxH20,
        getContinueButton(bodyMetrics, currentQuestion),
        AppStyles.kSizedBoxH12,
      ],
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ManualPlanSetupPageState {
  int getInitialItemIndex(String key, List<String> items) {
    final initialHeightIndex = '165';
    final initialWeightIndex = '60';

    final bodyMetrics = context.read<ManualPlanSetupViewModel>().bodyMetrics;
    if (key == PlanSelectionKey.height.key) {
      return items.indexOf(initialHeightIndex); // Default height
    } else if (key == PlanSelectionKey.weight.key) {
      return items.indexOf(initialWeightIndex); // Default weight
    } else if (key == PlanSelectionKey.targetWeight.key) {
      final userWeight = bodyMetrics[PlanSelectionKey.weight.key];
      return items.indexOf(userWeight ?? initialWeightIndex);
    }
    return 0;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ManualPlanSetupPageState {
  void _onOptionPressed(String value) {
    context.read<ManualPlanSetupViewModel>().savebodyMetrics(planQuestionData[_currentQuestionIndex].key, value);
  }

  void _onPickerPressed(String key, List<String> items, String unit, String title, String description) {
    final currentSelectedValue = context.read<ManualPlanSetupViewModel>().bodyMetrics[key];

    // Determines the initial index in the picker.
    // - If the user already selected a value, use its index.
    // - Otherwise, use a default index based on the field type (height, weight, or target weight).
    final initialItemIndex = currentSelectedValue != null && items.contains(currentSelectedValue)
        ? items.indexOf(currentSelectedValue)
        : getInitialItemIndex(key, items);

    WidgetUtils.showPickerDialog(
      context: context,
      label: title,
      items: items,
      unit: unit,
      desc: description,
      initialItem: initialItemIndex,
      onItemSelected: (int index) {
        var selectedValue = items[index];
        if (key == PlanSelectionKey.gender.key) {
          selectedValue = selectedValue.toLowerCase();
        }
        context.read<ManualPlanSetupViewModel>().savebodyMetrics(key, selectedValue);
      },
    );
  }

  void _onDobPickerPressed(String key, String title, String description) {
    final currentSelectedValue = context.read<ManualPlanSetupViewModel>().bodyMetrics[key];

    final dateFormat = DateFormat.YEAR_MONTH_DAY;

    DateTime initialDate =
        currentSelectedValue != null ? currentSelectedValue.toDateTime(dateFormat) : DateTime(2000, 1, 1);

    WidgetUtils.showDatePickerDialog(
      context: context,
      initialDate: initialDate,
      label: title,
      desc: description,
      onDateSelected: (date) {
        final selectedDate = date;
        context.read<ManualPlanSetupViewModel>().savebodyMetrics(key, selectedDate.toFormattedString(dateFormat));
      },
    );
  }

  void _onLastQuestionContinueButtonPressed() {
    context.read<ManualPlanSetupViewModel>().cleanbodyMetrics();
    Map<String, String> bodyMetrics = context.read<ManualPlanSetupViewModel>().bodyMetrics;
    context.router.push(SignUpRoute(bodyMetrics: bodyMetrics));
  }

  // Advances to the next question.
  // If the "targetWeightWeekly" question is not relevant (target weight == current weight),
  // it will be skipped automatically by jumping two steps forward.
  void _onContinueButtonPressed(Map<String, String> bodyMetrics) {
    final nextIndex = _currentQuestionIndex + 1;

    final shouldSkipTargetWeeklyChange = planQuestionData[nextIndex].key == PlanSelectionKey.targetWeeklyChange.key &&
        bodyMetrics[PlanSelectionKey.targetWeight.key] == bodyMetrics[PlanSelectionKey.weight.key];

    if (shouldSkipTargetWeeklyChange && nextIndex + 1 < planQuestionData.length) {
      _setState(() => _currentQuestionIndex = nextIndex + 1);
    } else {
      _setState(() => _currentQuestionIndex = nextIndex);
    }
  }

  // Handles backward navigation when the back button is pressed.
  // If the "targetWeightWeekly" question was skipped, it should also be skipped when moving backward
  // by jumping two steps back to avoid showing a question that was not shown.
  void _onBackNavigationPressed() {
    final bodyMetrics = context.read<ManualPlanSetupViewModel>().bodyMetrics;
    final previousIndex = _currentQuestionIndex - 1;

    final shouldSkipTargetWeeklyChange =
        planQuestionData[_currentQuestionIndex - 1].key == PlanSelectionKey.targetWeeklyChange.key &&
            bodyMetrics[PlanSelectionKey.targetWeight.key] == bodyMetrics[PlanSelectionKey.weight.key];

    if (shouldSkipTargetWeeklyChange && previousIndex - 1 >= 0) {
      _setState(() => _currentQuestionIndex = previousIndex - 1);
    } else {
      _setState(() => _currentQuestionIndex = previousIndex);
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ManualPlanSetupPageState {
  // Question Title Label
  Widget getQuestionTitleLabel() {
    return Text(
      planQuestionData[_currentQuestionIndex].title,
      style: _Styles.getTitleLabelTextStyle(context),
    );
  }

  // Question Description Label
  Widget getQuestionDescriptionLabel() {
    return Text(
      planQuestionData[_currentQuestionIndex].description,
      style: _Styles.getDescriptionLabelTextStyle(context),
    );
  }

  // Question Options
  Widget getQuestionOptions(Map<String, String> bodyMetrics, PlanQuestion currentQuestion) {
    return Column(
      spacing: AppStyles.kSpac20,
      children: [
        ...currentQuestion.options!.map(
          (option) {
            return ManualPlanSetupOptionButton(
              title: option.title,
              description: option.description,
              icon: option.icon,
              onPressed: () => _onOptionPressed(option.value),
              isSelected: bodyMetrics[planQuestionData[_currentQuestionIndex].key] == option.value,
            );
          },
        ),
      ],
    );
  }

  // Question Pickers
  Widget getQuestionPickers(Map<String, String> bodyMetrics, PlanQuestion currentQuestion) {
    return Column(
      spacing: AppStyles.kSpac20,
      children: [
        ...currentQuestion.pickers!.map(
          (picker) {
            return ManualPlanSetupPickerButton(
              title: picker.title,
              pickedValue: bodyMetrics[picker.key] ?? '-',
              icon: picker.icon,
              onPressed: () => picker.key == PlanSelectionKey.dob.key
                  ? _onDobPickerPressed(picker.key, picker.title, picker.description)
                  : _onPickerPressed(picker.key, picker.items, picker.unit ?? '', picker.title, picker.description),
              unit: picker.unit ?? '',
              isPicked: bodyMetrics.containsKey(picker.key),
            );
          },
        ),
      ],
    );
  }

  // Linear Percent Indicator
  Widget getLinearPercentIndicator() {
    return LinearPercentIndicator(
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      lineHeight: _Styles.linearPercentIndicatorLineHeight,
      percent: (_currentQuestionIndex + 1) / planQuestionData.length,
      backgroundColor: context.theme.colorScheme.tertiary,
      progressColor: context.theme.colorScheme.primary,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
    );
  }

  // Continue Button
  Widget getContinueButton(
    Map<String, String> bodyMetrics,
    PlanQuestion currentQuestion,
  ) {
    // Determine if the current question has been fully answered
    final isAnswered = () {
      if (currentQuestion.type == PlanSelectionQuestionType.options) {
        return bodyMetrics.containsKey(currentQuestion.key);
      } else {
        final pickers = currentQuestion.pickers ?? [];
        // For picker-based questions, ensure all required pickers have a selected value
        return pickers.every((picker) => bodyMetrics.containsKey(picker.key));
      }
    }();

    return AppDefaultButton(
      label: S.current.continueLabel,
      // If the current question is answered:
      // - Go to the next question
      // - Or proceed to the next screen if this is the last question
      onPressed: isAnswered
          ? () => _currentQuestionIndex + 1 == planQuestionData.length
              ? _onLastQuestionContinueButtonPressed()
              : _onContinueButtonPressed(bodyMetrics)
          : null,
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Label Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.huge).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Description Label Text Style
  static TextStyle getDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Linear Percent Indicator Line Height
  static const double linearPercentIndicatorLineHeight = 8.0;
}
