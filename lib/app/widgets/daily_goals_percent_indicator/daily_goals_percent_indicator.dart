import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/daily_goals_model/daily_goals_model.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class DailyGoalsPercentIndicator extends StatelessWidget {
  const DailyGoalsPercentIndicator({required this.dailyGoal, required this.onClaimPressed, super.key});

  final DailyGoalsModel dailyGoal;
  final void Function({required int goalId, required int energyReward}) onClaimPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac4,
      children: [
        getHeaderLabel(context),
        Row(children: [getLinearPercentIndicator(context), getClaimButton(context)])
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on DailyGoalsPercentIndicator {
  // Header Label
  Widget getHeaderLabel(BuildContext context) {
    final unit = dailyGoal.goalType == GoalType.CALORIE.value
        ? NutritionUnit.kcal.label
        : dailyGoal.goalType == GoalType.PROTEIN.value
            ? NutritionUnit.g.label
            : '';

    return Text(
      '${dailyGoal.goalDesc ?? ''} '
      '(${dailyGoal.currentValue ?? 0}/${dailyGoal.targetValue ?? 0}'
      '${unit.isNotEmpty ? ' $unit' : ''})',
      style: _Styles.getHeaderTextStyle(context),
    );
  }

  // Linear Percent Indicator
  Widget getLinearPercentIndicator(BuildContext context) {
    final current = dailyGoal.currentValue ?? 0;
    final target = dailyGoal.targetValue ?? 1; // avoid divide by zero
    final percent = (current / target).clamp(0.0, 1.0);

    return Expanded(
      flex: 7,
      child: LinearPercentIndicator(
        percent: percent,
        backgroundColor: context.theme.colorScheme.tertiary,
        progressColor: context.theme.colorScheme.secondary,
        animation: true,
        animateFromLastPercent: true,
        animateToInitialPercent: false,
        padding: AppStyles.kPadd0,
        barRadius: Radius.circular(AppStyles.kSpac20),
        lineHeight: 10,
      ),
    );
  }

// Claim Button
  Widget getClaimButton(BuildContext context) {
    final current = dailyGoal.currentValue ?? 0;
    final target = dailyGoal.targetValue ?? 1;
    final isClaimed = dailyGoal.isClaimed ?? false;

    final canClaim = current >= target && !isClaimed;

    final backgroundColor = isClaimed
        ? context.theme.colorScheme.tertiary
        : canClaim
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.tertiary;

    final label = isClaimed
        ? S.current.claimedLabel
        : canClaim
            ? S.current.claimLabel
            : S.current.claimLabel;

    return Expanded(
      flex: 3,
      child: Padding(
        padding: AppStyles.kPaddOL8,
        child: GestureDetector(
          onTap: isClaimed || !canClaim
              ? null
              : () {
                  onClaimPressed(
                    goalId: dailyGoal.id ?? 0,
                    energyReward: dailyGoal.energyReward ?? 0,
                  );
                },
          child: Container(
            decoration: _Styles.getClaimButtonContainerDecoration(context, backgroundColor),
            padding: AppStyles.kPaddSV2,
            child: Center(
              child: Text(label, style: _Styles.getClaimButtonTextStyle(context)),
            ),
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Header Text Style
  static TextStyle getHeaderTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall);
  }

  // Claim Button Container Decoration
  static BoxDecoration getClaimButtonContainerDecoration(BuildContext context, Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Claim Button Text Style
  static TextStyle getClaimButtonTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }
}
