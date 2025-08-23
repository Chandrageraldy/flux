import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/virtual_pet_action_model/virtual_pet_action_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/progress_vm/progress_view_model.dart';
import 'package:flux/app/widgets/daily_goals_percent_indicator/daily_goals_percent_indicator.dart';
import 'package:flux/app/widgets/virtual_pet_action_button/virtual_pet_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  late AnimationController _petController;
  late AnimationController _confettiController;

  bool _isPlayingCrackedEggAnimation = false;
  bool _isShowingConfetti = false;

  @override
  void initState() {
    super.initState();
    _petController = AnimationController(vsync: this);
    _confettiController = AnimationController(vsync: this);
    initialize();
  }

  @override
  void dispose() {
    _petController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: AppStyles.kPaddOB20,
          child: Column(
            children: [
              getIsometricRoomHeader(),
              AppStyles.kSizedBoxH12,
              getExperiencePointsContainer(),
              AppStyles.kSizedBoxH12,
              getIsometricRoomImage(),
              AppStyles.kSizedBoxH12,
              getActionRow(),
              AppStyles.kSizedBoxH20,
              getDailyGoalContainer(),
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
  Future<void> initialize() async {
    Future.wait([_getPersonalizedPlan(), _getUserProfile(), _getActiveUserPet(), _getUserEnergies(), _getDailyGoals()]);
  }

  Future<void> _getPersonalizedPlan() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getPersonalizedPlan());
  }

  Future<void> _getUserProfile() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getUserProfile());
  }

  Future<void> _getActiveUserPet() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getActiveUserPet());
  }

  Future<void> _onRefresh() async {
    Future.wait([_getActiveUserPet(), _getUserEnergies(), _getDailyGoals()]);
  }

  Future<void> _getUserEnergies() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getUserEnergies());
  }

  Future<void> _getDailyGoals() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getDailyGoals());
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
    context.router.push(VirtualPetShopRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProgressPageState {
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
          Text('${userEnergy.energies}'),
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
        child: Center(child: FaIcon(FontAwesomeIcons.bagShopping, size: AppStyles.kSize16)),
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
          Text(
            S.current.dailyGoalsLabel,
            style: _Styles.getDailyGoalLabelTextStyle(context),
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
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
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
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Header Button Container Decoration
  static BoxDecoration getHeaderButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
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
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }
}
