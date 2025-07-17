import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/food/meal_macronutrient_intake_progress.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class MealDetailsPage extends BaseStatefulPage {
  const MealDetailsPage({required this.mealType, super.key});

  final MealType mealType;

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends BaseStatefulState<MealDetailsPage> {
  @override
  PreferredSizeWidget? appbar() => DefaultAppBar(
      backgroundColor: context.theme.colorScheme.onPrimary, title: widget.mealType.label, centerTitle: true);

  @override
  defaultPadding() => AppStyles.kPadd0;

  @override
  Widget body() {
    return SingleChildScrollView(
      padding: AppStyles.kPaddOB70,
      child: Column(
        children: [
          getHeaderContainer(),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MealDetailsPageState {
  // Header Container
  Widget getHeaderContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      padding: AppStyles.kPaddSV12H28,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppStyles.kSpac32,
        children: [
          getCalorieCircularProgressIndicator(),
          Expanded(
            child: Column(
              spacing: AppStyles.kSpac20,
              children: [
                MealMacronutrientIntakeProgress(macroNutrient: MacroNutrients.protein),
                MealMacronutrientIntakeProgress(macroNutrient: MacroNutrients.carbs),
                MealMacronutrientIntakeProgress(macroNutrient: MacroNutrients.fat),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Calorie Circular Progress Indicator
  Widget getCalorieCircularProgressIndicator() {
    return CircularPercentIndicator(
      lineWidth: _Styles.circularPercentIndicatorLineWidth,
      radius: 80,
      percent: 0.66,
      progressColor: context.theme.colorScheme.secondary,
      backgroundColor: context.theme.colorScheme.tertiary,
      center: getCalorieCircularCenterLabel(),
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: false,
      arcType: ArcType.FULL,
      arcBackgroundColor: context.theme.colorScheme.tertiary,
    );
  }

  // Calorie Circular Center Label
  Widget getCalorieCircularCenterLabel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('2000', style: _Styles.getRemainingNumberLabelTextStyle(context)),
        Text(S.current.remainingLabel, style: _Styles.getRemainingLabelTextStyle(context)),
        AppStyles.kSizedBoxH4
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealDetailsPageState {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL20BR20,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Remaining Label Label Text Style
  static TextStyle getRemainingNumberLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraMassive).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Formula Label Text Style
  static TextStyle getRemainingLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Circular Percent Indicator Line Width
  static double circularPercentIndicatorLineWidth = 10.0;

  // Circular Percent Indicator Radius
  static double circularPercentIndicatorRadius = 80.0;
}
