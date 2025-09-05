import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/virtual_pet_action_model/virtual_pet_action_model.dart';
import 'package:flux/app/viewmodels/overview_vm/overview_view_model.dart';
import 'package:flux/app/widgets/daily_goals_percent_indicator/daily_goals_percent_indicator.dart';
import 'package:flux/app/widgets/skeleton/virtual_pet_skeleton.dart';
import 'package:flux/app/widgets/virtual_pet_action_button/virtual_pet_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:showcaseview/showcaseview.dart';

class VirtualPetTabBarView extends StatelessWidget {
  const VirtualPetTabBarView({
    super.key,
    required this.onVirtualPetRefresh,
    required this.onShopPressed,
    required this.onPetActionButtonPressed,
    required this.onClaimPressed,
    required this.petController,
    required this.confettiController,
    required this.isPlayingCrackedEggAnimation,
    required this.isShowingConfetti,
    required this.onLoadedConfettiAnimation,
    required this.onLoadedPetAnimation,
    required this.isLoading,
    required this.showcaseKey,
  });

  final VoidCallback onVirtualPetRefresh;
  final VoidCallback onShopPressed;
  final void Function({required VirtualPetActionModel action, required UserEnergyModel userEnergy})
      onPetActionButtonPressed;
  final void Function({required int energyReward, required int goalId}) onClaimPressed;

  final AnimationController petController;
  final AnimationController confettiController;
  final bool isPlayingCrackedEggAnimation;
  final bool isShowingConfetti;
  final void Function(LottieComposition composition) onLoadedConfettiAnimation;
  final void Function(LottieComposition composition) onLoadedPetAnimation;
  final bool isLoading;
  final List<GlobalKey> showcaseKey;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((OverviewViewModel vm) => vm.isLoading);

    return Padding(
      padding: AppStyles.kPaddSH12,
      child: RefreshIndicator(
        onRefresh: () async {
          onVirtualPetRefresh();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(spacing: AppStyles.kSpac12, children: [
            if (isLoading) ...[
              VirtualPetSkeleton(),
            ] else ...[
              AppStyles.kEmptyWidget,
              getIsometricRoomHeader(context: context),
              getExperiencePointsContainer(context: context),
              getIsometricRoomImage(context: context),
              getActionRow(context: context),
              getDailyGoalContainer(context: context),
              AppStyles.kEmptyWidget,
            ],
          ]),
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on VirtualPetTabBarView {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on VirtualPetTabBarView {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on VirtualPetTabBarView {
  // Isometric Room Header
  Widget getIsometricRoomHeader({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [getEnergiesContainer(context: context), getHeaderActionRow(context: context)],
    );
  }

  // Energies Container
  Widget getEnergiesContainer({required BuildContext context}) {
    final userEnergy = context.select((OverviewViewModel vm) => vm.userEnergy);
    return getCustomShowcase(
      context: context,
      key: showcaseKey[2],
      title: S.current.showcase3Title,
      description: S.current.showcase3Desc,
      child: Container(
        decoration: _Styles.getEnergiesContainerDecoration(context),
        padding: AppStyles.kPaddSV6H12,
        child: Row(
          spacing: AppStyles.kSpac4,
          children: [
            Image.asset(ImagePath.energy, height: AppStyles.kSize16),
            Text('${userEnergy.energies}', style: _Styles.getEnergyLabelTextStyle(context)),
          ],
        ),
      ),
    );
  }

  // Header Action Row
  Widget getHeaderActionRow({required BuildContext context}) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [getShopButton(context: context), getHelpButton(context: context)],
    );
  }

  // Help Button
  Widget getHelpButton({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        ShowCaseWidget.of(context).startShowCase(showcaseKey);
      },
      child: Container(
        decoration: _Styles.getHeaderButtonContainerDecoration(context),
        height: AppStyles.kSize32,
        width: AppStyles.kSize32,
        child: Center(child: FaIcon(FontAwesomeIcons.question, size: AppStyles.kSize16)),
      ),
    );
  }

  // Shop Button
  Widget getShopButton({required BuildContext context}) {
    return GestureDetector(
      onTap: onShopPressed,
      child: getCustomShowcase(
        context: context,
        key: showcaseKey[5],
        title: S.current.showcase6Title,
        description: S.current.showcase6Desc,
        child: Container(
          decoration: _Styles.getHeaderButtonContainerDecoration(context),
          height: AppStyles.kSize32,
          width: AppStyles.kSize32,
          child: Center(child: FaIcon(FontAwesomeIcons.paw, size: AppStyles.kSize16)),
        ),
      ),
    );
  }

  // Isometric Room Image
  Widget getIsometricRoomImage({required BuildContext context}) {
    return Stack(
      children: [Image.asset(ImagePath.vpBackground), getAnimations(context: context)],
    );
  }

  // Animations
  Widget getAnimations({required BuildContext context}) {
    final activeUserPet = context.select((OverviewViewModel vm) => vm.activeUserPet);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      bottom: activeUserPet.getCurrentLevel() == 1 || isPlayingCrackedEggAnimation ? 20 : 10,
      left: 0,
      right: 0,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isShowingConfetti) getConfettiAnimation(),
            getVirtualPetAnimation(activeUserPet: activeUserPet, context: context)
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
              controller: confettiController,
              onLoaded: (composition) {
                onLoadedConfettiAnimation(composition);
              },
            ),
          ),
        ),
      ),
    );
  }

  // Virtual Pet Animation
  Widget getVirtualPetAnimation({required ActiveUserPetModel activeUserPet, required BuildContext context}) {
    String petAnimationUrl =
        isPlayingCrackedEggAnimation ? AnimationUrl.crackedEgg : activeUserPet.getPetAnimationUrl();
    return GestureDetector(
      onTap: () {
        if (!isPlayingCrackedEggAnimation) {
          petController
            ..reset()
            ..forward();
        }
      },
      child: getCustomShowcase(
        context: context,
        key: showcaseKey[0],
        title: S.current.showcase1Title,
        description: S.current.showcase1Desc,
        child: SizedBox(
          height: AppStyles.kSize150,
          width: AppStyles.kSize150,
          child: Lottie.network(
            petAnimationUrl,
            width: AppStyles.kSize150,
            controller: petController,
            onLoaded: (composition) {
              onLoadedPetAnimation(composition);
            },
            errorBuilder: (context, error, stackTrace) => AppStyles.kEmptyWidget,
          ),
        ),
      ),
    );
  }

  // Custom Showcase
  Widget getCustomShowcase({
    required BuildContext context,
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      titleTextStyle: Quicksand.bold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary),
      descTextStyle: Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary),
      tooltipActionConfig: TooltipActionConfig(alignment: MainAxisAlignment.end),
      tooltipPadding: AppStyles.kPaddSV8H16,
      disableBarrierInteraction: true,
      tooltipActions: [getTooltipActionButton(context: context)],
      targetBorderRadius: AppStyles.kRad10,
      titleAlignment: Alignment.centerLeft,
      descriptionAlignment: Alignment.centerLeft,
      enableAutoScroll: true,
      child: child,
    );
  }

  // Tooltip Action Button
  TooltipActionButton getTooltipActionButton({required BuildContext context}) {
    return TooltipActionButton.custom(
      button: GestureDetector(
        onTap: () {
          ShowCaseWidget.of(context).next();
        },
        child: Container(
          padding: AppStyles.kPadd8,
          decoration: _Styles.getTooltipActionButtonContainerDecoration(context),
          child: Icon(Icons.arrow_forward_rounded, color: Colors.white, size: AppStyles.kSize16),
        ),
      ),
    );
  }

  // Experience Points Container
  Widget getExperiencePointsContainer({required BuildContext context}) {
    final activeUserPet = context.select((OverviewViewModel vm) => vm.activeUserPet);
    return getCustomShowcase(
      context: context,
      key: showcaseKey[1],
      title: S.current.showcase2Title,
      description: S.current.showcase2Desc,
      child: Container(
        decoration: _Styles.getExperiencePointsContainerDecoration(context),
        child: getExperiencePointsContent(activeUserPet: activeUserPet, context: context),
      ),
    );
  }

  // Experience Points Content
  Widget getExperiencePointsContent({required ActiveUserPetModel activeUserPet, required BuildContext context}) {
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
        getExperiencePointsProgressIndicator(activeUserPet: activeUserPet, context: context)
      ],
    );
  }

  // Experience Points Progress Indicator
  Widget getExperiencePointsProgressIndicator({
    required ActiveUserPetModel activeUserPet,
    required BuildContext context,
  }) {
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
  Widget getActionRow({required BuildContext context}) {
    final userEnergy = context.select((OverviewViewModel vm) => vm.userEnergy);
    final isUpdatingCurrentExp = context.select((OverviewViewModel vm) => vm.isUpdatingCurrentExp);

    return Row(
      spacing: AppStyles.kSpac8,
      children: virtualPetActions.asMap().entries.map((entry) {
        final index = entry.key;
        final action = entry.value;

        final actionButton = VirtualPetActionButton(
          action: action,
          userEnergy: userEnergy,
          isUpdatingCurrentExp: isUpdatingCurrentExp,
          onActionButtonPressed: onPetActionButtonPressed,
        );

        final child = (index == 0)
            ? getCustomShowcase(
                context: context,
                key: showcaseKey[3],
                title: S.current.showcase4Title,
                description: S.current.showcase4Desc,
                child: actionButton,
              )
            : actionButton;

        return Expanded(child: child);
      }).toList(),
    );
  }

// Daily Goal Container
  Widget getDailyGoalContainer({required BuildContext context}) {
    final dailyGoals = context.select((OverviewViewModel vm) => vm.dailyGoals);
    return getCustomShowcase(
      context: context,
      key: showcaseKey[4],
      title: S.current.showcase5Title,
      description: S.current.showcase5Desc,
      child: Container(
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
                onClaimPressed: onClaimPressed,
              );
            }),
          ],
        ),
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

  // Experience Points Progress Indicator Container Decoration
  static BoxDecoration getExperiencePointsProgressIndicatorContainerDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: AppStyles.kRadOBL10BR10,
      color: context.theme.colorScheme.primary,
    );
  }

  // Tool Tip Action Button Container Decoration
  static BoxDecoration getTooltipActionButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      borderRadius: AppStyles.kRad6,
    );
  }
}
