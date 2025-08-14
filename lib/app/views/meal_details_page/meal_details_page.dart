import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/meal_ratio_model.dart/meal_ratio_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/meal_details_vm/meal_details_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/empty_result/empty_result.dart';
import 'package:flux/app/widgets/food/meal_details_food_display_card.dart';
import 'package:flux/app/widgets/food/meal_macronutrient_intake_progress.dart';
import 'package:flux/app/widgets/skeleton/meal_details_food_list_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({super.key, required this.mealType, required this.selectedDate});

  final MealType mealType;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealDetailsViewModel(),
      child: _MealDetailsPage(mealType: mealType, selectedDate: selectedDate),
    );
  }
}

class _MealDetailsPage extends BaseStatefulPage {
  const _MealDetailsPage({required this.mealType, required this.selectedDate});

  final MealType mealType;
  final DateTime selectedDate;

  @override
  State<_MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends BaseStatefulState<_MealDetailsPage> {
  @override
  PreferredSizeWidget? appbar() => DefaultAppBar(backgroundColor: context.theme.colorScheme.onPrimary);

  @override
  bool hasDefaultPadding() => false;

  @override
  void initState() {
    super.initState();
    getLoggedFoodsByMeals();
  }

  @override
  Widget body() {
    final loggedFoodsList = context.select((MealDetailsViewModel vm) => vm.loggedFoodsList);
    final isLoading = context.select((MealDetailsViewModel vm) => vm.isLoading);

    return SingleChildScrollView(
      padding: AppStyles.kPaddOB70,
      child: Column(
        children: [
          getHeaderContainer(
              _getMealRatioModel(widget.mealType), FunctionUtils.calculateTotalNutrition(loggedFoodsList)),
          getLoggedMeals(loggedFoodsList, isLoading),
        ],
      ),
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _MealDetailsPageState {
  void _onLoggedFoodTap(LoggedFoodModel loggedFood, BuildContext context) {
    if (loggedFood.source == LogSource.foodSearch.value) {
      context.router.push(FoodSearchLoggedFoodDetailsRoute(loggedFood: loggedFood));
    } else {
      context.router.push(
        MealScanLoggedFoodNavigatorRoute(loggedFood: loggedFood),
      );
    }
  }

  Future<void> getLoggedFoodsByMeals() async {
    tryCatch(
      context,
      () => context.read<MealDetailsViewModel>().getLoggedFoodsByMeals(
            selectedDate: widget.selectedDate,
            mealType: widget.mealType.value,
          ),
    );
  }

  MealRatioModel? _getMealRatioModel(MealType mealType) {
    final userPlan = SharedPreferenceHandler().getPlan();
    if (userPlan == null) return null;

    switch (mealType) {
      case MealType.breakfast:
        return userPlan.breakfast;
      case MealType.lunch:
        return userPlan.lunch;
      case MealType.dinner:
        return userPlan.dinner;
      case MealType.snack:
        return userPlan.snack;
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MealDetailsPageState {
  // Header Container
  Widget getHeaderContainer(MealRatioModel? mealRatio, Map<String, int> totalNutrition) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      padding: AppStyles.kPaddSH20,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDateLabel(),
          AppStyles.kSizedBoxH4,
          getMealTypeLabel(),
          AppStyles.kSizedBoxH24,
          Padding(
            padding: AppStyles.kPaddSH16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppStyles.kSpac32,
              children: [
                getCalorieCircularProgressIndicator(mealRatio, totalNutrition),
                getMacronutrientsIntakeProgressColumn(mealRatio, totalNutrition),
              ],
            ),
          ),
          AppStyles.kSizedBoxH20,
        ],
      ),
    );
  }

  // Macronutrients Intake Progress Column
  Widget getMacronutrientsIntakeProgressColumn(MealRatioModel? mealRatio, Map<String, int> totalNutrition) {
    return Expanded(
      child: Column(
        spacing: AppStyles.kSpac20,
        children: [
          MealMacronutrientIntakeProgress(
            macroNutrient: MacroNutrients.protein,
            percentage: (totalNutrition[Nutrition.protein.key] ?? 0) / (mealRatio?.proteinG ?? 1),
            currentValue: totalNutrition[Nutrition.protein.key] ?? 0,
            targetValue: mealRatio?.proteinG?.toInt() ?? 0,
          ),
          MealMacronutrientIntakeProgress(
            macroNutrient: MacroNutrients.carbs,
            percentage: (totalNutrition[Nutrition.carbs.key] ?? 0) / (mealRatio?.carbsG ?? 1),
            currentValue: totalNutrition[Nutrition.carbs.key] ?? 0,
            targetValue: mealRatio?.carbsG?.toInt() ?? 0,
          ),
          MealMacronutrientIntakeProgress(
            macroNutrient: MacroNutrients.fat,
            percentage: (totalNutrition[Nutrition.fat.key] ?? 0) / (mealRatio?.fatG ?? 1),
            currentValue: totalNutrition[Nutrition.fat.key] ?? 0,
            targetValue: mealRatio?.fatG?.toInt() ?? 0,
          ),
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

  // Date Label
  Widget getDateLabel() {
    return Row(
      spacing: AppStyles.kSpac4,
      children: [
        FaIcon(FontAwesomeIcons.calendarDay, size: AppStyles.kSize12),
        Text(
          DateTime.now().toFormattedString(DateFormat.YEAR_ABBR_MONTH_DAY),
          style: _Styles.getDateLabelTextStyle(context),
        ),
      ],
    );
  }

  // Calorie Circular Progress Indicator
  Widget getCalorieCircularProgressIndicator(MealRatioModel? mealRatio, Map<String, int> totalNutrition) {
    final int remaining = (mealRatio?.calorieKcal?.toInt() ?? 0) - (totalNutrition[Nutrition.calorie.key] ?? 0);

    return CircularPercentIndicator(
      lineWidth: AppStyles.kSize7,
      radius: AppStyles.kSize64,
      percent: (mealRatio?.calorieKcal ?? 0) > 0
          ? ((totalNutrition[Nutrition.calorie.key] ?? 0) / (mealRatio?.calorieKcal ?? 1)).clamp(0, 1)
          : 0,
      progressColor: context.theme.colorScheme.secondary,
      backgroundColor: context.theme.colorScheme.tertiary,
      center: getCalorieCircularCenterLabel(remaining),
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animateFromLastPercent: true,
      animateToInitialPercent: true,
    );
  }

  // Calorie Circular Center Label
  Widget getCalorieCircularCenterLabel(int remaining) {
    final isOverTarget = remaining < 0;
    final displayValue = isOverTarget ? '+${remaining.abs()}' : '$remaining';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          displayValue,
          style: _Styles.getRemainingValueLabelTextStyle(context),
        ),
        Text(
          isOverTarget ? S.current.surplusLabel : S.current.remainingLabel,
          style: _Styles.getRemainingLabelTextStyle(context),
        ),
        AppStyles.kSizedBoxH4
      ],
    );
  }

// Logged Meals
  Widget getLoggedMeals(List<LoggedFoodModel> loggedFoodsList, bool isLoading) {
    return Padding(
      padding: AppStyles.kPaddSV12H16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.current.loggedMealsLabel.toUpperCase(), style: _Styles.getMealsLoggedLabelTextStyle(context)),
              Container(
                padding: AppStyles.kPadd6,
                decoration: BoxDecoration(color: context.theme.colorScheme.secondary, shape: BoxShape.circle),
                child:
                    FaIcon(FontAwesomeIcons.add, color: context.theme.colorScheme.onSecondary, size: AppStyles.kSize16),
              )
            ],
          ),
          if (isLoading) ...[
            const MealDetailsFoodListSkeleton(),
          ] else if (loggedFoodsList.isEmpty) ...[
            AppStyles.kSizedBoxH24,
            EmptyResult(
              title: S.current.noMealsLoggedLabel,
              message: S.current.noMealsLoggedDesc,
              imagePath: ImagePath.pizza,
            )
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loggedFoodsList.length,
              separatorBuilder: (_, __) => AppStyles.kSizedBoxH12,
              itemBuilder: (context, index) {
                final meal = loggedFoodsList[index];
                return MealDetailsFoodDisplayCard(
                  meal: meal,
                  onLoggedFoodTap: () {
                    _onLoggedFoodTap(meal, context);
                  },
                );
              },
            ),
          ]
        ],
      ),
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
  static TextStyle getRemainingValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Formula Label Text Style
  static TextStyle getRemainingLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Meal Type Label Text Style
  static TextStyle getMealTypeLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.mediumHuge);
  }

  // Date Label Text Style
  static TextStyle getDateLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall);
  }

  // Meals Logged Label Text Style
  static TextStyle getMealsLoggedLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withCustomSize(11);
  }
}
