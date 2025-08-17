import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/nutrient_progress_model/nutrient_progress_model.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/diary_vm/diary_view_model.dart';
import 'package:flux/app/widgets/food/macronutrient_intake_progress.dart';
import 'package:flux/app/widgets/food/meal_diary_card.dart';
import 'package:flux/app/widgets/food/nutrient_intake_progress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => DiaryViewModel(), child: _DiaryPage());
  }
}

class _DiaryPage extends BaseStatefulPage {
  @override
  State<_DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends BaseStatefulState<_DiaryPage> {
  final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

  DateTime _selectedDate = DateTime.now();
  int _currentPageIndex = 0;

  final EasyDatePickerController _datePickerController = EasyDatePickerController();

  @override
  bool hasDefaultPadding() => false;

  @override
  bool useGradientBackground() {
    return true;
  }

  @override
  void initState() {
    super.initState();
    _getLoggedFoods();
  }

  @override
  PreferredSizeWidget? appbar() {
    return AppBar(
      backgroundColor: AppColors.transparentColor,
      title: Image.asset(
        ImagePath.fluxLogo2,
        height: AppStyles.kSize50,
      ),
      scrolledUnderElevation: 0,
      actions: [getProfileActionButton(), getAddActionButton()],
    );
  }

  @override
  Widget body() {
    return RefreshIndicator(
      onRefresh: () async {
        _getLoggedFoods();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.kPaddSH16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.kSizedBoxH4,
              Container(
                padding: AppStyles.kPaddSV10,
                decoration: _Styles.getDateContainerDecoration(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppStyles.kSpac12,
                  children: [
                    Padding(
                      padding: AppStyles.kPaddSH16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [getDateShifterLabel(), getDateShifter()],
                      ),
                    ),
                    getDateTimeline()
                  ],
                ),
              ),
              AppStyles.kSizedBoxH16,
              getPageViewContainer(),
              AppStyles.kSizedBoxH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [getMealsLoggedLabel(), getEditButton(_onEditMealRatioPressed)],
              ),
              AppStyles.kSizedBoxH4,
              Column(
                spacing: AppStyles.kSpac16,
                children: [
                  ...MealType.values.map(
                    (type) {
                      final meals = context.select<DiaryViewModel, List<LoggedFoodModel>>(
                        (vm) => vm.loggedFoodsList.where((m) => m.mealType == type.value).toList(),
                      );
                      return MealDiaryCard(
                        mealType: type,
                        meals: meals,
                        selectedDate: _selectedDate,
                        getLoggedFoods: _getLoggedFoods,
                      );
                    },
                  ),
                  AppStyles.kSizedBoxH8,
                ],
              ),
            ],
          ),
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
  String _formatDay(DateTime selectedDate) {
    final now = DateTime.now();
    final difference = selectedDate.difference(DateTime(now.year, now.month, now.day)).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEEE').format(selectedDate);
    }
  }

  void _shiftDate(int days) {
    _setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    _datePickerController.animateToDate(_selectedDate);
    _getLoggedFoods();
  }

  void _onDateChanged(DateTime newDate) {
    _setState(() {
      _selectedDate = newDate;
    });
    _getLoggedFoods();
  }

  Future<void> _getLoggedFoods() async {
    await tryLoad(context, () => context.read<DiaryViewModel>().getLoggedFoods(selectedDate: _selectedDate));
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
        child: FaIcon(FontAwesomeIcons.solidUser, size: AppStyles.kSize18, color: context.theme.colorScheme.primary),
      ),
    );
  }

  // Add Action Button
  Widget getAddActionButton() {
    return GestureDetector(
      onTap: _onProfileActionPressed,
      child: Padding(
        padding: AppStyles.kPaddOR16,
        child: Icon(Icons.add_circle_rounded, size: AppStyles.kSize26, color: context.theme.colorScheme.primary),
      ),
    );
  }

  // Date Shifter Label
  Widget getDateShifterLabel() {
    final dayLabel = _formatDay(_selectedDate);
    final monthDateLabel = DateFormat('MMMM d').format(_selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$dayLabel,',
          style: _Styles.getDateShifterDayLabelTextStyle(context),
        ),
        Text(
          monthDateLabel,
          style: _Styles.getDateShifterMonthDateLabelTextStyle(context),
        ),
      ],
    );
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
        _onDateChanged(date);
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

  // Page View
  Widget getPageViewContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getIntakeContainerDecoration(context),
      padding: AppStyles.kPaddSV8,
      child: Column(
        children: [
          SizedBox(
            height: 215,
            child: PageView(
              onPageChanged: (index) {
                _setState(() {
                  _currentPageIndex = index;
                });
              },
              children: getPages(),
            ),
          ),
          AppStyles.kSizedBoxH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppStyles.kSpac8,
            children: [
              FaIcon(FontAwesomeIcons.chevronLeft, size: AppStyles.kSize10),
              Row(
                spacing: AppStyles.kSpac4,
                children: List.generate(
                  getPages().length,
                  (index) => getPageIndicator(index),
                ),
              ),
              FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kSize10),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> getPages() {
    return [
      getCalorieAndMacroTargetContainer(),
      getHighlightedNutrientsTargetContainer(),
    ];
  }

  // Calorie and Macro Target Container
  Widget getCalorieAndMacroTargetContainer() {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();
    final loggedFoods = context.select((DiaryViewModel vm) => vm.loggedFoodsList);
    final totalNutrition = FunctionUtils.calculateTotalNutrition(loggedFoods);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppStyles.kPaddSH20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: AppStyles.kSpac4,
                children: [FaIcon(FontAwesomeIcons.crosshairs, size: AppStyles.kSize12), getTargetsLabel()],
              ),
              getEditButton(() {}),
            ],
          ),
        ),
        AppStyles.kSizedBoxH8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: getCalorieGoalColumn((userPlan?.calorieKcal ?? 0).toInt(), S.current.goalLabel),
            ),
            getCalorieCircularPercentIndicator(
              (userPlan?.calorieKcal ?? 0).toInt(),
              (totalNutrition[Nutrition.calorie.key] ?? 0).toInt(),
            ),
            Expanded(
              child: getCalorieLoggedColumn(totalNutrition[Nutrition.calorie.key] ?? 0, S.current.loggedLabel),
            ),
          ],
        ),
        AppStyles.kSizedBoxH8,
        Padding(padding: AppStyles.kPaddSH12, child: getMacroNutrientIntakeProgressRow(totalNutrition, userPlan)),
      ],
    );
  }

  // Highlighted Nutrients Target Container
  Widget getHighlightedNutrientsTargetContainer() {
    final loggedFoodsList = context.select((DiaryViewModel vm) => vm.loggedFoodsList);
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final highlightedList = [
      Nutrition.calcium,
      Nutrition.iron,
      Nutrition.magnesium,
      Nutrition.potassium,
      Nutrition.sodium,
      Nutrition.zinc,
      Nutrition.vitaminA,
      Nutrition.vitaminD,
      Nutrition.vitaminC,
      Nutrition.vitaminB12,
    ];

    final progressList = getNutrientProgressList(
      loggedFoodsList,
      userPlan,
      highlightedList,
    );

    return Padding(
      padding: AppStyles.kPaddSH20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: AppStyles.kSpac4,
                children: [FaIcon(FontAwesomeIcons.crosshairs, size: AppStyles.kSize12), getHighlightedMicroLabel()],
              ),
              getFullReportButton(),
            ],
          ),
          AppStyles.kSizedBoxH12,
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 4,
            crossAxisSpacing: AppStyles.kSize8,
            children: progressList.map((nutrient) {
              return NutrientIntakeProgress(
                nutrition: nutrient.nutrition,
                percentage: (nutrient.currentValue / nutrient.targetValue).clamp(0, 1),
                currentValue: nutrient.currentValue,
                targetValue: nutrient.targetValue,
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  // Targets Label
  Widget getTargetsLabel() {
    return Text(S.current.targetsLabel.toUpperCase(), style: _Styles.getTargetsLabelTextStyle(context));
  }

  // Highlighted Micro Label
  Widget getHighlightedMicroLabel() {
    return Text(S.current.highlightedMicroLabel.toUpperCase(), style: _Styles.getTargetsLabelTextStyle(context));
  }

  // Calorie Circular Percent Indicator
  Widget getCalorieCircularPercentIndicator(int goal, int logged) {
    final remaining = goal - logged;

    return SizedBox(
      child: CircularPercentIndicator(
        lineWidth: AppStyles.kSize7,
        radius: AppStyles.kSize56,
        percent: goal > 0 ? (logged / goal).clamp(0, 1) : 0,
        progressColor: context.theme.colorScheme.secondary,
        center: getCalorieCircularCenterLabel(remaining),
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        animateFromLastPercent: true,
        animateToInitialPercent: false,
        arcType: ArcType.FULL,
        arcBackgroundColor: context.theme.colorScheme.tertiary,
      ),
    );
  }

  // Calorie Goal Column
  Widget getCalorieGoalColumn(int value, String label) {
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        Text('$value', style: _Styles.getIntakeLabelTextStyle(context)),
        Text(label, style: _Styles.getGoalLabelTextStyle(context)),
      ],
    );
  }

  // Calorie Logged Column
  Widget getCalorieLoggedColumn(int value, String label) {
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        Text('$value', style: _Styles.getIntakeLabelTextStyle(context)),
        Text(label, style: _Styles.getLoggedLabelTextStyle(context)),
      ],
    );
  }

  // Calorie Circular Center Label
  Widget getCalorieCircularCenterLabel(int remaining) {
    final isOverTarget = remaining < 0;
    final displayValue = isOverTarget ? '+${remaining.abs()}' : '$remaining';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          displayValue,
          style: _Styles.getRemainingValueLabelTextStyle(context),
        ),
        Text(
          isOverTarget ? S.current.surplusLabel : S.current.remainingLabel,
          style: _Styles.getRemainingLabelTextStyle(context),
        ),
        AppStyles.kSizedBoxH4
      ],
    );
  }

  // Macro Nutrient Intake Progress Row
  Widget getMacroNutrientIntakeProgressRow(Map<String, int> totalNutrition, PlanModel? logged) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [
        MacronutrientIntakeProgress(
          macroNutrient: MacroNutrients.protein,
          percentage: (totalNutrition[Nutrition.protein.key] ?? 0) / (logged?.proteinG ?? 1),
          currentValue: totalNutrition[Nutrition.protein.key] ?? 0,
          targetValue: (logged?.proteinG ?? 0).toInt(),
        ),
        MacronutrientIntakeProgress(
          macroNutrient: MacroNutrients.carbs,
          percentage: (totalNutrition[Nutrition.carbs.key] ?? 0) / (logged?.carbsG ?? 1),
          currentValue: totalNutrition[Nutrition.carbs.key] ?? 0,
          targetValue: (logged?.carbsG ?? 0).toInt(),
        ),
        MacronutrientIntakeProgress(
          macroNutrient: MacroNutrients.fat,
          percentage: (totalNutrition[Nutrition.fat.key] ?? 0) / (logged?.fatG ?? 1),
          currentValue: totalNutrition[Nutrition.fat.key] ?? 0,
          targetValue: (logged?.fatG ?? 0).toInt(),
        ),
      ],
    );
  }

  // Meals Logged Label
  Widget getMealsLoggedLabel() {
    return Text(S.current.loggedMealsLabel.toUpperCase(), style: _Styles.getMealsLoggedLabelTextStyle(context));
  }

  // Edit Button
  Widget getEditButton(VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(S.current.editLabel.toUpperCase(), style: _Styles.getEditLabelTextStyle(context)),
    );
  }

  // Edit Button
  Widget getFullReportButton() {
    final loggedFoodsList = context.select((DiaryViewModel vm) => vm.loggedFoodsList);
    return Row(
      spacing: AppStyles.kSpac4,
      children: [
        GestureDetector(
          onTap: () {
            context.router.push(DailyReportRoute(selectedDate: _selectedDate, loggedFoodsList: loggedFoodsList));
          },
          child: Text(S.current.fullReportLabel.toUpperCase(), style: _Styles.getEditLabelTextStyle(context)),
        ),
        FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kSize12, color: context.theme.colorScheme.secondary),
      ],
    );
  }

  // Page Indicator
  Widget getPageIndicator(int index) {
    return Container(
      width: AppStyles.kSize8,
      height: AppStyles.kSize8,
      decoration: _Styles.getPageIndicatorContainerDecoration(context, index, _currentPageIndex),
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

  // Targets Label Text Style
  static TextStyle getTargetsLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withCustomSize(11);
  }

  // Calorie Intake Label Text Style
  static TextStyle getIntakeLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium);
  }

  // Goal Label Text Style
  static TextStyle getGoalLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Logged Label Text Style
  static TextStyle getLoggedLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Remaining Label Text Style
  static TextStyle getRemainingLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Remaining Value Label Text Style
  static TextStyle getRemainingValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Date Shifter Day Label Text Style
  static TextStyle getDateShifterDayLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Date Shifter Month Date Label Text Style
  static TextStyle getDateShifterMonthDateLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Meals Logged Label Text Style
  static TextStyle getMealsLoggedLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withCustomSize(11);
  }

  // Edit Label Text Style
  static TextStyle getEditLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Date Timeline Container Decoration
  static BoxDecoration getDateTimelineContainerDecoration(BuildContext context, bool isSelected) {
    return BoxDecoration(
      color: isSelected ? context.theme.colorScheme.secondary : context.theme.colorScheme.tertiaryContainer,
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

  // Date Container Decoration
  static BoxDecoration getDateContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Page Indicator Container Decoration
  static BoxDecoration getPageIndicatorContainerDecoration(BuildContext context, int index, int currentPageIndex) {
    return BoxDecoration(
      color: currentPageIndex == index ? context.theme.colorScheme.secondary : context.theme.colorScheme.tertiary,
      borderRadius: AppStyles.kRad100,
    );
  }
}
