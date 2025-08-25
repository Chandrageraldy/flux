import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/quick_prompt_model/quick_prompt_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/virtual_pet_action_model/virtual_pet_action_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/progress_vm/progress_view_model.dart';
import 'package:flux/app/widgets/daily_goals_percent_indicator/daily_goals_percent_indicator.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:flux/app/widgets/virtual_pet_action_button/virtual_pet_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ProgressViewModel(), child: _ProgressPage());
  }
}

class _ProgressPage extends BaseStatefulPage {
  @override
  State<_ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends BaseStatefulState<_ProgressPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  late AnimationController _petController;
  late AnimationController _confettiController;

  bool _isPlayingCrackedEggAnimation = false;
  bool _isShowingConfetti = false;
  bool _isSendMessageEnabled = false;

  @override
  void initState() {
    super.initState();
    _petController = AnimationController(vsync: this);
    _confettiController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressViewModel>().initialize();
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
    final isLoading = context.select((ProgressViewModel vm) => vm.isLoading);
    final activeUserPet = context.select((ProgressViewModel vm) => vm.activeUserPet);

    if (activeUserPet.virtualPet == null) {
      return const SizedBox.shrink();
    }

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: AppStyles.kPaddOB20,
          child: Column(
            children: [
              AppStyles.kSizedBoxH12,
              getChiaChatbotContainer(),
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
              getWeeklyCalorieProgressChart(),
              AppStyles.kSizedBoxH12,
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

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ProgressPageState {
  Future<void> _getActiveUserPet() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getActiveUserPet());
  }

  Future<void> _onRefresh() async {
    Future.wait([_getActiveUserPet(), _getUserEnergies(), _getDailyGoals(), _getLoggedFoodsBetweenDates()]);
  }

  Future<void> _getUserEnergies() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getUserEnergies());
  }

  Future<void> _getDailyGoals() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getDailyGoals());
  }

  Future<void> _getLoggedFoodsBetweenDates() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getLoggedFoodsBetweenDates());
  }

  List<double> getWeeklyCalories() {
    final loggedFoods = context.select((ProgressViewModel vm) => vm.loggedFoodsBetweenDates);

    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6)); // 7-day range

    // Map for daily totals
    final Map<String, double> dailyCalories = {};

    for (int i = 0; i < 7; i++) {
      final day = start.add(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(day);
      dailyCalories[key] = 0.0;
    }

    for (final food in loggedFoods) {
      if (food.loggedAt == null || food.calorieKcal == null) continue;

      final dateKey = DateFormat('yyyy-MM-dd').format(food.loggedAt!);
      if (dailyCalories.containsKey(dateKey)) {
        dailyCalories[dateKey] = (dailyCalories[dateKey] ?? 0) + food.calorieKcal!;
      }
    }

    // Keep values in correct order (Mon → Sun)
    return dailyCalories.values.toList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProgressPageState {
  Future<void> _onActionButtonPressed({
    required VirtualPetActionModel action,
    required UserEnergyModel userEnergy,
  }) async {
    final vm = context.read<ProgressViewModel>();

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
      () => context.read<ProgressViewModel>().claimReward(goalId: goalId, energyReward: energyReward),
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

  void _onSendMessage() {
    final prompt = _formKey.currentState!.fields[FormFields.prompt.name]!.value as String;

    _formKey.currentState?.fields[FormFields.prompt.name]?.didChange('');

    context.router.push(ChiaChatbotNavigatorRoute(children: [ChiaChatbotLoadingRoute(initialPrompt: prompt)]));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProgressPageState {
  // Chia Chatbot Container
  Widget getChiaChatbotContainer() {
    return Container(
      decoration: _Styles.getChiaChatbotContainerDecoration(context),
      padding: AppStyles.kPaddSV12H12,
      child: Column(
        spacing: AppStyles.kSpac8,
        children: [
          getChiaChatbotTextFieldRow(),
          getQuickPromptScrollableRow(),
          getQuickPromptButton(),
        ],
      ),
    );
  }

  // Chia Chatbot Text Field Row
  Widget getChiaChatbotTextFieldRow() {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [getChiaChatbotTextField(), getChatbotSendButton()],
    );
  }

  // Chia Chatbot Text Field
  Widget getChiaChatbotTextField() {
    return FormBuilder(
      key: _formKey,
      child: Expanded(
        child: AppTextFormField(
          field: FormFields.prompt,
          validator: null,
          placeholder: S.current.chatWithChiaAILabel,
          height: AppStyles.kSize40,
          hasBorder: true,
          borderColor: context.theme.colorScheme.tertiary,
          backgroundColor: context.theme.colorScheme.onPrimary,
          showClearIcon: _isSendMessageEnabled,
          icon: FaIcon(FontAwesomeIcons.paperPlane, size: AppStyles.kSize14),
          onClear: () {
            _formKey.currentState?.fields[FormFields.prompt.name]?.didChange('');
          },
          onChanged: (value) {
            _setState(() {
              _isSendMessageEnabled = value?.isNotEmpty ?? false;
            });
          },
        ),
      ),
    );
  }

  // Chia Chatbot Send Button
  Widget getChatbotSendButton() {
    return GestureDetector(
      onTap: _isSendMessageEnabled ? _onSendMessage : null,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: _isSendMessageEnabled
            ? context.theme.colorScheme.primary
            : context.theme.colorScheme.primary.withOpacity(0.5),
        child: Icon(
          Icons.keyboard_return_outlined,
          color: context.theme.colorScheme.onPrimary,
          size: AppStyles.kSize16,
        ),
      ),
    );
  }

  // Quick Prompt Scrollable Row
  Widget getQuickPromptScrollableRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: quickPromptsForProgressPage
            .map(
              (quickPrompt) => Padding(
                padding: EdgeInsets.only(right: AppStyles.kSpac8),
                child: getQuickPromptContainer(
                  prompt: quickPrompt.prompt,
                  icon: quickPrompt.icon,
                  iconColor: quickPrompt.iconColor,
                  label: quickPrompt.label,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Quick Prompt Container
  Widget getQuickPromptContainer({required String prompt, IconData? icon, Color? iconColor, String? label}) {
    return GestureDetector(
      onTap: () {
        _formKey.currentState?.fields[FormFields.prompt.name]?.didChange(prompt);
      },
      child: Container(
        padding: AppStyles.kPaddSV10H12,
        decoration: _Styles.getQuickPromptContainerDecoration(context),
        child: Row(
          spacing: AppStyles.kSpac8,
          children: [
            FaIcon(icon, color: iconColor, size: AppStyles.kSize16),
            Text(label ?? '', style: _Styles.getQuickPromptLabelTextStyle(context)),
          ],
        ),
      ),
    );
  }

  // Quick Prompt Button
  Widget getQuickPromptButton() {
    return GestureDetector(
      onTap: () {
        context.router.push(ChiaChatbotNavigatorRoute(children: [ChiaChatbotLoadingRoute()]));
      },
      child: Container(
        width: AppStyles.kDoubleInfinity,
        decoration: _Styles.getChiaChatbotButtonDecoration(context),
        padding: AppStyles.kPaddSV16,
        child: Center(child: Text(S.current.startChatLabel, style: _Styles.getChiaChatbotButtonLabel(context))),
      ),
    );
  }

  // Weekly Calorie Progress Chart
  Widget getWeeklyCalorieProgressChart() {
    final weeklyCalories = getWeeklyCalories();
    final allZero = weeklyCalories.every((c) => c == 0);

    // Compute dynamic maxY (cast to double)
    final rawMax = allZero ? 2500.0 : weeklyCalories.reduce((a, b) => a > b ? a : b).toDouble();
    final maxYValue = ((rawMax / 500).ceil() * 500).toDouble(); // round to 500 steps

    // Use dummy spots if no data
    final spots = allZero
        ? [FlSpot(0, 0), FlSpot(6, 0)]
        : [
            for (int i = 0; i < weeklyCalories.length; i++) FlSpot(i.toDouble(), weeklyCalories[i].toDouble()),
          ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.theme.colorScheme.tertiaryFixedDim,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      width: double.infinity,
      padding: AppStyles.kPaddSH28,
      child: SizedBox(
        height: 150,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: maxYValue,

            // ✅ Horizontal grid lines (solid)
            gridData: FlGridData(
              show: false,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: context.theme.colorScheme.tertiary,
                  strokeWidth: 1,
                );
              },
            ),

            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: 2600,
                  color: Colors.green,
                  strokeWidth: 2,
                  dashArray: [6, 4],
                ),
              ],
            ),

            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: const SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 34, // ⬅️ add extra space for labels
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final now = DateTime.now();
                    final start = now.subtract(const Duration(days: 6));
                    final day = start.add(Duration(days: value.toInt()));

                    if (value == 0 || value == 3 || value == 6) {
                      return Padding(
                        padding: AppStyles.kPaddOT12,
                        child: Text(
                          DateFormat('MM/dd').format(day),
                          style: Quicksand.medium.withSize(FontSizes.small),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: const SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: const SideTitles(showTitles: false),
              ),
            ),

            borderData: FlBorderData(
              show: false,
            ),

            // ✅ Always visible indicators
            showingTooltipIndicators: [
              for (int i = 0; i < spots.length; i++)
                ShowingTooltipIndicators([
                  LineBarSpot(
                    LineChartBarData(spots: spots),
                    0,
                    spots[i],
                  ),
                ])
            ],

            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blueAccent,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blueAccent.withOpacity(0.2),
                ),
                // ✅ Rounded dots
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                    radius: 6,
                    color: Colors.blueAccent,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  ),
                ),
              ),
            ],

            // ✅ Fixed tooltip labels above each point
            lineTouchData: LineTouchData(
              enabled: false, // disable touch interaction
              touchTooltipData: LineTouchTooltipData(
                fitInsideVertically: true, // 🔥 keeps tooltips within chart bounds
                tooltipPadding: AppStyles.kPaddSV4H6,
                getTooltipColor: (_) => context.theme.colorScheme.primary,
                getTooltipItems: (spots) {
                  return spots.map((spot) {
                    return LineTooltipItem(
                      spot.y.toStringAsFixed(0), // calorie value
                      Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: Colors.white),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
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
    final userEnergy = context.select((ProgressViewModel vm) => vm.userEnergy);
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
    final activeUserPet = context.select((ProgressViewModel vm) => vm.activeUserPet);
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
    final activeUserPet = context.select((ProgressViewModel vm) => vm.activeUserPet);
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
      decoration: BoxDecoration(
        borderRadius: AppStyles.kRadOBL10BR10,
        color: context.theme.colorScheme.primary,
      ),
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
    final userEnergy = context.select((ProgressViewModel vm) => vm.userEnergy);
    final isUpdatingCurrentExp = context.select((ProgressViewModel vm) => vm.isUpdatingCurrentExp);
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
    final dailyGoals = context.select((ProgressViewModel vm) => vm.dailyGoals);
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

  // Chia Chatbot Container Decoration
  static BoxDecoration getChiaChatbotContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, 2)),
      ],
    );
  }

  // Quick Prompt Container Decoration
  static BoxDecoration getQuickPromptContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: AppColors.transparentColor,
      borderRadius: AppStyles.kRad100,
      border: Border.all(color: context.theme.colorScheme.tertiary, width: 0.5),
    );
  }

  // Quick Prompt Label Text Style
  static TextStyle getQuickPromptLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withCustomSize(11);
  }

  // Chia Chatbot Button Label Text Style
  static TextStyle getChiaChatbotButtonLabel(BuildContext context) {
    return Quicksand.semiBold.withCustomSize(11).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Chia Chatbot Button Decoration
  static BoxDecoration getChiaChatbotButtonDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      borderRadius: AppStyles.kRad100,
    );
  }
}
