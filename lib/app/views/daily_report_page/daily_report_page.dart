import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/nutrient_progress_model/nutrient_progress_model.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_with_desc.dart';
import 'package:flux/app/widgets/food/nutrient_intake_progress.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class DailyReportPage extends BaseStatefulPage {
  const DailyReportPage({super.key, required this.selectedDate, required this.loggedFoodsList});

  final DateTime selectedDate;
  final List<LoggedFoodModel> loggedFoodsList;

  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends BaseStatefulState<DailyReportPage> {
  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    return Column(
      children: [
        getCustomAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: AppStyles.kPaddSV16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppStyles.kSpac24,
              children: [
                getMacronutrientsProgressContainer(macronutrientsProgressList, S.current.macronutrientsProgressLabel),
                getGridContainer(highlightedMicroList, S.current.highlightedMicroLabel),
                getListContainer(completeNutrientList, S.current.completeNutrientsLabel),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _DailyReportPageState {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _DailyReportPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _DailyReportPageState {
  // Custom App Bar
  Widget getCustomAppBar() {
    final formattedDate = DateFormat('EEEE, MMMM d').format(widget.selectedDate);
    return CustomAppBarWithDesc(
      leadingButton: getBackActionButton(),
      trailingButton: AppStyles.kEmptyWidget,
      title: S.current.dailyFullReportLabel,
      desc: formattedDate,
      image: ImagePath.report,
      imageSize: AppStyles.kSize20,
    );
  }

  // Back Button
  Widget getBackActionButton() {
    return CustomAppBarTappable(
      icon: FontAwesomeIcons.chevronLeft,
      color: context.theme.colorScheme.primary,
      label: S.current.diaryLabel,
      modalSheetBarTappablePosition: CustomAppBarTappablePosition.LEADING,
      onTap: () => context.router.maybePop(),
    );
  }

  // Macronutrients Progress Container
  Widget getMacronutrientsProgressContainer(List<Nutrition> list, String label) {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final macroProgressList = getNutrientProgressList(
      widget.loggedFoodsList,
      userPlan,
      list,
    );

    final calorie = macroProgressList[0];

    return Padding(
      padding: AppStyles.kPaddSH12,
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        padding: AppStyles.kPaddSV12H12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac12,
          children: [
            Row(
              spacing: AppStyles.kSpac4,
              children: [
                Icon(Icons.pie_chart_sharp, size: AppStyles.kSize20),
                Text(label, style: _Styles.getContainerHeaderLabelTextStyle()),
              ],
            ),
            Padding(
              padding: AppStyles.kPaddSH12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppStyles.kSpac12,
                children: [
                  CircularPercentIndicator(
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${calorie.currentValue.toInt()} / ${calorie.targetValue.toInt()}',
                          style: Quicksand.bold.withSize(FontSizes.small),
                        ),
                        Text(NutritionUnit.kcal.label, style: Quicksand.regular.withSize(FontSizes.small)),
                      ],
                    ),
                    progressColor: context.theme.colorScheme.secondary,
                    percent: (calorie.currentValue / calorie.targetValue).clamp(0, 1),
                    backgroundColor: context.theme.colorScheme.tertiary,
                    radius: AppStyles.kSize56,
                    lineWidth: AppStyles.kSize7,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animateFromLastPercent: true,
                    animateToInitialPercent: true,
                  ),
                  Flexible(
                    child: Padding(
                      padding: AppStyles.kPaddOB20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppStyles.kSpac12,
                        children: macroProgressList.map((nutrient) {
                          if (nutrient.nutrition == Nutrition.calorie) {
                            return AppStyles.kEmptyWidget;
                          }
                          return NutrientIntakeProgress(
                            nutrition: nutrient.nutrition,
                            percentage: (nutrient.currentValue / nutrient.targetValue).clamp(0, 1),
                            currentValue: nutrient.currentValue,
                            targetValue: nutrient.targetValue,
                            lineHeight: 7,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // List Container
  Widget getListContainer(List<Nutrition> list, String label) {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final progressList = getNutrientProgressList(
      widget.loggedFoodsList,
      userPlan,
      list,
    );

    return Padding(
      padding: AppStyles.kPaddSH12,
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        padding: AppStyles.kPaddSV12H12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac12,
          children: [
            Row(
              spacing: AppStyles.kSpac4,
              children: [
                Icon(Icons.format_line_spacing_outlined, size: AppStyles.kSize20),
                Text(label, style: _Styles.getContainerHeaderLabelTextStyle()),
              ],
            ),
            Column(
              spacing: AppStyles.kSpac12,
              children: progressList.map((nutrient) {
                return NutrientIntakeProgress(
                  nutrition: nutrient.nutrition,
                  percentage: (nutrient.currentValue / nutrient.targetValue).clamp(0, 1),
                  currentValue: nutrient.currentValue,
                  targetValue: nutrient.targetValue,
                  lineHeight: 7,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Grid Container
  Widget getGridContainer(List<Nutrition> list, String label) {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final progressList = getNutrientProgressList(
      widget.loggedFoodsList,
      userPlan,
      list,
    );

    return Padding(
      padding: AppStyles.kPaddSH12,
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        padding: AppStyles.kPaddSV12H12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac12,
          children: [
            Row(
              spacing: AppStyles.kSpac4,
              children: [
                Icon(Icons.warning_rounded, size: AppStyles.kSize20),
                Text(label, style: _Styles.getContainerHeaderLabelTextStyle()),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 4,
              crossAxisSpacing: AppStyles.kSize8,
              children: progressList.map((nutrient) {
                return NutrientIntakeProgress(
                  nutrition: nutrient.nutrition,
                  percentage: (nutrient.currentValue / nutrient.targetValue).clamp(0, 1),
                  currentValue: nutrient.currentValue,
                  targetValue: nutrient.targetValue,
                  lineHeight: 7,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Container Header Label
  static TextStyle getContainerHeaderLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.small);
  }
}

final macronutrientsProgressList = [
  Nutrition.calorie,
  Nutrition.protein,
  Nutrition.carbs,
  Nutrition.fat,
];

final highlightedMicroList = [
  Nutrition.calcium,
  Nutrition.iron,
  Nutrition.magnesium,
  Nutrition.potassium,
  Nutrition.sodium,
  Nutrition.zinc,
  Nutrition.vitaminA,
  Nutrition.vitaminD,
  Nutrition.vitaminC,
  Nutrition.vitaminB12,
];

final completeNutrientList = [
  Nutrition.calorie,
  Nutrition.protein,
  Nutrition.fat,
  Nutrition.carbs,
  Nutrition.calcium,
  Nutrition.iron,
  Nutrition.magnesium,
  Nutrition.phosphorus,
  Nutrition.potassium,
  Nutrition.sodium,
  Nutrition.zinc,
  Nutrition.copper,
  Nutrition.manganese,
  Nutrition.selenium,
  Nutrition.vitaminA,
  Nutrition.vitaminE,
  Nutrition.vitaminD,
  Nutrition.vitaminC,
  Nutrition.thiamin,
  Nutrition.riboflavin,
  Nutrition.niacin,
  Nutrition.vitaminB6,
  Nutrition.vitaminB12,
  Nutrition.choline,
  Nutrition.vitaminK,
  Nutrition.folate,
];
