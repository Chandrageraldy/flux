import 'package:fl_chart/fl_chart.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/viewmodels/weight_progress_vm/weight_progress_view_model.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_tappable.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_with_desc.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

@RoutePage()
class WeightProgressPage extends StatelessWidget {
  const WeightProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => WeightProgressViewModel(), child: _WeightProgressPage());
  }
}

class _WeightProgressPage extends BaseStatefulPage {
  @override
  State<_WeightProgressPage> createState() => _WeightProgressPageState();
}

class _WeightProgressPageState extends BaseStatefulState<_WeightProgressPage> {
  bool _isNewestToOldest = true;

  @override
  bool hasDefaultPadding() => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWeightLogs();
    });
  }

  @override
  Widget body() {
    final isLoading = context.select((WeightProgressViewModel vm) => vm.isLoading);
    return Column(
      children: [
        getCustomAppBar(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _getWeightLogs,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: AppStyles.kPaddSH12,
                child: Column(
                  spacing: AppStyles.kSpac12,
                  children: [
                    if (isLoading) ...[
                      AppStyles.kEmptyWidget,
                      Skeleton(width: AppStyles.kDoubleInfinity, height: 245),
                      Skeleton(width: AppStyles.kDoubleInfinity, height: 140),
                    ] else ...[
                      AppStyles.kEmptyWidget,
                      getWeightProgressContainer(),
                      getWeightLogContainer(),
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

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _WeightProgressPageState {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _WeightProgressPageState {
  Future<void> _getWeightLogs() async {
    await tryCatch(context, () => context.read<WeightProgressViewModel>().getWeightLogs());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _WeightProgressPageState {
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
      title: S.current.weightProgressLabel,
      desc: S.current.weightProgressDesc,
    );
  }

  // Weight Progress Container
  Widget getWeightProgressContainer() {
    return Container(
      decoration: _Styles.getChartContainerDecoration(context),
      width: double.infinity,
      padding: AppStyles.kPaddSV12H12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac8,
        children: [
          getWeightProgressHeader(),
          getWeightProgressChart(),
          getWeightProgressIndicatorHintColumn(),
        ],
      ),
    );
  }

  // Weight Progress Header
  Widget getWeightProgressHeader() {
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
      ],
    );
  }

  // Weight Progress Chart
  Widget getWeightProgressChart() {
    final user = SharedPreferenceHandler().getUser();
    final bodyMetrics = user?.bodyMetrics;

    final weightLogs = context.select((WeightProgressViewModel vm) => vm.weightLogs);

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
  Widget getWeightProgressIndicatorHintColumn() {
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

  // Weight Log Container
  Widget getWeightLogContainer() {
    String filter = _isNewestToOldest ? S.current.newestToOldestLabel : S.current.oldestToNewestLabel;

    return Container(
      padding: AppStyles.kPaddSV12H16,
      decoration: _Styles.getWeightLogContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getWeightLogLabel(),
          getWeightLogDesc(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppStyles.kEmptyWidget,
              GestureDetector(
                onTap: () {
                  _setState(() {
                    _isNewestToOldest = !_isNewestToOldest;
                  });
                },
                child: Row(
                  spacing: AppStyles.kSpac4,
                  children: [
                    Text(filter, style: _Styles.getWeightLogFilterButtonLabelTextStyle(context)),
                    Icon(Icons.compare_arrows, size: AppStyles.kSize20, color: context.theme.colorScheme.secondary)
                  ],
                ),
              )
            ],
          ),
          AppStyles.kSizedBoxH24,
          getWeightLogListView(),
        ],
      ),
    );
  }

  // Weight Log Label
  Widget getWeightLogLabel() {
    return Text(S.current.weightLogLabel, style: _Styles.getWeightLogLabelTextStyle(context));
  }

  // Weight Log Desc
  Widget getWeightLogDesc() {
    return Text(S.current.weightLogDesc, style: _Styles.getWeightLogDescLabelTextStyle(context));
  }

  // Weight Log List View
  Widget getWeightLogListView() {
    final weightLogs = [];

    if (_isNewestToOldest) {
      weightLogs.addAll(context.select((WeightProgressViewModel vm) => vm.weightLogs));
    } else {
      weightLogs.addAll(context.select((WeightProgressViewModel vm) => vm.weightLogs).reversed.toList());
    }

    return ListView.separated(
      itemCount: weightLogs.length,
      itemBuilder: (context, index) {
        final log = weightLogs[index];
        return getWeightLogListTile(value: log.weight, date: log.createdAt);
      },
      separatorBuilder: (context, index) => Padding(
        padding: AppStyles.kPaddSV6,
        child: Divider(color: context.theme.colorScheme.tertiaryFixedDim),
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  // Weight Log List Tile
  Widget getWeightLogListTile({required int? value, required DateTime? date}) {
    return Container(
      color: context.theme.colorScheme.onPrimary,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('MM/dd/yyyy hh:mm a').format(date ?? DateTime.now()),
            style: Quicksand.regular.withSize(FontSizes.small),
          ),
          Text('$value ${Unit.kg.label}'),
        ],
      ),
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

  // Progress Hint Line Decoration
  static BoxDecoration getProgressHintLineDecoration(BuildContext context, Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Chart Indicator Hint Text Style
  static TextStyle getChartIndicatorHintTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraSmall);
  }

  // Log Weight Button Label Text Style
  static TextStyle getLogWeightButtonLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Weight Log Container Decoration
  static BoxDecoration getWeightLogContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Weight Log Label Text Style
  static TextStyle getWeightLogLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Weight Log Desc Label Text Style
  static TextStyle getWeightLogDescLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Weight Log Filter Button Label Text Style
  static TextStyle getWeightLogFilterButtonLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }
}
