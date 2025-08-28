import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/weekly_calorie_progress_vm/weekly_calorie_progress_view_model.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_tappable.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_with_desc.dart';
import 'package:flux/app/widgets/list_tile/profile_settings_list_tile.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

@RoutePage()
class WeeklyCalorieProgressPage extends StatelessWidget {
  const WeeklyCalorieProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => WeeklyCalorieProgressViewModel(), child: _WeeklyCalorieProgressPage());
  }
}

class _WeeklyCalorieProgressPage extends BaseStatefulPage {
  @override
  State<_WeeklyCalorieProgressPage> createState() => _WeeklyCalorieProgressPageState();
}

class _WeeklyCalorieProgressPageState extends BaseStatefulState<_WeeklyCalorieProgressPage> {
  @override
  bool hasDefaultPadding() => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLoggedFoodsBetweenDates();
    });
  }

  @override
  Widget body() {
    final isLoading = context.select((WeeklyCalorieProgressViewModel vm) => vm.isLoading);
    return Column(
      children: [
        getCustomAppBar(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _getLoggedFoodsBetweenDates,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: AppStyles.kPaddSH12,
                child: Column(
                  spacing: AppStyles.kSpac12,
                  children: [
                    if (isLoading) ...[
                      AppStyles.kEmptyWidget,
                      Skeleton(width: AppStyles.kDoubleInfinity, height: 260),
                      Skeleton(width: AppStyles.kDoubleInfinity, height: 140),
                    ] else ...[
                      AppStyles.kEmptyWidget,
                      getWeeklyCalorieProgressContainer(),
                      getDateSettingsContainer(),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _WeeklyCalorieProgressPageState {
  void _onDatePickerPressed(WeeklyCalorieProgressDateModel setting) {
    final vm = context.read<WeeklyCalorieProgressViewModel>();
    final currentSelectedValue = vm.dates[setting.key] ?? '';

    final dateFormat = DateFormat('MM/dd/yy');

    DateTime initialDate = currentSelectedValue.isNotEmpty ? dateFormat.parse(currentSelectedValue) : DateTime.now();

    WidgetUtils.showDatePickerDialog(
      context: context,
      label: setting.label,
      desc: setting.desc,
      initialDate: initialDate,
      onDateSelected: (selectedDate) {
        final formatted = dateFormat.format(selectedDate);
        vm.onDateSelected(setting.key, formatted, context);
      },
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _WeeklyCalorieProgressPageState {
  List<double> getWeeklyCaloriesList({required BuildContext context}) {
    final loggedFoods = context.select((WeeklyCalorieProgressViewModel vm) => vm.loggedFoodsBetweenDates);
    final activeDates = context.select((WeeklyCalorieProgressViewModel vm) => vm.activeDates);

    final dateFormat = DateFormat('MM/dd/yy');

    final startDate = dateFormat.parse(activeDates[WeeklyCalorieProgressDateSettings.startDate.key]!);
    final endDate = dateFormat.parse(activeDates[WeeklyCalorieProgressDateSettings.endDate.key]!);

    final Map<String, double> dailyCalories = {};

    // Generate {Start Date: 0.0, ...... , End Date: 0.0}
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      final day = startDate.add(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(day);
      dailyCalories[key] = 0.0;
    }

    // Add calories on the corresponding date using the date key
    for (final food in loggedFoods) {
      if (food.loggedAt == null || food.calorieKcal == null) continue;

      final dateKey = DateFormat('yyyy-MM-dd').format(food.loggedAt!);
      if (dailyCalories.containsKey(dateKey)) {
        dailyCalories[dateKey] = (dailyCalories[dateKey] ?? 0) + food.calorieKcal!;
      }
    }

    // return a list of daily calorie intakes for the selected range
    return dailyCalories.values.toList();
  }

  Future<void> _getLoggedFoodsBetweenDates() async {
    await tryCatch(
      context,
      () => context.read<WeeklyCalorieProgressViewModel>().getLoggedFoodsBetweenDates(
            startDate: DateTime.now().subtract(const Duration(days: 6)),
            endDate: DateTime.now(),
          ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _WeeklyCalorieProgressPageState {
  // Custom App Bar
  Widget getCustomAppBar() {
    return CustomAppBarWithDesc(
      leadingButton: CustomAppBarTappable(
        icon: FontAwesomeIcons.chevronLeft,
        color: context.theme.colorScheme.primary,
        label: '',
        modalSheetBarTappablePosition: CustomAppBarTappablePosition.LEADING,
        onTap: () => context.router.maybePop(),
      ),
      trailingButton: AppStyles.kEmptyWidget,
      title: S.current.weeklyCalorieProgressLabel,
      desc: S.current.weeklyCalorieProgressDesc,
    );
  }

  // Weekly Calorie Progress Container
  Widget getWeeklyCalorieProgressContainer() {
    final weeklyCalories = getWeeklyCaloriesList(context: context);
    return Container(
      decoration: _Styles.getChartContainerDecoration(context),
      width: double.infinity,
      padding: AppStyles.kPaddSV12H12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac8,
        children: [
          getWeeklyCalorieProgressHeader(weeklyCalories: weeklyCalories),
          getWeeklyCalorieProgressChart(weeklyCalories: weeklyCalories),
          getWeeklyCalorieProgressIndicatorHintColumn(),
        ],
      ),
    );
  }

  // Weekly Calorie Progress Header
  Widget getWeeklyCalorieProgressHeader({required List<double> weeklyCalories}) {
    var sum = weeklyCalories.reduce((a, b) => a + b);
    var average = sum / weeklyCalories.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.weeklyCalorieProgressLabel.toUpperCase(),
              style: _Styles.getChartHeaderLabelTextStyle(context),
            ),
            Row(
              spacing: AppStyles.kSpac4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${average.toStringAsFixed(1)} ${NutritionUnit.kcal.label}',
                    style: _Styles.getChartValueLabelTextStyle(context)),
                Padding(
                  padding: AppStyles.kPaddOB3,
                  child: Text(S.current.averageLabel, style: _Styles.getChartDescLabelTextStyle(context)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Weekly Calorie Progress Chart
  Widget getWeeklyCalorieProgressChart({required List<double> weeklyCalories}) {
    final userPlan = SharedPreferenceHandler().getPlan();

    // Check if the weeklyCalories contains all zero
    final isAllZero = weeklyCalories.every((c) => c == 0);

    // Get the maximum value in the weeklyCalories list, and round up to the nearest 500 => 2345 to 2500 for the line chart max y value
    final rawMax = isAllZero ? 2500.0 : weeklyCalories.reduce(max).toDouble();
    final maxYValue = ((rawMax / 500).ceil() * 500).toDouble();

    // Use 2 dummy spots if all values are zero, or else use the actual data points
    final spots = isAllZero
        ? [FlSpot(0, 0), FlSpot(6, 0)]
        : [for (int i = 0; i < weeklyCalories.length; i++) FlSpot(i.toDouble(), weeklyCalories[i].toDouble())];

    return Container(
      padding: AppStyles.kPaddSH16,
      height: AppStyles.kSize150,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxYValue,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          // Place green line on user's calorie target
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: userPlan?.calorieKcal ?? 0, color: Colors.green, strokeWidth: 2, dashArray: [6, 4])
            ],
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 34,
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final vm = context.read<WeeklyCalorieProgressViewModel>();
                  final dateFormat = DateFormat('MM/dd/yy');
                  final startDate = dateFormat.parse(vm.activeDates[WeeklyCalorieProgressDateSettings.startDate.key]!);
                  final endDate = dateFormat.parse(vm.activeDates[WeeklyCalorieProgressDateSettings.endDate.key]!);
                  final day = startDate.add(Duration(days: value.toInt()));

                  // Show labels on first, middle, and last day
                  if (value.toInt() == 0 ||
                      value.toInt() == (endDate.difference(startDate).inDays ~/ 2) ||
                      value.toInt() == endDate.difference(startDate).inDays) {
                    return Padding(
                      padding: AppStyles.kPaddOT12,
                      child: Text(
                        DateFormat('MM/dd').format(day),
                        style: _Styles.getChartBottomTitlesLabelTextStyle(context),
                      ),
                    );
                  }
                  return AppStyles.kEmptyWidget;
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: context.theme.colorScheme.secondary,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: context.theme.colorScheme.secondary.withAlpha(60)),
              // Show rounded dots on each points
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 6,
                  color: context.theme.colorScheme.secondary,
                  strokeWidth: 2,
                  strokeColor: context.theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],

          // Show visible tooltip
          showingTooltipIndicators: [
            for (int i = 0; i < spots.length; i++)
              ShowingTooltipIndicators([LineBarSpot(LineChartBarData(spots: spots), 0, spots[i])])
          ],

          // Visible tooltip style
          lineTouchData: LineTouchData(
            enabled: false,
            touchTooltipData: LineTouchTooltipData(
              fitInsideVertically: true,
              tooltipPadding: AppStyles.kPaddSV4H6,
              getTooltipColor: (_) => context.theme.colorScheme.primary,
              getTooltipItems: (spots) {
                return spots.map((spot) {
                  return LineTooltipItem(spot.y.toStringAsFixed(0), _Styles.getChartTooltipTextStyle(context));
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  // Weekly Calorie Progress Indicator Hint Column
  Widget getWeeklyCalorieProgressIndicatorHintColumn() {
    final userPlan = SharedPreferenceHandler().getPlan();
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        getProgressIndicatorHint(
          color: context.theme.colorScheme.secondary,
          label: S.current.calorieLabel,
          context: context,
        ),
        Row(
          children: [
            getProgressIndicatorHint(
              color: Colors.green,
              label: S.current.targetCalorieLabel,
              context: context,
            ),
            Text(
              ' (${userPlan?.calorieKcal ?? 0} ${NutritionUnit.kcal.label})',
              style: _Styles.getChartIndicatorHintTextStyle(context).copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ],
    );
  }

  // Progress Indicator Hint
  Widget getProgressIndicatorHint({
    required Color color,
    required String label,
    required BuildContext context,
  }) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [
        Container(
          width: 20,
          height: 3,
          decoration: _Styles.getProgressHintLineDecoration(context, color),
        ),
        Text(label, style: _Styles.getChartIndicatorHintTextStyle(context)),
      ],
    );
  }

  // Date Settings Container
  Widget getDateSettingsContainer() {
    return Container(
      padding: AppStyles.kPaddSV12H16,
      decoration: _Styles.getDateSettingsContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSelectDateLabel(),
          getSelectDateDesc(),
          AppStyles.kSizedBoxH24,
          getDateSettingsListView(),
        ],
      ),
    );
  }

  // Select Date Label
  Widget getSelectDateLabel() {
    return Text(S.current.selectDateLabel, style: _Styles.getSelectDateLabelTextStyle(context));
  }

  // Select Date Desc
  Widget getSelectDateDesc() {
    return Text(S.current.selectDateDesc, style: _Styles.getSelectDateDescLabelTextStyle(context));
  }

  // Date Settings List View
  Widget getDateSettingsListView() {
    final dates = context.select((WeeklyCalorieProgressViewModel vm) => vm.dates);

    return ListView.separated(
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final setting = weeklyCalorieProgressDate[index];
        return ProfileSettingsListTile(
          label: setting.label,
          value: dates[setting.key] ?? '',
          onTap: () => _onDatePickerPressed(setting),
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: AppStyles.kPaddSV6,
        child: Divider(color: context.theme.colorScheme.tertiaryFixedDim),
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

// * ----------------------------- Styles ----------------------------
class _Styles {
  // Chart Progress Container
  static BoxDecoration getChartContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Chart Header Label Text Style
  static TextStyle getChartHeaderLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Chart Value Label Text Style
  static TextStyle getChartValueLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Chart Desc Label Text Style
  static TextStyle getChartDescLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Chart Bottom Titles Label Text Style
  static TextStyle getChartBottomTitlesLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small);
  }

  // Chart Tooltip Text Style
  static TextStyle getChartTooltipTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Chart Indicator Hint Text Style
  static TextStyle getChartIndicatorHintTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraSmall);
  }

  // Progress Hint Line Decoration
  static BoxDecoration getProgressHintLineDecoration(BuildContext context, Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Date Settings Container Decoration
  static BoxDecoration getDateSettingsContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Select Date Label Text Style
  static TextStyle getSelectDateLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Select Date Desc Label Text Style
  static TextStyle getSelectDateDescLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }
}

enum WeeklyCalorieProgressDateSettings {
  startDate,
  endDate;

  String get key {
    switch (this) {
      case WeeklyCalorieProgressDateSettings.startDate:
        return 'startDate';
      case WeeklyCalorieProgressDateSettings.endDate:
        return 'endDate';
    }
  }
}

class WeeklyCalorieProgressDateModel {
  WeeklyCalorieProgressDateModel({
    required this.key,
    required this.label,
    required this.desc,
  });

  final String key;
  final String label;
  final String desc;
}

List<WeeklyCalorieProgressDateModel> weeklyCalorieProgressDate = [
  WeeklyCalorieProgressDateModel(
    key: WeeklyCalorieProgressDateSettings.startDate.key,
    label: S.current.startDateLabel,
    desc: S.current.startDateDesc,
  ),
  WeeklyCalorieProgressDateModel(
    key: WeeklyCalorieProgressDateSettings.endDate.key,
    label: S.current.endDateLabel,
    desc: S.current.endDateDesc,
  ),
];
