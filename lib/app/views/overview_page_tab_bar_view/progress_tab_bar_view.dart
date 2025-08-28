import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/viewmodels/overview_vm/overview_view_model.dart';
import 'package:flux/app/widgets/skeleton/progress_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProgressTabBarView extends StatelessWidget {
  const ProgressTabBarView({super.key, required this.onProgressRefresh, required this.isLoading});

  final VoidCallback onProgressRefresh;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSH12,
      child: RefreshIndicator(
        onRefresh: () async {
          onProgressRefresh();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            spacing: AppStyles.kSpac12,
            children: [
              if (isLoading) ...[
                ProgressSkeleton()
              ] else ...[
                AppStyles.kEmptyWidget,
                getWeeklyCalorieProgressContainer(context: context),
                getWeightProgressContainer(context: context),
                AppStyles.kEmptyWidget,
              ]
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on ProgressTabBarView {
  void _onWeeklyCalorieProgressPressed({required BuildContext context}) {
    context.router.push(WeeklyCalorieProgressRoute());
  }

  void _onWeightProgressPressed({required BuildContext context}) {
    context.router.push(WeightProgressRoute());
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on ProgressTabBarView {
  List<double> getWeeklyCaloriesList({required BuildContext context}) {
    final loggedFoods = context.select((OverviewViewModel vm) => vm.loggedFoodsBetweenDates);

    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6)); // Today and 6 days before (1 week)

    final Map<String, double> dailyCalories = {};

    // Generate {2025-08-20: 0.0, ...... , Today's Date: 0.0}
    for (int i = 0; i < 7; i++) {
      final day = start.add(Duration(days: i));
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

    // return a list of daily calorie intakes for the week
    return dailyCalories.values.toList();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ProgressTabBarView {
  // Weekly Calorie Progress Container
  Widget getWeeklyCalorieProgressContainer({required BuildContext context}) {
    final weeklyCalories = getWeeklyCaloriesList(context: context);
    return GestureDetector(
      onTap: () => _onWeeklyCalorieProgressPressed(context: context),
      child: Container(
        decoration: _Styles.getChartContainerDecoration(context),
        width: double.infinity,
        padding: AppStyles.kPaddSV12H12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac8,
          children: [
            getWeeklyCalorieProgressHeader(weeklyCalories: weeklyCalories, context: context),
            getWeeklyCalorieProgressChart(weeklyCalories: weeklyCalories, context: context),
            getWeeklyCalorieProgressIndicatorHintColumn(context: context),
          ],
        ),
      ),
    );
  }

  // Weekly Calorie Progress Header
  Widget getWeeklyCalorieProgressHeader({required List<double> weeklyCalories, required BuildContext context}) {
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
        FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kSize16)
      ],
    );
  }

  // Weekly Calorie Progress Chart
  Widget getWeeklyCalorieProgressChart({required List<double> weeklyCalories, required BuildContext context}) {
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
                reservedSize: 34, // sizing
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final now = DateTime.now();
                  final start = now.subtract(Duration(days: 6));
                  final day = start.add(Duration(days: value.toInt()));

                  // Show dates on only the first, fourth, and last day
                  if (value == 0 || value == 3 || value == 6) {
                    return Padding(
                        padding: AppStyles.kPaddOT12,
                        child: Text(DateFormat('MM/dd').format(day),
                            style: _Styles.getChartBottomTitlesLabelTextStyle(context)));
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
  Widget getWeeklyCalorieProgressIndicatorHintColumn({required BuildContext context}) {
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

  // Weight Progress Container
  Widget getWeightProgressContainer({required BuildContext context}) {
    return GestureDetector(
      onTap: () => _onWeightProgressPressed(context: context),
      child: Container(
        decoration: _Styles.getChartContainerDecoration(context),
        width: double.infinity,
        padding: AppStyles.kPaddSV12H12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac8,
          children: [
            getWeightProgressHeader(context: context),
            getWeightProgressChart(context: context),
            getWeightProgressIndicatorHintColumn(context: context),
          ],
        ),
      ),
    );
  }

  // Weight Progress Header
  Widget getWeightProgressHeader({required BuildContext context}) {
    final user = SharedPreferenceHandler().getUser();
    final bodyMetrics = user?.bodyMetrics;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.weightProgressLabel.toUpperCase(), style: _Styles.getChartHeaderLabelTextStyle(context)),
            Row(
              spacing: AppStyles.kSpac4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${bodyMetrics?.goal?.capitalize()}', style: _Styles.getChartValueLabelTextStyle(context)),
                Padding(
                  padding: AppStyles.kPaddOB3,
                  child: Text(S.current.weightGoalLabel, style: _Styles.getChartDescLabelTextStyle(context)),
                ),
              ],
            ),
          ],
        ),
        FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kSize16)
      ],
    );
  }

  Widget getWeightProgressChart({required BuildContext context}) {
    final user = SharedPreferenceHandler().getUser();
    final bodyMetrics = user?.bodyMetrics;

    final weightLogs = context.select((OverviewViewModel vm) => vm.weightLogs);

    // Use the actual data points
    final spots = List.generate(weightLogs.length, (i) {
      return FlSpot(i.toDouble(), weightLogs[i].weight?.toDouble() ?? 0);
    });

    // Get minimum and maximum weight values for the line chart min and max y values
    final minYvalue = (weightLogs.map((e) => e.weight).reduce((a, b) => a! < b! ? a : b)! - 2).toDouble();
    final maxYvalue = (weightLogs.map((e) => e.weight).reduce((a, b) => a! > b! ? a : b)! + 2).toDouble();

    return Container(
      padding: AppStyles.kPaddSH16,
      height: AppStyles.kSize150,
      child: LineChart(
        LineChartData(
          minY: minYvalue,
          maxY: maxYvalue,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),

          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: (double.tryParse(bodyMetrics?.targetWeight ?? '0') ?? 0.0),
                color: Colors.green,
                strokeWidth: 2,
                dashArray: [6, 4],
              )
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
                  final index = value.toInt();
                  final log = weightLogs[index];
                  return Padding(
                    padding: AppStyles.kPaddOT12,
                    child: Text(
                      DateFormat('MM/dd').format(log.createdAt!),
                      style: _Styles.getChartBottomTitlesLabelTextStyle(context),
                    ),
                  );
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
              belowBarData: BarAreaData(
                show: true,
                color: context.theme.colorScheme.secondary.withAlpha(60),
              ),
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
                  return LineTooltipItem(
                    '${spot.y.toStringAsFixed(1)} ${Unit.kg.label}',
                    _Styles.getChartTooltipTextStyle(context),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  // Weight Progress Indicator Hint Column
  Widget getWeightProgressIndicatorHintColumn({required BuildContext context}) {
    final user = SharedPreferenceHandler().getUser();
    final bodyMetrics = user?.bodyMetrics;

    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        getProgressIndicatorHint(
          color: context.theme.colorScheme.secondary,
          label: S.current.weightLabel,
          context: context,
        ),
        Row(
          children: [
            getProgressIndicatorHint(
              color: Colors.green,
              label: S.current.targetWeightLabel,
              context: context,
            ),
            Text(
              ' (${bodyMetrics?.targetWeight ?? 0} ${Unit.kg.label})',
              style: _Styles.getChartIndicatorHintTextStyle(context).copyWith(fontStyle: FontStyle.italic),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                context.router.push(PersonalDetailsRoute());
              },
              child: Text(S.current.logWeightLabel, style: _Styles.getLogWeightButtonLabelTextStyle(context)),
            )
          ],
        ),
      ],
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
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

  // Chart Bottom Titles Label Text Style
  static TextStyle getChartBottomTitlesLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small);
  }

  // Chart Tooltip Text Style
  static TextStyle getChartTooltipTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onPrimary);
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

  // Log Weight Button Label Text Style
  static TextStyle getLogWeightButtonLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }
}
