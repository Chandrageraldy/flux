import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/meal_ratio_vm/meal_ratio_view_model.dart';
import 'package:flux/app/views/personalizing_plan_loading_page/personalizing_plan_loading_page.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class MealRatioPage extends StatelessWidget {
  const MealRatioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => MealRatioViewModel(), child: _MealRatioPage());
  }
}

class _MealRatioPage extends BaseStatefulPage {
  @override
  State<_MealRatioPage> createState() => _MealRatioPageState();
}

class _MealRatioPageState extends BaseStatefulState<_MealRatioPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    final mealRatio = context.select((MealRatioViewModel vm) => vm.mealRatio);
    final breakfastRatio = mealRatio[MealRatioSettings.breakfastRatio.key] ?? '';
    final lunchRatio = mealRatio[MealRatioSettings.lunchRatio.key] ?? '';
    final dinnerRatio = mealRatio[MealRatioSettings.dinnerRatio.key] ?? '';
    final snackRatio = mealRatio[MealRatioSettings.snackRatio.key] ?? '';
    final totalRatio = mealRatio[MealRatioSettings.totalRatio.key] ?? '';

    return Column(
      children: [
        getCustomAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: AppStyles.kPaddSV16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppStyles.kSpac12,
              children: [
                getMealRatioContainer(breakfastRatio, lunchRatio, dinnerRatio, snackRatio, totalRatio),
                getNutrientInfoContainer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MealRatioPageState {
  void onMealRatioChanged(String key, String? value) {
    context.read<MealRatioViewModel>().onMealRatioChanged(key, value ?? '');
  }

  Future<void> _onSavePressed() async {
    final mealRatio = context.read<MealRatioViewModel>().mealRatio;
    if (mealRatio[MealRatioSettings.totalRatio.key] == '100') {
      context.router.replaceAll([PersonalizingPlanLoadingRoute(planAction: PlanAction.UPDATE, mealRatio: mealRatio)]);
    } else {
      WidgetUtils.showSnackBar(context, S.current.ratioError);
      return;
    }
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _MealRatioPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealRatioPageState {
  // Custom App Bar
  Widget getCustomAppBar() {
    return CustomAppBar(
      leadingButton: CustomAppBarTappable(
        icon: FontAwesomeIcons.chevronLeft,
        color: context.theme.colorScheme.primary,
        label: S.current.profileLabel,
        modalSheetBarTappablePosition: CustomAppBarTappablePosition.LEADING,
        onTap: () => context.router.maybePop(),
      ),
      trailingButton: GestureDetector(
        onTap: _onSavePressed,
        child: Text(
          S.current.saveLabel,
          style: Quicksand.bold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.secondary),
        ),
      ),
      title: S.current.mealRatioLabel,
    );
  }

  // Nutrient Info Container
  Widget getNutrientInfoContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getNutrientInfoContainerDecoration(context),
        child: getNutrientInfoColumn(),
      ),
    );
  }

  // Nutrient Info Column
  Widget getNutrientInfoColumn() {
    final PlanModel? plan = SharedPreferenceHandler().getPlan();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac4,
      children: [
        Text(S.current.energyTargetLabel, style: _Styles.getTargetLabelTextStyle(context)),
        getNutrientInfoRow(
            Nutrition.calorie.label, '${plan?.calorieKcal?.toStringAsFixed(0)} ${NutritionUnit.kcal.label}'),
        Text(S.current.macroNutrientsTargetLabel, style: _Styles.getTargetLabelTextStyle(context)),
        getNutrientInfoRow(Nutrition.protein.label, '${plan?.proteinG?.toStringAsFixed(0)} ${NutritionUnit.g.label}'),
        getNutrientInfoRow(Nutrition.carbs.label, '${plan?.carbsG?.toStringAsFixed(0)} ${NutritionUnit.g.label}'),
        getNutrientInfoRow(Nutrition.fat.label, '${plan?.fatG?.toStringAsFixed(0)} ${NutritionUnit.g.label}'),
      ],
    );
  }

  // Nutrient Info Row
  Widget getNutrientInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _Styles.getNutrientInfoLabelTextStyle(context)),
        Text(value, style: _Styles.getNutrientInfoValueTextStyle(context))
      ],
    );
  }

  Map<String, dynamic> getMealDistribution(
    String breakfastRatio,
    String lunchRatio,
    String dinnerRatio,
    String snackRatio,
  ) {
    final PlanModel? plan = SharedPreferenceHandler().getPlan();

    final breakfastRatioDouble = (double.tryParse(breakfastRatio) ?? 0) / 100;
    final lunchRatioDouble = (double.tryParse(lunchRatio) ?? 0) / 100;
    final dinnerRatioDouble = (double.tryParse(dinnerRatio) ?? 0) / 100;
    final snackRatioDouble = (double.tryParse(snackRatio) ?? 0) / 100;

    Map<String, dynamic> buildMeal(
      double ratio,
    ) {
      return {
        Nutrition.calorie.key: (plan?.calorieKcal ?? 0) * ratio,
        Nutrition.protein.key: (plan?.proteinG ?? 0) * ratio,
        Nutrition.carbs.key: (plan?.carbsG ?? 0) * ratio,
        Nutrition.fat.key: (plan?.fatG ?? 0) * ratio,
      };
    }

    return {
      MealRatioSettings.breakfastRatio.key: buildMeal(breakfastRatioDouble),
      MealRatioSettings.lunchRatio.key: buildMeal(lunchRatioDouble),
      MealRatioSettings.dinnerRatio.key: buildMeal(dinnerRatioDouble),
      MealRatioSettings.snackRatio.key: buildMeal(snackRatioDouble),
    };
  }

  Widget getMealRatioContainer(
    String breakfastRatio,
    String lunchRatio,
    String dinnerRatio,
    String snackRatio,
    String totalRatio,
  ) {
    final Map<String, dynamic> mealDistribution = getMealDistribution(
      breakfastRatio,
      lunchRatio,
      dinnerRatio,
      snackRatio,
    );

    Map<String, dynamic> getMeal(String key) {
      return mealDistribution[key] ??
          {
            Nutrition.calorie.key: 0,
            Nutrition.protein.key: 0,
            Nutrition.carbs.key: 0,
            Nutrition.fat.key: 0,
          };
    }

    Widget getMealRow(
      String label,
      String ratio,
      FormFields field,
      MealRatioSettings setting,
    ) {
      final meal = getMeal(setting.key);
      return getMealRatioRow(
        label,
        (meal[Nutrition.calorie.key] as double).toStringAsFixed(0),
        '${(meal[Nutrition.protein.key] as double).toStringAsFixed(0)} ${NutritionUnit.g.label}',
        '${(meal[Nutrition.carbs.key] as double).toStringAsFixed(0)} ${NutritionUnit.g.label}',
        '${(meal[Nutrition.fat.key] as double).toStringAsFixed(0)} ${NutritionUnit.g.label}',
        double.tryParse(ratio) ?? 0,
        field,
        setting,
      );
    }

    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Container(
          width: AppStyles.kDoubleInfinity,
          padding: AppStyles.kPaddSV12H16,
          decoration: _Styles.getMealRatioContainerDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getMealRatioLabel(),
              getMealRatioDesc(),
              getDivider(context),
              getMealRow(MealType.breakfast.label, breakfastRatio, FormFields.breakfastRatio,
                  MealRatioSettings.breakfastRatio),
              getDivider(context),
              getMealRow(MealType.lunch.label, lunchRatio, FormFields.lunchRatio, MealRatioSettings.lunchRatio),
              getDivider(context),
              getMealRow(MealType.dinner.label, dinnerRatio, FormFields.dinnerRatio, MealRatioSettings.dinnerRatio),
              getDivider(context),
              getMealRow(MealType.snack.label, snackRatio, FormFields.snackRatio, MealRatioSettings.snackRatio),
              getDivider(context),
              getTotalPercentRow(totalRatio),
            ],
          ),
        ),
      ),
    );
  }

  // Meal Ratio Label
  Widget getMealRatioLabel() {
    return Text(S.current.mealRatioLabel, style: _Styles.getMealRatioLabelTextStyle(context));
  }

  // Meal Ratio Desc
  Widget getMealRatioDesc() {
    return Text(S.current.mealRatioDesc2, style: _Styles.getMealRatioDescTextStyle(context));
  }

  // Meal Ratio Row
  Widget getMealRatioRow(
    String label,
    String calorie,
    String protein,
    String carbs,
    String fat,
    double ratio,
    FormFields formField,
    MealRatioSettings settings,
  ) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: _Styles.getMealLabelTextStyle(context)),
            Row(
              spacing: AppStyles.kSpac4,
              children: [
                NutritionTag(label: protein, tag: MacroNutrients.protein.tag),
                NutritionTag(label: carbs, tag: MacroNutrients.carbs.tag),
                NutritionTag(label: fat, tag: MacroNutrients.fat.tag),
              ],
            ),
          ],
        ),
        Spacer(),
        Row(
          spacing: AppStyles.kSpac4,
          children: [
            Text('$calorie ${NutritionUnit.kcal.label}', style: _Styles.getMealLabelTextStyle(context)),
            getFormBuilderTextField(context, formField, settings, ratio, width: AppStyles.kSize40),
            Text('%', style: _Styles.getPercentLabelTextStyle()),
          ],
        )
      ],
    );
  }

  // Form Builder Text Field
  Widget getFormBuilderTextField(
    BuildContext context,
    FormFields field,
    MealRatioSettings settings,
    double initialValue, {
    double? height,
    double? width,
  }) {
    return Container(
      padding: AppStyles.kPaddSH6,
      height: height,
      width: width,
      decoration: _Styles.getFieldContainerDecoration(context),
      child: FormBuilderTextField(
        initialValue: initialValue.toStringAsFixed(0),
        name: field.name,
        style: _Styles.getFormBuilderTextFieldLabelTextStyle(context),
        decoration: _Styles.getFieldInputDecoration(),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          onMealRatioChanged(settings.key, value);
        },
      ),
    );
  }

  // Divider
  Widget getDivider(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSV10,
      child: Divider(
        height: 1,
        color: context.theme.colorScheme.tertiaryFixedDim,
      ),
    );
  }

  // Total Percent Row
  Widget getTotalPercentRow(String totalRatio) {
    final totalRatioDouble = double.tryParse(totalRatio) ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.current.percentOfTotalMealRatioLabel, style: _Styles.getPercentTotalLabelTextStyle()),
            Text('$totalRatio%', style: _Styles.getPercentTotalValueTextStyle(totalRatio)),
          ],
        ),
        if (totalRatioDouble != 100)
          Text(S.current.ratioErrorMessage, style: _Styles.getRatioErrorMessageLabelTextStyle(context))
      ],
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Meal Ratio Container Decoration
  static BoxDecoration getMealRatioContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Meal Ratio Label Text Style
  static TextStyle getMealRatioLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Meal Ratio Desc Text Style
  static TextStyle getMealRatioDescTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Meal Label Text Style
  static TextStyle getMealLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Energy Target Text Field Container Decoration
  static BoxDecoration getFieldContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.tertiaryFixedDim, borderRadius: AppStyles.kRad8);
  }

  // Form Builder Text Field Label Text Style
  static TextStyle getFormBuilderTextFieldLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Text Field Input Decoration
  static InputDecoration getFieldInputDecoration() {
    return InputDecoration(border: InputBorder.none, isDense: true, contentPadding: AppStyles.kPaddOL4T6B6);
  }

  // Percent Label Text Style
  static TextStyle getPercentLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Percent Total Label Text Style
  static TextStyle getPercentTotalLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Percent Total Value Text Style
  static TextStyle getPercentTotalValueTextStyle(String totalRatio) {
    final total = double.tryParse(totalRatio) ?? 0;
    final isValid = total == 100;

    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: isValid ? null : AppColors.redColor);
  }

  // Nutrient Info Container Decoration
  static BoxDecoration getNutrientInfoContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad10,
      border: Border.all(color: context.theme.colorScheme.tertiaryFixedDim, width: 1),
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Nutrient Info Label Text Style
  static TextStyle getNutrientInfoLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small);
  }

  // Nutrient Info Value Text Style
  static TextStyle getNutrientInfoValueTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Target Label Text Style
  static TextStyle getTargetLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Ratio Error Message Label Text Style
  static TextStyle getRatioErrorMessageLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall).copyWith(color: AppColors.redColor);
  }
}
