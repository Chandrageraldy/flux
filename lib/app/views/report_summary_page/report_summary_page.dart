import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/report_summary_vm/report_summary_view_model.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_tappable.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_with_desc.dart';
import 'package:flux/app/widgets/food/nutrient_intake_progress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class ReportSummaryPage extends StatelessWidget {
  const ReportSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ReportSummaryViewModel(), child: _ReportSummaryPage());
  }
}

class _ReportSummaryPage extends BaseStatefulPage {
  @override
  State<_ReportSummaryPage> createState() => _ReportSummaryPageState();
}

class _ReportSummaryPageState extends BaseStatefulState<_ReportSummaryPage> {
  DateRange _selectedDateRange = DateRange.last1Weeks;

  @override
  bool hasDefaultPadding() => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLoggedFoodsBetweenDates();
    });
  }

  @override
  Widget body() {
    return Column(
      children: [
        getCustomAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppStyles.kPaddSH12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppStyles.kSpac24,
                children: [
                  AppStyles.kEmptyWidget,
                  getFormBuilderDropDown(),
                  getMacronutrientsProgressContainer(macronutrientsProgressList, S.current.macronutrientsProgressLabel),
                  getGridContainer(highlightedMicroList, S.current.highlightedMicroLabel),
                  getListContainer(completeNutrientList, S.current.completeNutrientsLabel),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ReportSummaryPageState {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ReportSummaryPageState {
  Future<void> _getLoggedFoodsBetweenDates() async {
    await tryLoad(
      context,
      () => context.read<ReportSummaryViewModel>().getLoggedFoodsBetweenDates(
            startDate: DateTime.now().subtract(const Duration(days: 6)),
            endDate: DateTime.now(),
          ),
    );
  }

  Future<void> _onChanged(DateRange? value) async {
    if (value == null) return;

    _setState(() {
      _selectedDateRange = value;
    });

    await tryLoad(
      context,
      () => context.read<ReportSummaryViewModel>().getLoggedFoodsBetweenDates(
            startDate: DateTime.now().subtract(Duration(days: value.range - 1)),
            endDate: DateTime.now(),
          ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ReportSummaryPageState {
  // Custom App Bar
  Widget getCustomAppBar() {
    // final formattedDate = DateFormat('EEEE, MMMM d').format(widget.selectedDate);
    return CustomAppBarWithDesc(
      leadingButton: getBackActionButton(),
      trailingButton: AppStyles.kEmptyWidget,
      title: S.current.reportSummaryLabel,
      desc: S.current.reportSummaryDesc,
    );
  }

  // Back Button
  Widget getBackActionButton() {
    return CustomAppBarTappable(
      icon: FontAwesomeIcons.chevronLeft,
      color: context.theme.colorScheme.primary,
      label: '',
      modalSheetBarTappablePosition: CustomAppBarTappablePosition.LEADING,
      onTap: () => context.router.maybePop(),
    );
  }

  // Form Builder Drop Down
  Widget getFormBuilderDropDown() {
    return SizedBox(
      width: AppStyles.kSize130,
      child: FormBuilderDropdown(
        name: FormFields.dateRange.name,
        items: DateRange.values
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.label),
                ))
            .toList(),
        initialValue: _selectedDateRange,
        onChanged: (value) {
          _onChanged(value);
        },
        style: _Styles.getFormBuilderDropDownTextStyle(context),
        decoration: _Styles.getFieldInputDecoration(),
      ),
    );
  }

  // Macronutrients Progress Container
  Widget getMacronutrientsProgressContainer(List<Nutrition> list, String label) {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final loggedFoodsBetweenDates = context.select((ReportSummaryViewModel vm) => vm.loggedFoodsBetweenDates);

    final macroProgressList = FunctionUtils.calculateAverageNutrientsWithPlan(
      loggedFoods: loggedFoodsBetweenDates,
      dayRange: _selectedDateRange.range,
      wantedNutrients: [Nutrition.calorie, Nutrition.protein, Nutrition.carbs, Nutrition.fat],
      plan: userPlan,
    );

    final calorie = macroProgressList[0];

    return Container(
      decoration: _Styles.getContainerDecoration(context),
      padding: AppStyles.kPaddSV12H12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          Row(
            spacing: AppStyles.kSpac4,
            children: [
              Icon(Icons.insert_chart, size: AppStyles.kSize20),
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
    );
  }

  // List Container
  Widget getListContainer(List<Nutrition> list, String label) {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final loggedFoodsBetweenDates = context.select((ReportSummaryViewModel vm) => vm.loggedFoodsBetweenDates);

    final progressList = FunctionUtils.calculateAverageNutrientsWithPlan(
      loggedFoods: loggedFoodsBetweenDates,
      dayRange: _selectedDateRange.range,
      wantedNutrients: list,
      plan: userPlan,
    );

    return Container(
      decoration: _Styles.getContainerDecoration(context),
      padding: AppStyles.kPaddSV12H12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          Row(
            spacing: AppStyles.kSpac4,
            children: [
              Icon(Icons.assignment_rounded, size: AppStyles.kSize20),
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
    );
  }

  // Grid Container
  Widget getGridContainer(List<Nutrition> list, String label) {
    final PlanModel? userPlan = SharedPreferenceHandler().getPlan();

    final loggedFoodsBetweenDates = context.select((ReportSummaryViewModel vm) => vm.loggedFoodsBetweenDates);

    final progressList = FunctionUtils.calculateAverageNutrientsWithPlan(
      loggedFoods: loggedFoodsBetweenDates,
      dayRange: _selectedDateRange.range,
      wantedNutrients: list,
      plan: userPlan,
    );

    return Container(
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
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Form Builder Drop Down Text Style
  static TextStyle getFormBuilderDropDownTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Field Input Decoration
  static InputDecoration getFieldInputDecoration() {
    return InputDecoration(border: InputBorder.none, isDense: true, contentPadding: AppStyles.kPaddOL4T6B6);
  }

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

enum DateRange {
  today,
  last1Weeks,
  last2Weeks,
  last3Weeks,
  last4Weeks,
  last3Months,
  last6Months,
  lastYear;

  String get label {
    switch (this) {
      case DateRange.today:
        return S.current.todayLabel;
      case DateRange.last1Weeks:
        return S.current.last1WeeksLabel;
      case DateRange.last2Weeks:
        return S.current.last2WeeksLabel;
      case DateRange.last3Weeks:
        return S.current.last3WeeksLabel;
      case DateRange.last4Weeks:
        return S.current.last4WeeksLabel;
      case DateRange.last3Months:
        return S.current.last3MonthsLabel;
      case DateRange.last6Months:
        return S.current.last6MonthsLabel;
      case DateRange.lastYear:
        return S.current.lastYearLabel;
    }
  }

  int get range {
    switch (this) {
      case DateRange.today:
        return 1;
      case DateRange.last1Weeks:
        return 7;
      case DateRange.last2Weeks:
        return 14;
      case DateRange.last3Weeks:
        return 21;
      case DateRange.last4Weeks:
        return 28;
      case DateRange.last3Months:
        return 90;
      case DateRange.last6Months:
        return 180;
      case DateRange.lastYear:
        return 365;
    }
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
