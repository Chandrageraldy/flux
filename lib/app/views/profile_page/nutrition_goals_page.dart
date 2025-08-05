import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/body_metrics_model/body_metrics_model.dart';
import 'package:flux/app/models/plan_question_model/plan_question_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/nutrition_goals_vm/nutrition_goals_view_model.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NutritionGoalsPage extends StatelessWidget {
  const NutritionGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => NutritionGoalsViewModel(), child: _NutritionGoalsPage());
  }
}

class _NutritionGoalsPage extends BaseStatefulPage {
  @override
  State<_NutritionGoalsPage> createState() => _NutritionGoalsPageState();
}

class _NutritionGoalsPageState extends BaseStatefulState<_NutritionGoalsPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  Widget body() {
    final nutritionGoals = context.select((NutritionGoalsViewModel vm) => vm.nutritionGoals);
    final energyTarget = nutritionGoals[NutritionGoalsSettings.energyTarget.key] ?? '';
    final proteinRatio = nutritionGoals[NutritionGoalsSettings.proteinRatio.key] ?? '';
    final carbsRatio = nutritionGoals[NutritionGoalsSettings.carbsRatio.key] ?? '';
    final fatRatio = nutritionGoals[NutritionGoalsSettings.fatRatio.key] ?? '';
    final totalRatio = nutritionGoals[NutritionGoalsSettings.totalRatio.key] ?? '';
    final dietType = nutritionGoals[NutritionGoalsSettings.dietType.key] ?? '';

    return Column(
      spacing: AppStyles.kSpac12,
      children: [
        getCustomAppBar(),
        getEnergyTargetContainer(energyTarget),
        getEnergyTargetBreakdownContainer(),
        getMacronutrientRatioContainer(energyTarget, proteinRatio, carbsRatio, fatRatio, totalRatio, dietType),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _NutritionGoalsPageState {
  void _onMacroRatioChanged(String? value, NutritionGoalsSettings settings) {
    context.read<NutritionGoalsViewModel>().onMacroRatioChanged(settings.key, value ?? '');
  }

  void _onDietTypeChanged(String? value, NutritionGoalsSettings settings) {
    Map<String, double> macroRatio = FunctionUtils.getMacroRatio(value ?? '');
    context.read<NutritionGoalsViewModel>().onDietTypeChanged(settings.key, value ?? '', macroRatio);

    // Update the form fields with the new macro ratios based on the selected diet type
    _formKey.currentState?.fields[FormFields.proteinRatio.name]
        ?.didChange(macroRatio[NutritionGoalsSettings.proteinRatio.key]?.toStringAsFixed(0));
    _formKey.currentState?.fields[FormFields.carbsRatio.name]
        ?.didChange(macroRatio[NutritionGoalsSettings.carbsRatio.key]?.toStringAsFixed(0));
    _formKey.currentState?.fields[FormFields.fatRatio.name]
        ?.didChange(macroRatio[NutritionGoalsSettings.fatRatio.key]?.toStringAsFixed(0));
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _NutritionGoalsPageState {
  double calculateBMR() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;
    final String gender = bodyMetrics?.gender ?? 'male';
    final double weight = double.tryParse(bodyMetrics?.weight ?? '0') ?? 0;
    final double height = double.tryParse(bodyMetrics?.height ?? '0') ?? 0;
    final dob = bodyMetrics?.dob?.toDateTime(DateFormat.YEAR_MONTH_DAY);
    final int age = FunctionUtils.calculateAge(dob ?? DateTime.now());

    if (gender == PlanSelectionValue.male.value) {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double calculateBaselineActivity() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;
    final activityFactor = FunctionUtils.getActivityFactor(bodyMetrics?.activityLevel ?? '');
    final exerciseFactor = FunctionUtils.getExerciseFactor(bodyMetrics?.exerciseLevel ?? '');

    final baselineActivity = (calculateBMR() * (activityFactor + exerciseFactor)) - calculateBMR();
    return baselineActivity;
  }

  double calculateTdee() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;
    final activityFactor = FunctionUtils.getActivityFactor(bodyMetrics?.activityLevel ?? '');
    final exerciseFactor = FunctionUtils.getExerciseFactor(bodyMetrics?.exerciseLevel ?? '');

    return calculateBMR() * (activityFactor + exerciseFactor);
  }

  double calculateAdjustmentBasedOnWeightGoal() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;
    final double adjustmentBasedOnWeightGoal = FunctionUtils.adjustCaloriesForTargetWeeklyGain(
          tdee: calculateTdee(),
          targetWeeklyGain: double.tryParse(bodyMetrics?.targetWeeklyGain?.toString() ?? '0') ?? 0,
        ) -
        calculateBMR() -
        calculateBaselineActivity();
    return adjustmentBasedOnWeightGoal;
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _NutritionGoalsPageState {
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
      trailingButton: AppStyles.kEmptyWidget,
      title: S.current.nutritionGoalsLabel,
    );
  }

  // Energy Target Container
  Widget getEnergyTargetContainer(String energyTarget) {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        width: AppStyles.kDoubleInfinity,
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getEnergyTargetContainerDecoration(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getEnergyTargetLabel(),
            Spacer(),
            getEnergyTargetValue(energyTarget),
          ],
        ),
      ),
    );
  }

  // Energy Target Label
  Widget getEnergyTargetLabel() {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.current.energyTargetLabel, style: _Styles.getEnergyTargetLabelTextStyle(context)),
          Text(S.current.energyTargetDesc, style: _Styles.getEnergyTargetDescLabelTextStyle(context)),
        ],
      ),
    );
  }

  // Energy Target Value
  Widget getEnergyTargetValue(String energyTarget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(energyTarget, style: Quicksand.medium.withSize(FontSizes.large)),
        Text(NutritionUnit.kcal.label, style: _Styles.getEnergyTargetUnitLabelTextStyle(context)),
      ],
    );
  }

  // Energy Target Breakdown Container
  Widget getEnergyTargetBreakdownContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getEnergyTargetBreakdownContainerDecoration(context),
        child: getEnergyTargetBreakdownColumn(),
      ),
    );
  }

  // Energy Target Breakdown Column
  Widget getEnergyTargetBreakdownColumn() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;

    final String bmr = calculateBMR().toStringAsFixed(0);
    final String baselineActivity = calculateBaselineActivity().toStringAsFixed(0);
    final String adjustmentBasedOnWeightGoal = calculateAdjustmentBasedOnWeightGoal().toStringAsFixed(0);
    final String energyTarget =
        (calculateBMR() + calculateBaselineActivity() + calculateAdjustmentBasedOnWeightGoal()).toStringAsFixed(0);

    return Column(
      spacing: AppStyles.kSpac4,
      children: [
        getEnergyTargetBreakdownRow(S.current.basalMetabolicRateLabel, bmr, hasInfoIcon: true),
        getEnergyTargetBreakdownRow(S.current.baselineActivityLabel, baselineActivity, hasInfoIcon: true),
        // If goal is maintain, do not show adjustment based on weight goal
        if (bodyMetrics?.goal != PlanSelectionValue.maintain.value)
          getEnergyTargetBreakdownRow(S.current.adjustmentBasedOnWeightGoalLabel, adjustmentBasedOnWeightGoal,
              hasInfoIcon: true),
        getEnergyTargetBreakdownRow(S.current.energyTargetLabel, '= $energyTarget ${NutritionUnit.kcal.label}',
            isBold: true),
      ],
    );
  }

  // Energy Target Breakdown Row
  Widget getEnergyTargetBreakdownRow(String label, String value, {bool isBold = false, bool hasInfoIcon = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: AppStyles.kSpac4,
          children: [
            if (hasInfoIcon)
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.info_outline, size: AppStyles.kSize16, color: context.theme.colorScheme.secondary),
              ),
            Text(label, style: _Styles.getEnergyTargetBreakdownLabelTextStyle(context, isBold)),
          ],
        ),
        Text(value, style: _Styles.getEnergyTargetBreakdownLabelTextStyle(context, isBold))
      ],
    );
  }

// Macronutrient Ratio Container
  Widget getMacronutrientRatioContainer(
    String energyTarget,
    String proteinRatio,
    String carbsRatio,
    String fatRatio,
    String totalRatio,
    String dietType,
  ) {
    final totalCalories = double.tryParse(energyTarget) ?? 0;
    final ratios = {
      MacroNutrients.protein: double.tryParse(proteinRatio) ?? 0,
      MacroNutrients.carbs: double.tryParse(carbsRatio) ?? 0,
      MacroNutrients.fat: double.tryParse(fatRatio) ?? 0,
    };

    final isValidRatio = totalRatio == '100';

    Widget getMacroRow(MacroNutrients macro) => getMacroNutrientRationRow(
          macro,
          isValidRatio
              ? FunctionUtils.getMacronutrientValueInGrams(
                  totalCalories: totalCalories,
                  ratio: ratios[macro]!,
                  macro: macro,
                )
              : '-',
          ratios[macro]!,
          isValidRatio
              ? FunctionUtils.getMacronutrientValueInKcal(
                  totalCalories: totalCalories,
                  ratio: ratios[macro]!,
                )
              : '-',
          dietType,
        );

    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Container(
          padding: AppStyles.kPaddSV12H16,
          decoration: _Styles.getEnergyTargetContainerDecoration(context),
          child: Column(
            children: [
              getDietTypeContainer(dietType),
              getDivider(context),
              getMacroRow(MacroNutrients.protein),
              getDivider(context),
              getMacroRow(MacroNutrients.carbs),
              getDivider(context),
              getMacroRow(MacroNutrients.fat),
              getDivider(context),
              getTotalPercentEnergyRow(totalRatio),
            ],
          ),
        ),
      ),
    );
  }

  // Total Percent Energy Row
  Widget getTotalPercentEnergyRow(String totalRatio) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(S.current.percentTotalEnergyLabel, style: _Styles.getPercentTotalEnergyLabelTextStyle()),
        Text('$totalRatio%', style: _Styles.getPercentTotalEnergyValueTextStyle(totalRatio)),
      ],
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

  // Diet Type Container
  Widget getDietTypeContainer(String dietType) {
    return Row(
      spacing: AppStyles.kSpac12,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.current.dietTypeLabel, style: _Styles.getEnergyTargetLabelTextStyle(context)),
              Text(S.current.dietTypeDesc, style: _Styles.getEnergyTargetDescLabelTextStyle(context)),
            ],
          ),
        ),
        Expanded(
          child: getCustomFormBuilderDropDown(
            context,
            FormFields.dietType,
            NutritionGoalsSettings.dietType,
            dietType,
          ),
        ),
      ],
    );
  }

  // Macronutrient Ratio Row
  Widget getMacroNutrientRationRow(
      MacroNutrients macroNutrient, String valueInGrams, double ratio, String valueInKcal, String dietType) {
    final nutritionGoalsSettings = {
      MacroNutrients.protein: NutritionGoalsSettings.proteinRatio,
      MacroNutrients.carbs: NutritionGoalsSettings.carbsRatio,
      MacroNutrients.fat: NutritionGoalsSettings.fatRatio,
    }[macroNutrient]!;

    final formField = {
      MacroNutrients.protein: FormFields.proteinRatio,
      MacroNutrients.carbs: FormFields.carbsRatio,
      MacroNutrients.fat: FormFields.fatRatio,
    }[macroNutrient]!;

    return Row(
      spacing: AppStyles.kSpac12,
      children: [
        Container(
          height: AppStyles.kSize12,
          width: AppStyles.kSize12,
          decoration: _Styles.getMacronutrientColorContainerDecoration(macroNutrient),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(macroNutrient.label, style: _Styles.getMacronutrientLabelTextStyle()),
            Text('$valueInGrams ${NutritionUnit.g.label} | $valueInKcal ${NutritionUnit.kcal.label}',
                style: _Styles.getMacronutrientValueLabelTextStyle()),
          ],
        ),
        Spacer(),
        Row(
          spacing: AppStyles.kSpac4,
          children: [
            getCustomFormBuilderTextField(
              context,
              formField,
              nutritionGoalsSettings,
              dietType,
              ratio,
              width: AppStyles.kSize40,
            ),
            Text('%', style: _Styles.getPercentLabelTextStyle()),
          ],
        )
      ],
    );
  }

  // Custom Form Builder Drop Down
  Widget getCustomFormBuilderDropDown(
    BuildContext context,
    FormFields field,
    NutritionGoalsSettings settings,
    String initialValue, {
    double? height,
    double? width,
  }) {
    return Container(
      padding: AppStyles.kPaddSH6,
      height: height,
      width: width,
      decoration: _Styles.getFieldContainerDecoration(context, true),
      child: FormBuilderDropdown<String>(
        name: field.name,
        initialValue: initialValue,
        items: [
          DropdownMenuItem(value: PlanSelectionValue.balanced.value, child: Text(S.current.balancedLabel)),
          DropdownMenuItem(value: PlanSelectionValue.keto.value, child: Text(S.current.ketoLabel)),
          DropdownMenuItem(value: PlanSelectionValue.mediterranean.value, child: Text(S.current.mediterraneanLabel)),
          DropdownMenuItem(value: PlanSelectionValue.paleo.value, child: Text(S.current.paleoLabel)),
          DropdownMenuItem(value: PlanSelectionValue.vegetarian.value, child: Text(S.current.vegetarianLabel)),
          DropdownMenuItem(value: PlanSelectionValue.lowCarbs.value, child: Text(S.current.lowCarbsLabel)),
          DropdownMenuItem(value: PlanSelectionValue.custom.value, child: Text(S.current.customLabel)),
        ],
        style: _Styles.getCustomFormBuilderDropDownTextStyle(context),
        decoration: _Styles.getFieldInputDecoration(),
        onChanged: (value) {
          _onDietTypeChanged(value, settings);
        },
      ),
    );
  }

  // Custom Form Builder Text Field
  Widget getCustomFormBuilderTextField(
    BuildContext context,
    FormFields field,
    NutritionGoalsSettings settings,
    String dietType,
    double initialValue, {
    double? height,
    double? width,
  }) {
    final isEnabled = dietType == PlanSelectionValue.custom.value;

    return Container(
      padding: AppStyles.kPaddSH6,
      height: height,
      width: width,
      decoration: _Styles.getFieldContainerDecoration(context, isEnabled),
      child: FormBuilderTextField(
        enabled: isEnabled,
        initialValue: initialValue.toStringAsFixed(0),
        name: field.name,
        style: _Styles.getCustomFormBuilderTextFieldLabelTextStyle(context),
        decoration: _Styles.getFieldInputDecoration(),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _onMacroRatioChanged(value, settings);
        },
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
class _Styles {
  // Energy Target Container Decoration
  static BoxDecoration getEnergyTargetContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Energy Target Label Text Style
  static TextStyle getEnergyTargetLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Energy Target Desc Label Text Style
  static TextStyle getEnergyTargetDescLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Energy Target Unit Label Text Style
  static TextStyle getEnergyTargetUnitLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall).copyWith(height: 1);
  }

  // Energy Target Text Field Container Decoration
  static BoxDecoration getFieldContainerDecoration(BuildContext context, bool isEnabled) {
    return BoxDecoration(
      color: isEnabled ? context.theme.colorScheme.tertiaryFixedDim : AppColors.transparentColor,
      borderRadius: AppStyles.kRad8,
    );
  }

  // Text Field Input Decoration
  static InputDecoration getFieldInputDecoration() {
    return InputDecoration(border: InputBorder.none, isDense: true, contentPadding: AppStyles.kPaddOL4T6B6);
  }

  // Energy Target Breakdown Container Decoration
  static BoxDecoration getEnergyTargetBreakdownContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad10,
      border: Border.all(color: context.theme.colorScheme.tertiaryFixedDim, width: 1),
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Energy Target Breakdown Label Text Style
  static TextStyle getEnergyTargetBreakdownLabelTextStyle(BuildContext context, bool isBold) {
    return isBold ? Quicksand.bold.withSize(FontSizes.extraSmall) : Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Macronutrient Color Container Decoration
  static BoxDecoration getMacronutrientColorContainerDecoration(MacroNutrients macroNutrient) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: macroNutrient.color,
    );
  }

  // Macronutrient Label Text Style
  static TextStyle getMacronutrientLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Macronutrient Value Label Text Style
  static TextStyle getMacronutrientValueLabelTextStyle() {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Percent Label Text Style
  static TextStyle getPercentLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Custom Form Builder Text Field Label Text Style
  static TextStyle getCustomFormBuilderTextFieldLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Percent Total Energy Label Text Style
  static TextStyle getPercentTotalEnergyLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Percent Total Energy Value Text Style
  static TextStyle getPercentTotalEnergyValueTextStyle(String totalRatio) {
    final total = double.tryParse(totalRatio) ?? 0;
    final isValid = total == 100;

    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: isValid ? null : AppColors.redColor);
  }

  // Custom Form Builder Drop Down Text Style
  static TextStyle getCustomFormBuilderDropDownTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiary);
  }
}
