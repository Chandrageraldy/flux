import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/virtual_pet_action_model/virtual_pet_action_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/overview_vm/overview_view_model.dart';
import 'package:flux/app/widgets/daily_goals_percent_indicator/daily_goals_percent_indicator.dart';
import 'package:flux/app/widgets/virtual_pet_action_button/virtual_pet_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => OverviewViewModel(), child: _OverviewPage());
  }
}

class _OverviewPage extends BaseStatefulPage {
  @override
  State<_OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends BaseStatefulState<_OverviewPage> with TickerProviderStateMixin {
  late AnimationController _petController;
  late AnimationController _confettiController;

  bool _isPlayingCrackedEggAnimation = false;
  bool _isShowingConfetti = false;

  @override
  bool hasDefaultPadding() => false;

  @override
  void initState() {
    super.initState();
    _petController = AnimationController(vsync: this);
    _confettiController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OverviewViewModel>().initialize();
    });
  }

  @override
  void dispose() {
    _petController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    final isLoading = context.select((OverviewViewModel vm) => vm.isLoading);
    final activeUserPet = context.select((OverviewViewModel vm) => vm.activeUserPet);

    if (activeUserPet.virtualPet == null) {
      return const SizedBox.shrink();
    }

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        children: [
          getCustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: AppStyles.kPaddOB20,
                child: Column(
                  children: [
                    AppStyles.kSizedBoxH12,
                    getIsometricRoomHeader(),
                    AppStyles.kSizedBoxH12,
                    getExperiencePointsContainer(),
                    AppStyles.kSizedBoxH12,
                    getIsometricRoomImage(),
                    AppStyles.kSizedBoxH12,
                    getActionRow(),
                    AppStyles.kSizedBoxH20,
                    getDailyGoalContainer(),
                    AppStyles.kSizedBoxH12,
                    getWeeklyCalorieProgressContainer(),
                    AppStyles.kSizedBoxH12,
                  ],
                ),
              ),
            ),
          ),
        ],
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

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _OverviewPageState {
  Future<void> _getActiveUserPet() async {
    await tryLoad(context, () => context.read<OverviewViewModel>().getActiveUserPet());
  }

  Future<void> _onRefresh() async {
    Future.wait([_getActiveUserPet(), _getUserEnergies(), _getDailyGoals(), _getLoggedFoodsBetweenDates()]);
  }

  Future<void> _getUserEnergies() async {
    await tryLoad(context, () => context.read<OverviewViewModel>().getUserEnergies());
  }

  Future<void> _getDailyGoals() async {
    await tryLoad(context, () => context.read<OverviewViewModel>().getDailyGoals());
  }

  Future<void> _getLoggedFoodsBetweenDates() async {
    await tryLoad(context, () => context.read<OverviewViewModel>().getLoggedFoodsBetweenDates());
  }

  List<double> getWeeklyCaloriesList() {
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

// * ---------------------------- Actions ----------------------------
extension _Actions on _OverviewPageState {
  Future<void> _onActionButtonPressed({
    required VirtualPetActionModel action,
    required UserEnergyModel userEnergy,
  }) async {
    final vm = context.read<OverviewViewModel>();

    if ((userEnergy.energies ?? 0) < action.energy) {
      WidgetUtils.showSnackBar(context, S.current.notEnoughEnergyMessage);
      return;
    }

    final previousLevel = vm.activeUserPet.getCurrentLevel();
    await tryCatch(context, () => vm.updateCurrentExp(addedExp: action.exp, energySpent: action.energy));
    final newLevel = vm.activeUserPet.getCurrentLevel();

    if (newLevel > previousLevel) {
      _setState(() {
        _isShowingConfetti = true;
      });

      if (newLevel == 2) {
        _setState(() {
          _isPlayingCrackedEggAnimation = true;
          _petController.reset();
        });
      }
    }
  }

  Future<void> _onClaimPressed({required int goalId, required int energyReward}) async {
    await tryCatch(
      context,
      () => context.read<OverviewViewModel>().claimReward(goalId: goalId, energyReward: energyReward),
    );
  }

  void _onShopPressed() {
    context.router.push(VirtualPetShopRoute()).then(
      (value) {
        if (value == true) {
          _onRefresh();
        }
      },
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _OverviewPageState {
  // Custom App Bar
  Widget getCustomAppBar() {
    return Container(
      padding: AppStyles.kPaddSV8,
      decoration: _Styles.getCustomAppBarContainerDecoration(context),
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Row(
          children: [
            Expanded(flex: 1, child: AppStyles.kEmptyWidget),
            Column(
              children: [
                Row(
                  spacing: AppStyles.kSpac4,
                  children: [
                    // if (image != null) Image.asset(image!, width: AppStyles.kSize20, height: AppStyles.kSize20),
                    Text('Overview', style: _Styles.getCustomAppBarTitleTextStyle()),
                  ],
                ),
                Text('Virtual Pets', style: _Styles.getCustomAppBarDescTextStyle(context)),
              ],
            ),
            Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: AppStyles.kEmptyWidget))
          ],
        ),
      ),
    );
  }

  // Weekly Calorie Progress Container
  Widget getWeeklyCalorieProgressContainer() {
    final weeklyCalories = getWeeklyCaloriesList();

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
            Text(S.current.weeklyCalorieProgressLabel, style: _Styles.getChartHeaderLabelTextStyle(context)),
            Row(
              spacing: AppStyles.kSpac4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${average.toStringAsFixed(1)} ${NutritionUnit.kcal.label}',
                  style: _Styles.getChartValueLabelTextStyle(context),
                ),
                Padding(
                  padding: AppStyles.kPaddOB3,
                  child: Text(
                    S.current.averageLabel,
                    style: _Styles.getChartDescLabelTextStyle(context),
                  ),
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
  Widget getWeeklyCalorieProgressIndicatorHintColumn() {
    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        getWeeklyCalorieProgressIndicatorHint(
            color: context.theme.colorScheme.secondary, label: S.current.calorieLabel),
        getWeeklyCalorieProgressIndicatorHint(color: Colors.green, label: S.current.targetCalorieLabel),
      ],
    );
  }

  // Weekly Calorie Progress Indicator Hint
  Widget getWeeklyCalorieProgressIndicatorHint({required Color color, required String label}) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [
        Container(
          width: 20, // length of the line
          height: 3, // thickness of the line
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1.5), // optional, for slightly rounded edges
          ),
        ),
        Text(label, style: _Styles.getChartIndicatorHintTextStyle(context)),
      ],
    );
  }

  // Isometric Room Header
  Widget getIsometricRoomHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [getEnergiesContainer(), getHeaderActionRow()],
    );
  }

  // Energies Container
  Widget getEnergiesContainer() {
    final userEnergy = context.select((OverviewViewModel vm) => vm.userEnergy);
    return Container(
      decoration: _Styles.getEnergiesContainerDecoration(context),
      padding: AppStyles.kPaddSV6H12,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          Image.asset(ImagePath.energy, height: AppStyles.kSize16),
          Text('${userEnergy.energies}', style: _Styles.getEnergyLabelTextStyle(context)),
        ],
      ),
    );
  }

  // Header Action Row
  Widget getHeaderActionRow() {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [getShopButton(), getHelpButton()],
    );
  }

  // Help Button
  Widget getHelpButton() {
    return Container(
      decoration: _Styles.getHeaderButtonContainerDecoration(context),
      height: AppStyles.kSize32,
      width: AppStyles.kSize32,
      child: Center(child: FaIcon(FontAwesomeIcons.question, size: AppStyles.kSize16)),
    );
  }

  // Shop Button
  Widget getShopButton() {
    return GestureDetector(
      onTap: _onShopPressed,
      child: Container(
        decoration: _Styles.getHeaderButtonContainerDecoration(context),
        height: AppStyles.kSize32,
        width: AppStyles.kSize32,
        child: Center(child: FaIcon(FontAwesomeIcons.paw, size: AppStyles.kSize16)),
      ),
    );
  }

  // Isometric Room Image
  Widget getIsometricRoomImage() {
    return Stack(
      children: [Image.asset(ImagePath.vpBackground), getAnimations()],
    );
  }

  // Animations
  Widget getAnimations() {
    final activeUserPet = context.select((OverviewViewModel vm) => vm.activeUserPet);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: activeUserPet.getCurrentLevel() == 1 || _isPlayingCrackedEggAnimation ? 50 : 10,
      left: 0,
      right: 0,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isShowingConfetti) getConfettiAnimation(),
            getVirtualPetAnimation(activeUserPet: activeUserPet)
          ],
        ),
      ),
    );
  }

  // Confetti Animation
  Widget getConfettiAnimation() {
    return Positioned.fill(
      // Ignore Confetti touch events
      child: IgnorePointer(
        child: Center(
          child: Transform.scale(
            scale: 3.0,
            child: Lottie.network(
              AnimationUrl.confetti,
              repeat: false,
              controller: _confettiController,
              onLoaded: (composition) {
                _confettiController
                  ..duration = composition.duration
                  ..reset()
                  ..forward().whenComplete(() {
                    _setState(() => _isShowingConfetti = false);
                  });
              },
            ),
          ),
        ),
      ),
    );
  }

  // Virtual Pet Animation
  Widget getVirtualPetAnimation({required ActiveUserPetModel activeUserPet}) {
    String petAnimationUrl =
        _isPlayingCrackedEggAnimation ? AnimationUrl.crackedEgg : activeUserPet.getPetAnimationUrl();
    return GestureDetector(
      onTap: () {
        if (!_isPlayingCrackedEggAnimation) {
          _petController
            ..reset()
            ..forward();
        }
      },
      child: Lottie.network(
        petAnimationUrl,
        width: AppStyles.kSize150,
        controller: _petController,
        onLoaded: (composition) {
          _petController.duration = composition.duration;
          if (_isPlayingCrackedEggAnimation) {
            _petController.forward().whenComplete(() {
              _setState(() {
                _isPlayingCrackedEggAnimation = false;
              });
            });
          }
        },
        errorBuilder: (context, error, stackTrace) => AppStyles.kEmptyWidget,
      ),
    );
  }

  // Experience Points Container
  Widget getExperiencePointsContainer() {
    final activeUserPet = context.select((OverviewViewModel vm) => vm.activeUserPet);
    return Container(
      decoration: _Styles.getExperiencePointsContainerDecoration(context),
      child: getExperiencePointsContent(activeUserPet: activeUserPet),
    );
  }

  // Experience Points Content
  Widget getExperiencePointsContent({required ActiveUserPetModel activeUserPet}) {
    final level = activeUserPet.getCurrentLevel();
    return Column(
      children: [
        Padding(
          padding: AppStyles.kPaddSV4H8,
          child: Row(
            spacing: AppStyles.kSpac4,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(activeUserPet.virtualPet?.name ?? '', style: _Styles.getVirtualPetNameLabelTextStyle(context)),
              Text('Lv. $level', style: _Styles.getLevelLabelTextStyle(context)),
            ],
          ),
        ),
        getExperiencePointsProgressIndicator(activeUserPet: activeUserPet)
      ],
    );
  }

  // Experience Points Progress Indicator
  Widget getExperiencePointsProgressIndicator({required ActiveUserPetModel activeUserPet}) {
    return Container(
      decoration: _Styles.getExperiencePointsProgressIndicatorContainerDecoration(context),
      padding: AppStyles.kPaddSV4H8,
      child: LinearPercentIndicator(
        percent: activeUserPet.getLevelProgress(),
        backgroundColor: context.theme.colorScheme.tertiary,
        progressColor: context.theme.colorScheme.secondary,
        animation: true,
        animateFromLastPercent: true,
        animateToInitialPercent: false,
        padding: AppStyles.kPadd0,
        barRadius: Radius.circular(AppStyles.kSpac20),
        lineHeight: 8,
        trailing: Padding(
          padding: AppStyles.kPaddOL8,
          child: Text(activeUserPet.getExpProgressText(), style: _Styles.getExperiencePointsLabelTextStyle(context)),
        ),
      ),
    );
  }

  // Action Row
  Widget getActionRow() {
    final userEnergy = context.select((OverviewViewModel vm) => vm.userEnergy);
    final isUpdatingCurrentExp = context.select((OverviewViewModel vm) => vm.isUpdatingCurrentExp);
    return Row(
      spacing: AppStyles.kSpac8,
      children: virtualPetActions
          .map(
            (action) => VirtualPetActionButton(
              action: action,
              userEnergy: userEnergy,
              isUpdatingCurrentExp: isUpdatingCurrentExp,
              onActionButtonPressed: _onActionButtonPressed,
            ),
          )
          .toList(),
    );
  }

// Daily Goal Container
  Widget getDailyGoalContainer() {
    final dailyGoals = context.select((OverviewViewModel vm) => vm.dailyGoals);
    return Container(
      decoration: _Styles.getDailyGoalContainerDecoration(context),
      padding: AppStyles.kPaddSV10H8,
      child: Column(
        spacing: AppStyles.kSpac16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: AppStyles.kSpac4,
            children: [
              Icon(Icons.calendar_month, size: AppStyles.kSize16),
              Text(
                S.current.dailyGoalsLabel,
                style: _Styles.getDailyGoalLabelTextStyle(context),
              ),
            ],
          ),
          ...dailyGoals.map((dailyGoal) {
            return DailyGoalsPercentIndicator(
              dailyGoal: dailyGoal,
              onClaimPressed: _onClaimPressed,
            );
          }),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Experience Points Container Decoration
  static BoxDecoration getExperiencePointsContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, 2)),
      ],
    );
  }

  // Experience Points Label Text Style
  static TextStyle getExperiencePointsLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Virtual Pet Name Label Text Style
  static TextStyle getVirtualPetNameLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large);
  }

  // Level Label Text Style
  static TextStyle getLevelLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall);
  }

  // Energies Container Decoration
  static BoxDecoration getEnergiesContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, 2)),
      ],
    );
  }

  // Header Button Container Decoration
  static BoxDecoration getHeaderButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, 2)),
      ],
    );
  }

  // Daily Goal Label Text Style
  static TextStyle getDailyGoalLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Daily Goal Container Decoration
  static BoxDecoration getDailyGoalContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, 2)),
      ],
    );
  }

  // Energy Label Text Style
  static TextStyle getEnergyLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }

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

  // Experience Points Progress Indicator Container Decoration
  static BoxDecoration getExperiencePointsProgressIndicatorContainerDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: AppStyles.kRadOBL10BR10,
      color: context.theme.colorScheme.primary,
    );
  }

  // Custom App Bar Title Label Text Style
  static getCustomAppBarTitleTextStyle() {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Custom App Bar Desc Label Text Style
  static getCustomAppBarDescTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(
          height: 1,
          color: context.theme.colorScheme.onTertiaryContainer,
        );
  }

  // Custom App Bar Container Decoration
  static BoxDecoration getCustomAppBarContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL10BR10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }
}
