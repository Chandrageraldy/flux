import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/food/meal_macronutrient_intake_progress.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:intl/intl.dart';
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
  PreferredSizeWidget? appbar() => DefaultAppBar(backgroundColor: context.theme.colorScheme.onPrimary);

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
      padding: AppStyles.kPaddSH28,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getMealTypeLabel(),
          AppStyles.kSizedBoxH4,
          getDateContainer(),
          AppStyles.kSizedBoxH32,
          Row(
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
          AppStyles.kSizedBoxH20,
        ],
      ),
    );
  }

  // Meal Type Label
  Widget getMealTypeLabel() {
    return Text(
      widget.mealType.label,
      style: _Styles.getMealTypeLabelTextStyle(context),
    );
  }

  // Date Container
  Widget getDateContainer() {
    return Container(
      padding: AppStyles.kPaddSV4H8,
      decoration: _Styles.getDateContainerDecoration(context),
      child: getDateLabel(),
    );
  }

  // Date Label
  Widget getDateLabel() {
    return Text(
      DateTime.now().toFormattedString(DateFormat.YEAR_ABBR_MONTH_DAY),
      style: _Styles.getDateLabelTextStyle(context),
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

  // Meal Type Label Text Style
  static TextStyle getMealTypeLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraHuge);
  }

  // Date Label Text Style
  static TextStyle getDateLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold
        .withSize(FontSizes.mediumPlus)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Date Container Decoration
  static BoxDecoration getDateContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.surface,
      borderRadius: AppStyles.kRad8,
    );
  }
}
