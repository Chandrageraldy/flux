import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
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
  final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

  DateTime _selectedDate = DateTime.now();

  final EasyDatePickerController _datePickerController = EasyDatePickerController();

  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  bool useGradientBackground() {
    return true;
  }

  @override
  PreferredSizeWidget? appbar() {
    return AppBar(
      backgroundColor: AppColors.transparentColor,
      title: Image.asset(
        ImagePath.fluxPadding,
        height: AppStyles.kSize80,
      ),
      scrolledUnderElevation: 0,
      actions: [getProfileActionButton()],
    );
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.kSizedBoxH4,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppStyles.kSpac12,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [getDateShifterLabel(), getDateShifter()],
                ),
                getDateTimeline()
              ],
            ),
            AppStyles.kSizedBoxH16,
            getTargetsContainer(),
            AppStyles.kSizedBoxH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getMealsLoggedLabel(), getEditButton(_onEditMealRatioPressed)],
            ),
            AppStyles.kSizedBoxH4,
            Column(
              spacing: AppStyles.kSpac16,
              children: [
                MealDiaryCard(mealType: MealType.breakfast),
                MealDiaryCard(mealType: MealType.lunch),
                MealDiaryCard(mealType: MealType.dinner),
                MealDiaryCard(mealType: MealType.snack),
                AppStyles.kEmptyWidget,
              ],
            ),
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
  String _formatDate(DateTime selectedDate) {
    final now = DateTime.now();

    if (DateUtils.isSameDay(selectedDate, now)) {
      return 'Today, ${DateFormat('MMMM d').format(selectedDate)}'; // Today, July 18
    } else {
      return DateFormat('EEEE, MMMM d').format(selectedDate); // Wednesday, July 17
    }
  }

  void _shiftDate(int days) {
    _setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    _datePickerController.animateToDate(_selectedDate);
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _DiaryPageState {
  void _onEditMealRatioPressed() {}

  void _onProfileActionPressed() {
    context.router.replaceAll([ProfileRoute()]);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _DiaryPageState {
  // Profile Action Button
  Widget getProfileActionButton() {
    return GestureDetector(
      onTap: _onProfileActionPressed,
      child: Padding(
        padding: AppStyles.kPaddOR16,
        child: FaIcon(FontAwesomeIcons.user, size: AppStyles.kSize18, color: context.theme.colorScheme.primary),
      ),
    );
  }

  // Date Shifter Label
  Widget getDateShifterLabel() {
    return Text(_formatDate(_selectedDate), style: _Styles.getDateShifterLabelTextStyle(context));
  }

  // Date Shifter
  Widget getDateShifter() {
    final today = DateTime.now();
    final minDate = today.subtract(const Duration(days: 7));
    final maxDate = today.add(const Duration(days: 7));

    final DateTime previousDate = _selectedDate.subtract(const Duration(days: 1));
    final DateTime nextDate = _selectedDate.add(const Duration(days: 1));

    final bool canGoPrevious = previousDate.isAfter(minDate) || DateUtils.isSameDay(previousDate, minDate);
    final bool canGoNext = nextDate.isBefore(maxDate) || DateUtils.isSameDay(nextDate, maxDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppStyles.kSpac12,
      children: [
        getDateShifterButton(() => _shiftDate(-1), FontAwesomeIcons.arrowLeft, canGoPrevious),
        getDateShifterButton(() => _shiftDate(1), FontAwesomeIcons.arrowRight, canGoNext),
      ],
    );
  }

  // Date Shifter Button
  Widget getDateShifterButton(VoidCallback onPressed, IconData icon, bool isEnabled) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        padding: AppStyles.kPadd8,
        decoration: _Styles.getDateShifterButtonContainerDecoration(context, isEnabled),
        child: FaIcon(
          icon,
          size: AppStyles.kSize16,
          color: isEnabled ? context.theme.colorScheme.onTertiary : context.theme.colorScheme.tertiaryFixed,
        ),
      ),
    );
  }

  // Date Timeline
  Widget getDateTimeline() {
    return EasyDateTimeLinePicker.itemBuilder(
      controller: _datePickerController,
      headerOptions: HeaderOptions(headerType: HeaderType.none),
      focusedDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      timelineOptions: TimelineOptions(height: AppStyles.kSize70),
      itemExtent: AppStyles.kSize50,
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: AppStyles.kPaddSV2,
            child: Container(
              decoration: _Styles.getDateTimelineContainerDecoration(context, isSelected),
              child: Center(
                child: Column(
                  spacing: AppStyles.kSpac2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getDateTimelineMonthLabel(date, isSelected),
                    getDateTimelineDayLabel(date, isSelected),
                    getDateTimelineWeekdayLabel(date, isSelected)
                  ],
                ),
              ),
            ),
          ),
        );
      },
      onDateChange: (date) {
        _setState(() {
          _selectedDate = date;
        });
      },
    );
  }

  // Date Timeline Month Label
  Widget getDateTimelineMonthLabel(DateTime date, bool isSelected) {
    return Text(
      DateFormat.MMM().format(date),
      style: _Styles.getDateTimelineMonthLabelTextStyle(context, isSelected),
    );
  }

  // Date Timeline Day Label
  Widget getDateTimelineDayLabel(DateTime date, bool isSelected) {
    return Text(
      date.day.toString(),
      style: _Styles.getDateTimelineDayLabelTextStyle(context, isSelected),
    );
  }

  // Date Timeline Weekday Label
  Widget getDateTimelineWeekdayLabel(DateTime date, bool isSelected) {
    return Text(
      DateFormat.E().format(date),
      style: _Styles.getDateTimelineWeekdayLabelTextStyle(context, isSelected),
    );
  }

  // Calorie Intake Container
  Widget getTargetsContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getIntakeContainerDecoration(context),
      padding: AppStyles.kPaddSV8,
      child: Column(
        children: [
          getCalorieIntakeLabel(),
          getCalorieFormulaLabel(),
          AppStyles.kSizedBoxH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getCalorieInformationLabel('3000', S.current.goalLabel),
              getCalorieCircularPercentIndicator(),
              getCalorieInformationLabel('1000', S.current.loggedLabel),
            ],
          ),
          AppStyles.kSizedBoxH12,
          Padding(
            padding: AppStyles.kPaddSH12,
            child: getMacroNutrientIntakeProgressRow(),
          )
        ],
      ),
    );
  }

  // Calorie Intake Label
  Widget getCalorieIntakeLabel() {
    return Text(S.current.targetsLabel, style: _Styles.getIntakeLabelTextStyle(context));
  }

  // Calorie Formula Label
  Widget getCalorieFormulaLabel() {
    return Text(S.current.calorieFormula, style: _Styles.getCalorieFormulaLabelTextStyle(context));
  }

  // Calorie Circular Percent Indicator
  Widget getCalorieCircularPercentIndicator() {
    return SizedBox(
      child: CircularPercentIndicator(
        lineWidth: AppStyles.kSize7,
        radius: AppStyles.kSize56,
        percent: 0.66,
        progressColor: context.theme.colorScheme.secondary,
        center: getCalorieCircularCenterLabel(),
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        animateFromLastPercent: true,
        animateToInitialPercent: false,
        arcType: ArcType.FULL,
        arcBackgroundColor: context.theme.colorScheme.tertiary,
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

  // Macro Nutrient Intake Progress Row
  Widget getMacroNutrientIntakeProgressRow() {
    return Row(
      spacing: AppStyles.kSpac8,
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

  // Edit Button
  Widget getEditButton(VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(S.current.editLabel.toUpperCase(), style: _Styles.getEditLabelTextStyle(context)),
    );
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
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Calorie Intake Label Text Style
  static TextStyle getIntakeLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium);
  }

  // Calorie Formula Label Text Style
  static TextStyle getCalorieFormulaLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Remaining Label Label Text Style
  static TextStyle getRemainingValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Date Shifter Label Text Style
  static TextStyle getDateShifterLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large);
  }

  // Meals Logged Label Text Style
  static TextStyle getMealsLoggedLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withCustomSize(13).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Edit Label Text Style
  static TextStyle getEditLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Date Timeline Container Decoration
  static BoxDecoration getDateTimelineContainerDecoration(BuildContext context, bool isSelected) {
    return BoxDecoration(
      color: isSelected ? context.theme.colorScheme.secondary : context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Date Timeline Month Label Text Style
  static TextStyle getDateTimelineMonthLabelTextStyle(BuildContext context, bool isSelected) {
    return Quicksand.medium
        .withSize(FontSizes.extraSmall)
        .copyWith(color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiary);
  }

  // Date Timeline Day Label Text Style
  static TextStyle getDateTimelineDayLabelTextStyle(BuildContext context, bool isSelected) {
    return Quicksand.bold
        .withSize(FontSizes.medium)
        .copyWith(color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiary);
  }

  // Date Timeline Weekday Label Text Style
  static TextStyle getDateTimelineWeekdayLabelTextStyle(BuildContext context, bool isSelected) {
    return Quicksand.medium
        .withSize(FontSizes.extraSmall)
        .copyWith(color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiary);
  }

  // Date Shifter Button Container Decoration
  static BoxDecoration getDateShifterButtonContainerDecoration(BuildContext context, bool isEnabled) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      shape: BoxShape.circle,
    );
  }
}
