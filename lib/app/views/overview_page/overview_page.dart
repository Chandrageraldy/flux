import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/virtual_pet_action_model/virtual_pet_action_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/overview_vm/overview_view_model.dart';
import 'package:flux/app/views/overview_page_tab_bar_view/progress_tab_bar_view.dart';
import 'package:flux/app/views/overview_page_tab_bar_view/virtual_pet_tab_bar_view.dart';
import 'package:lottie/lottie.dart';

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

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [getCustomAppBar(), getTabBarView()],
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

  Future<void> _onProgressRefresh() async {
    Future.wait([_getLoggedFoodsBetweenDates()]);
  }

  Future<void> _onVirtualPetRefresh() async {
    Future.wait([_getActiveUserPet(), _getUserEnergies(), _getDailyGoals()]);
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

  void _onLoadedConfettiAnimation(LottieComposition composition) {
    _confettiController
      ..duration = composition.duration
      ..reset()
      ..forward().whenComplete(
        () {
          _setState(() => _isShowingConfetti = false);
        },
      );
  }

  void _onLoadedPetAnimation(LottieComposition composition) {
    _petController.duration = composition.duration;
    if (_isPlayingCrackedEggAnimation) {
      _petController.forward().whenComplete(() {
        _setState(() {
          _isPlayingCrackedEggAnimation = false;
        });
      });
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _OverviewPageState {
  Future<void> _onPetActionButtonPressed({
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
          _onVirtualPetRefresh();
        }
      },
    );
  }

  void _onAddActionPressed() {
    context.router.push(LoggingSelectionRoute());
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
        child: Column(
          spacing: AppStyles.kSpac12,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: AppStyles.kSpac4,
                      children: [
                        Text(S.current.overviewLabel, style: _Styles.getCustomAppBarTitleTextStyle()),
                      ],
                    ),
                    Text(S.current.progressLabel, style: _Styles.getCustomAppBarDescTextStyle(context)),
                  ],
                ),
                getAddActionButton()
              ],
            ),
            getTabBarContainer()
          ],
        ),
      ),
    );
  }

  // Tab Bar View
  Widget getTabBarView() {
    return Expanded(
      child: TabBarView(
        children: [getProgressTabBarView(), getVirtualPetTabBarView()],
      ),
    );
  }

  // Tab Bar View -> "Progress"
  Widget getProgressTabBarView() {
    return ProgressTabBarView(onProgressRefresh: _onProgressRefresh);
  }

  // Tab Bar View -> "Virtual Pet"
  Widget getVirtualPetTabBarView() {
    return VirtualPetTabBarView(
      onVirtualPetRefresh: _onVirtualPetRefresh,
      onShopPressed: _onShopPressed,
      onPetActionButtonPressed: _onPetActionButtonPressed,
      onClaimPressed: _onClaimPressed,
      petController: _petController,
      confettiController: _confettiController,
      isPlayingCrackedEggAnimation: _isPlayingCrackedEggAnimation,
      isShowingConfetti: _isShowingConfetti,
      onLoadedConfettiAnimation: _onLoadedConfettiAnimation,
      onLoadedPetAnimation: _onLoadedPetAnimation,
    );
  }

  // Tabs Container
  Widget getTabBarContainer() {
    return Container(
      height: AppStyles.kSize26,
      decoration: _Styles.getTabBarContainerDecoration(context),
      child: TabBar(
        indicator: _Styles.getTabBarIndicatorDecoration(context),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: context.theme.colorScheme.onPrimary,
        unselectedLabelColor: context.theme.colorScheme.onTertiary,
        labelStyle: Quicksand.medium.withSize(FontSizes.small),
        tabs: [Tab(text: S.current.progressLabel), Tab(text: S.current.virtualPetLabel)],
      ),
    );
  }

  // Add Action Button
  Widget getAddActionButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _onAddActionPressed,
        child: Icon(Icons.add, size: AppStyles.kSize26, color: context.theme.colorScheme.primary),
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
    return Quicksand.medium
        .withSize(FontSizes.extraSmall)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
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

  // Tab Bar Container Decoration
  static BoxDecoration getTabBarContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Tab Bar Indicator Decoration
  static BoxDecoration getTabBarIndicatorDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      borderRadius: AppStyles.kRad100,
    );
  }
}
