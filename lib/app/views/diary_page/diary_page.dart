import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/macronutrient_intake_progress.dart';
import 'package:flux/app/widgets/food/meal_diary_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class DiaryPage extends BaseStatefulPage {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends BaseStatefulState<DiaryPage> {
  DateTime _selectedDate = DateTime.now();

  final EasyDatePickerController _datePickerController = EasyDatePickerController();

  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: AppStyles.kPaddOL20R20B16,
        child: Column(
          spacing: AppStyles.kSpac16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.kSizedBoxH4,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppStyles.kSpac24,
              children: [getDateShifterContainer(), getDateTimeline()],
            ),
            getCalorieIntakeContainer(),
            getMacroNutrientIntakeContainer(),
            getMealsLoggedLabel(),
            MealDiaryCard(mealType: MealType.breakfast),
            MealDiaryCard(mealType: MealType.lunch),
            MealDiaryCard(mealType: MealType.dinner),
            MealDiaryCard(mealType: MealType.snack),
          ],
        ),
      ),
    );
  }

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _DiaryPageState {
  void _shiftDate(int days) {
    _setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    _datePickerController.animateToDate(_selectedDate);
  }

  String _formatDate(DateTime selectedDate) {
    final now = DateTime.now();

    if (DateUtils.isSameDay(selectedDate, now)) {
      return 'Today, ${DateFormat('MMMM d').format(selectedDate)}'; // Today, July 18
    } else {
      return DateFormat('EEEE, MMMM d').format(selectedDate); // Wednesday, July 17
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _DiaryPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _DiaryPageState {
  // Date Shifter Container
  Widget getDateShifterContainer() {
    final today = DateTime.now();
    final minDate = today.subtract(const Duration(days: 7));
    final maxDate = today.add(const Duration(days: 7));

    final DateTime previousDate = _selectedDate.subtract(const Duration(days: 1));
    final DateTime nextDate = _selectedDate.add(const Duration(days: 1));

    // Allow going to the previous date (left arrow) if:
    // - the previous date is after the minimum allowed date, OR
    // - the previous date is exactly equal to the minimum date
    final bool canGoPrevious = previousDate.isAfter(minDate) || DateUtils.isSameDay(previousDate, minDate);

    // Allow going to the next date (right arrow) if:
    // - the next date is before the maximum allowed date, OR
    // - the next date is exactly equal to the maximum date
    final bool canGoNext = nextDate.isBefore(maxDate) || DateUtils.isSameDay(nextDate, maxDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getDateShifterButton(() => _shiftDate(-1), FontAwesomeIcons.chevronLeft, canGoPrevious),
        getDateShifterLabel(),
        getDateShifterButton(() => _shiftDate(1), FontAwesomeIcons.chevronRight, canGoNext),
      ],
    );
  }

  // Date Shifter Button
  Widget getDateShifterButton(VoidCallback onPressed, IconData icon, bool isEnabled) {
    return IconButton(
      onPressed: isEnabled ? onPressed : null,
      icon: FaIcon(icon, size: AppStyles.kIconSize20, color: isEnabled ? null : Colors.grey),
    );
  }

  // Date Shifter Label
  Widget getDateShifterLabel() {
    return Text(
      _formatDate(_selectedDate),
      style: _Styles.getDateShifterLabelTextStyle(context),
    );
  }

  // Date Timeline
  Widget getDateTimeline() {
    return EasyTheme(
      data: _Styles.getDateTimelineTheme(context),
      child: EasyDateTimeLinePicker(
        controller: _datePickerController,
        headerOptions: HeaderOptions(headerType: HeaderType.none),
        focusedDate: _selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 7)),
        lastDate: DateTime.now().add(const Duration(days: 7)),
        timelineOptions: TimelineOptions(height: AppStyles.kSize80),
        itemExtent: AppStyles.kSize56,
        onDateChange: (date) {
          _setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  // Calorie Intake Container
  Widget getCalorieIntakeContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getIntakeContainerDecoration(context),
      padding: AppStyles.kPaddSV8,
      child: Column(
        children: [
          getCalorieIntakeLabel(),
          getCalorieFormulaLabel(),
          AppStyles.kSizedBoxH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getCalorieInformationLabel('3000', S.current.goalLabel),
              getCalorieCircularPercentIndicator(),
              getCalorieInformationLabel('1000', S.current.loggedLabel),
            ],
          ),
          AppStyles.kSizedBoxH4,
        ],
      ),
    );
  }

  // Calorie Intake Label
  Widget getCalorieIntakeLabel() {
    return Text(S.current.calorieLabel, style: _Styles.getIntakeLabelTextStyle(context));
  }

  // Calorie Formula Label
  Widget getCalorieFormulaLabel() {
    return Text(S.current.calorieFormula, style: _Styles.getCalorieFormulaLabelTextStyle(context));
  }

  // Calorie Circular Percent Indicator
  Widget getCalorieCircularPercentIndicator() {
    return SizedBox(
      child: CircularPercentIndicator(
        lineWidth: _Styles.circularPercentIndicatorLineWidth,
        radius: AppStyles.kSize45,
        percent: 0.66,
        progressColor: context.theme.colorScheme.secondary,
        backgroundColor: context.theme.colorScheme.tertiary,
        center: getCalorieCircularCenterLabel(),
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        animateFromLastPercent: true,
        animateToInitialPercent: false,
      ),
    );
  }

  // Calorie Information Label
  Widget getCalorieInformationLabel(String value, String label) {
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        Text(value, style: _Styles.getIntakeLabelTextStyle(context)),
        Text(label, style: _Styles.getCalorieFormulaLabelTextStyle(context)),
      ],
    );
  }

  // Calorie Circular Center Label
  Widget getCalorieCircularCenterLabel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('2000', style: _Styles.getRemainingValueLabelTextStyle(context)),
        Text(S.current.remainingLabel, style: _Styles.getCalorieFormulaLabelTextStyle(context)),
        AppStyles.kSizedBoxH4
      ],
    );
  }

  // Macro Nutrient Intake Container
  Widget getMacroNutrientIntakeContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getIntakeContainerDecoration(context),
      padding: AppStyles.kPaddSV8H16,
      child: Column(
        spacing: AppStyles.kSpac12,
        children: [getMacroNutrientIntakeLabel(), getMacroNutrientIntakeProgressRow()],
      ),
    );
  }

  // Macro Nutrient Intake Label
  Widget getMacroNutrientIntakeLabel() {
    return Text(S.current.macronutrientsLabel, style: _Styles.getIntakeLabelTextStyle(context));
  }

  // Macro Nutrient Intake Progress Row
  Widget getMacroNutrientIntakeProgressRow() {
    return Row(
      spacing: AppStyles.kSpac16,
      children: [
        MacronutrientIntakeProgress(
          macroNutrient: MacroNutrients.protein,
          percentage: 0.8,
          currentValue: 80,
          targetValue: 100,
        ),
        MacronutrientIntakeProgress(
          macroNutrient: MacroNutrients.carbs,
          percentage: 0.6,
          currentValue: 60,
          targetValue: 100,
        ),
        MacronutrientIntakeProgress(
          macroNutrient: MacroNutrients.fat,
          percentage: 0.5,
          currentValue: 50,
          targetValue: 100,
        ),
      ],
    );
  }

  // Meals Logged Label
  Widget getMealsLoggedLabel() {
    return Text(S.current.loggedMealsLabel, style: _Styles.getMealsLoggedLabelTextStyle(context));
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  // Calorie Intake Container Decoration
  static BoxDecoration getIntakeContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Calorie Intake Label Text Style
  static TextStyle getIntakeLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium);
  }

  // Calorie Formula Label Text Style
  static TextStyle getCalorieFormulaLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Remaining Label Label Text Style
  static TextStyle getRemainingValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Circular Percent Indicator Line Width
  static double circularPercentIndicatorLineWidth = 6.0;

  // Date Timeline Theme
  static EasyThemeData getDateTimelineTheme(BuildContext context) {
    return EasyTheme.of(context).copyWithState(
      selectedDayTheme: DayThemeData(
        backgroundColor: context.theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
      ),
      unselectedDayTheme: DayThemeData(
        backgroundColor: context.theme.colorScheme.onPrimary,
        border: BorderSide(color: Colors.transparent),
        shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
      ),
      disabledDayTheme: DayThemeData(
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
      ),
      selectedCurrentDayTheme: DayThemeData(
        backgroundColor: context.theme.colorScheme.secondary,
        border: BorderSide(color: Colors.transparent),
        shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
      ),
      unselectedCurrentDayTheme: DayThemeData(
        backgroundColor: context.theme.colorScheme.secondary.withValues(alpha: 0.05),
        border: BorderSide(color: Colors.transparent),
        shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
      ),
    );
  }

  // Date Shifter Label Text Style
  static TextStyle getDateShifterLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraLarge);
  }

  // Meals Logged Label Text Style
  static TextStyle getMealsLoggedLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium);
  }
}
