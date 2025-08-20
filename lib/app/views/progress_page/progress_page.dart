import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/viewmodels/progress_vm/progress_view_model.dart';
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
    _getPersonalizedPlan();
    _getUserProfile();
    _getActiveUserPet();
    _getUserEnergies();
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
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            getIsometricRoomHeader(),
            getIsometricRoomImage(),
            getExperiencePointsColumn(),
            AppStyles.kSizedBoxH12,
            getActionRow(),
            AppStyles.kSizedBoxH20,
            getDailyGoal()
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

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ProgressPageState {
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
    await _getActiveUserPet();
  }

  Future<void> _getUserEnergies() async {
    await tryLoad(context, () => context.read<ProgressViewModel>().getUserEnergies());
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProgressPageState {
  void _onActionButtonPressed(VirtualPetActionModel action) async {
    final vm = context.read<ProgressViewModel>();
    final previousLevel = vm.activeUserPet.getCurrentLevel();

    await vm.updateCurrentExp(addedExp: action.exp);

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
          FaIcon(FontAwesomeIcons.boltLightning, size: AppStyles.kSize16),
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
    return Container(
      decoration: _Styles.getHeaderButtonContainerDecoration(context),
      height: AppStyles.kSize32,
      width: AppStyles.kSize32,
      child: Center(child: FaIcon(FontAwesomeIcons.bagShopping, size: AppStyles.kSize16)),
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

  // Experience Points Column
  Widget getExperiencePointsColumn() {
    final activeUserPet = context.select((ProgressViewModel vm) => vm.activeUserPet);

    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.current.experiencePointsLabel, style: _Styles.getExperiencePointsLabelTextStyle(context)),
            Text(activeUserPet.getExpProgressText(), style: _Styles.getExperiencePointsLabelTextStyle(context))
          ],
        ),
        getExperiencePointsContainer(activeUserPet: activeUserPet),
      ],
    );
  }

  // Experience Points Container
  Widget getExperiencePointsContainer({required ActiveUserPetModel activeUserPet}) {
    return Container(
      padding: AppStyles.kPaddSV4H8,
      decoration: _Styles.getExperiencePointsContainerDecoration(context),
      child: getExperiencePointsProgressIndicator(activeUserPet: activeUserPet),
    );
  }

  // Experience Points Progress Indicator
  Widget getExperiencePointsProgressIndicator({required ActiveUserPetModel activeUserPet}) {
    return LinearPercentIndicator(
      percent: activeUserPet.getLevelProgress(),
      backgroundColor: context.theme.colorScheme.tertiary,
      progressColor: context.theme.colorScheme.secondary,
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: 10,
      trailing: getLevelLabel(activeUserPet: activeUserPet),
    );
  }

  // Level Label
  Widget getLevelLabel({required ActiveUserPetModel activeUserPet}) {
    final level = activeUserPet.getCurrentLevel();
    return Padding(
      padding: AppStyles.kPaddOL8,
      child: Text('LVL $level', style: _Styles.getLevelLabelTextStyle(context)),
    );
  }

  // Action Row
  Widget getActionRow() {
    return Row(
      spacing: AppStyles.kSpac8,
      children: virtualPetActions.map((action) => getActionButton(action)).toList(),
    );
  }

  // Action Button
  Widget getActionButton(VirtualPetActionModel action) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _onActionButtonPressed(action);
        },
        child: Container(
          decoration: _Styles.getActionButtonDecoration(context),
          padding: AppStyles.kPaddSV4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppStyles.kSpac4,
                children: [
                  FaIcon(action.icon, size: AppStyles.kSize14, color: context.theme.colorScheme.primary),
                  Text(action.label)
                ],
              ),
              Text('${action.exp} EXP'),
            ],
          ),
        ),
      ),
    );
  }

  // Daily Goal
  Widget getDailyGoal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [getDailyGoalHeader(), getDailyGoalContainer()],
    );
  }

  // Daily Goal Header
  Widget getDailyGoalHeader() {
    return Text(S.current.dailyGoalLabel, style: _Styles.getDailyGoalLabelTextStyle(context));
  }

  // Daily Goal Container
  Widget getDailyGoalContainer() {
    return Container(
      decoration: _Styles.getDailyGoalContainerDecoration(context),
      height: AppStyles.kSize64,
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Experience Points Container Decoration
  static BoxDecoration getExperiencePointsContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary.withAlpha(150),
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Experience Points Label Text Style
  static TextStyle getExperiencePointsLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Action Button Decoration
  static BoxDecoration getActionButtonDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary.withAlpha(150),
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Level Label Text Style
  static TextStyle getLevelLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall);
  }

  // Energies Container Decoration
  static BoxDecoration getEnergiesContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary.withAlpha(150),
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Header Button Container Decoration
  static BoxDecoration getHeaderButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary.withAlpha(150),
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
      color: context.theme.colorScheme.onPrimary.withAlpha(150),
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }
}

class VirtualPetActionModel {
  final String label;
  final int exp;
  final IconData icon;
  final int energy;

  VirtualPetActionModel({
    required this.label,
    required this.exp,
    required this.icon,
    required this.energy,
  });
}

final List<VirtualPetActionModel> virtualPetActions = [
  VirtualPetActionModel(
    label: 'Feed',
    exp: 10,
    icon: FontAwesomeIcons.apple,
    energy: 5,
  ),
  VirtualPetActionModel(
    label: 'Play',
    exp: 15,
    icon: FontAwesomeIcons.baseball,
    energy: 10,
  ),
  VirtualPetActionModel(
    label: 'Groom',
    exp: 20,
    icon: FontAwesomeIcons.scissors,
    energy: 15,
  ),
];
