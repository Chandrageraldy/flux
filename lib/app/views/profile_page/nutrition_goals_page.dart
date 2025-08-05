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

    return Column(
      spacing: AppStyles.kSpac12,
      children: [
        AppStyles.kEmptyWidget,
        getCustomAppBar(),
        getEnergyTargetContainer(energyTarget),
        getEnergyTargetBreakdownContainer(),
        getMacronutrientRatioContainer(energyTarget, proteinRatio, carbsRatio, fatRatio, totalRatio),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _NutritionGoalsPageState {
  void _onTextFieldSubmitted(String? value, NutritionGoalsSettings settings) {
    context.read<NutritionGoalsViewModel>().onTextFieldSubmitted(settings.key, value ?? '');
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
    final activityFactor = getActivityFactor(bodyMetrics?.activityLevel ?? '');
    final exerciseFactor = getExerciseFactor(bodyMetrics?.exerciseLevel ?? '');

    final baselineActivity = (calculateBMR() * (activityFactor + exerciseFactor)) - calculateBMR();
    return baselineActivity;
  }

  double calculateTdee() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;
    final activityFactor = getActivityFactor(bodyMetrics?.activityLevel ?? '');
    final exerciseFactor = getExerciseFactor(bodyMetrics?.exerciseLevel ?? '');

    return calculateBMR() * (activityFactor + exerciseFactor);
  }

  double getActivityFactor(String level) {
    switch (level) {
      case 'sedentary':
        return 1.2;
      case 'lightly active':
        return 1.375;
      case 'active':
        return 1.55;
      case 'very active':
        return 1.725;
      default:
        return 1.2;
    }
  }

  double getExerciseFactor(String exerciseLevel) {
    switch (exerciseLevel) {
      case 'never':
        return 0.0;
      case 'light':
        return 0.1;
      case 'moderate':
        return 0.15;
      case 'frequent':
        return 0.2;
      default:
        return 0.0;
    }
  }

  double calculateAdjustmentBasedOnWeightGoal() {
    final UserProfileModel? user = SharedPreferenceHandler().getUser();
    final BodyMetricsModel? bodyMetrics = user?.bodyMetrics;
    final double adjustmentBasedOnWeightGoal = adjustCaloriesForTargetWeeklyGain(
          tdee: calculateTdee(),
          targetWeeklyGain: double.tryParse(bodyMetrics?.targetWeeklyGain?.toString() ?? '0') ?? 0,
        ) -
        calculateBMR() -
        calculateBaselineActivity();
    return adjustmentBasedOnWeightGoal;
  }

  double adjustCaloriesForTargetWeeklyGain({
    required double tdee,
    required double targetWeeklyGain,
  }) {
    double calorieAdjustment = targetWeeklyGain * 7700 / 7;
    return tdee + calorieAdjustment;
  }

  String getMacronutrientValueInGrams({
    required double totalCalories,
    required double ratio,
    required MacroNutrients macro,
  }) {
    return ((totalCalories * (ratio / 100)) / macro.multiplier).toStringAsFixed(0);
  }

  String getMacronutrientValueInKcal({
    required double totalCalories,
    required double ratio,
  }) {
    return (totalCalories * (ratio / 100)).toStringAsFixed(0);
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
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getEnergyTargetContainerDecoration(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.current.energyTargetLabel, style: _Styles.getEnergyTargetLabelTextStyle(context)),
                  Text(S.current.energyTargetDesc, style: _Styles.getEnergyTargetDescLabelTextStyle(context)),
                ],
              ),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(energyTarget, style: Quicksand.medium.withSize(FontSizes.large)),
                Text(NutritionUnit.kcal.label, style: _Styles.getEnergyTargetUnitLabelTextStyle(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Energy Target Breakdown Container
  Widget getEnergyTargetBreakdownContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getEnergyTargetBreakdownContainerDecoration(context),
        child: Column(
          spacing: AppStyles.kSpac4,
          children: [
            getEnergyTargetBreakdownRow(
              S.current.basalMetabolicRateLabel,
              calculateBMR().toStringAsFixed(0),
              hasInfoIcon: true,
            ),
            getEnergyTargetBreakdownRow(
              S.current.baselineActivityLabel,
              calculateBaselineActivity().toStringAsFixed(0),
              hasInfoIcon: true,
            ),
            getEnergyTargetBreakdownRow(
              S.current.adjustmentBasedOnWeightGoalLabel,
              calculateAdjustmentBasedOnWeightGoal().toStringAsFixed(0),
              hasInfoIcon: true,
            ),
            getEnergyTargetBreakdownRow(
              S.current.energyTargetLabel,
              '= ${(calculateBMR() + calculateBaselineActivity() + calculateAdjustmentBasedOnWeightGoal()).toStringAsFixed(0)} ${NutritionUnit.kcal.label}',
              isBold: true,
            ),
          ],
        ),
      ),
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
  ) {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getEnergyTargetContainerDecoration(context),
        child: Column(
          children: [
            getDietTypeContainer(),
            getDivider(context),
            getMacroNutrientRationRow(
              MacroNutrients.protein,
              totalRatio == '100'
                  ? getMacronutrientValueInGrams(
                      totalCalories: double.tryParse(energyTarget) ?? 0,
                      ratio: double.tryParse(proteinRatio) ?? 0,
                      macro: MacroNutrients.protein,
                    )
                  : '-',
              proteinRatio,
              totalRatio == '100'
                  ? getMacronutrientValueInKcal(
                      totalCalories: double.tryParse(energyTarget) ?? 0,
                      ratio: double.tryParse(proteinRatio) ?? 0,
                    )
                  : '-',
            ),
            getDivider(context),
            getMacroNutrientRationRow(
              MacroNutrients.carbs,
              totalRatio == '100'
                  ? getMacronutrientValueInGrams(
                      totalCalories: double.tryParse(energyTarget) ?? 0,
                      ratio: double.tryParse(carbsRatio) ?? 0,
                      macro: MacroNutrients.carbs,
                    )
                  : '-',
              carbsRatio,
              totalRatio == '100'
                  ? getMacronutrientValueInKcal(
                      totalCalories: double.tryParse(energyTarget) ?? 0,
                      ratio: double.tryParse(carbsRatio) ?? 0,
                    )
                  : '-',
            ),
            getDivider(context),
            getMacroNutrientRationRow(
              MacroNutrients.fat,
              totalRatio == '100'
                  ? getMacronutrientValueInGrams(
                      totalCalories: double.tryParse(energyTarget) ?? 0,
                      ratio: double.tryParse(fatRatio) ?? 0,
                      macro: MacroNutrients.fat,
                    )
                  : '-',
              fatRatio,
              totalRatio == '100'
                  ? getMacronutrientValueInKcal(
                      totalCalories: double.tryParse(energyTarget) ?? 0,
                      ratio: double.tryParse(fatRatio) ?? 0,
                    )
                  : '-',
            ),
            getDivider(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.percentTotalEnergyLabel, style: _Styles.getPercentTotalEnergyLabelTextStyle(totalRatio)),
                Text('$totalRatio%', style: _Styles.getPercentTotalEnergyValueTextStyle(totalRatio)),
              ],
            )
          ],
        ),
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

  // Diet Type Container
  Widget getDietTypeContainer() {
    return Row(
      spacing: AppStyles.kSpac12,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.current.dietTypeLabel, style: _Styles.getEnergyTargetLabelTextStyle(context)),
              Text(S.current.dietTypeDesc, style: _Styles.getEnergyTargetDescLabelTextStyle(context)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: getCustomFormBuilderTextField(context, FormFields.energyTarget, NutritionGoalsSettings.dietType, ''),
        ),
      ],
    );
  }

  // Macronutrient Ratio Row
  Widget getMacroNutrientRationRow(
      MacroNutrients macroNutrient, String valueInGrams, String ratio, String valueInKcal) {
    final nutritionGoalsSettings = macroNutrient == MacroNutrients.protein
        ? NutritionGoalsSettings.proteinRatio
        : macroNutrient == MacroNutrients.carbs
            ? NutritionGoalsSettings.carbsRatio
            : NutritionGoalsSettings.fatRatio;
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
              FormFields.email,
              nutritionGoalsSettings,
              ratio,
              width: AppStyles.kSize40,
            ),
            Text('%', style: _Styles.getPercentLabelTextStyle()),
          ],
        )
      ],
    );
  }

  // Custom Form Builder Text Field
  Widget getCustomFormBuilderTextField(
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
      decoration: _Styles.textFieldContainerDecoration(context),
      child: FormBuilderTextField(
        initialValue: initialValue,
        name: field.name,
        style: _Styles.getCustomFormBuilderTextFieldLabelTextStyle(),
        decoration: _Styles.textFieldInputDecoration(),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _onTextFieldSubmitted(value, settings);
        },
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
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
  static BoxDecoration textFieldContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryFixedDim,
      borderRadius: AppStyles.kRad8,
    );
  }

  // Text Field Input Decoration
  static InputDecoration textFieldInputDecoration() {
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
  static TextStyle getCustomFormBuilderTextFieldLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Percent Total Energy Label Text Style
  static TextStyle getPercentTotalEnergyLabelTextStyle(String totalRatio) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Percent Total Energy Value Text Style
  static TextStyle getPercentTotalEnergyValueTextStyle(String totalRatio) {
    final total = double.tryParse(totalRatio) ?? 0;
    final isValid = total == 100;

    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: isValid ? null : AppColors.redColor);
  }
}
