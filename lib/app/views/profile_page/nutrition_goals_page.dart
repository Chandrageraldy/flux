import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/viewmodels/nutrition_goals_vm/nutrition_goals_view_model.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    return Column(
      spacing: AppStyles.kSpac12,
      children: [
        AppStyles.kEmptyWidget,
        getCustomAppBar(),
        getEnergyTargetContainer(energyTarget),
        getEnergyTargetBreakdownContainer(),
        getMacronutrientRatioContainer(proteinRatio, carbsRatio, fatRatio),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _NutritionGoalsPageState {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _NutritionGoalsPageState {}

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
          spacing: AppStyles.kSpac12,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.current.energyTargetLabel, style: _Styles.getEnergyTargetLabelTextStyle(context)),
                  Text(S.current.energyTargetDesc, style: _Styles.getEnergyTargetDescLabelTextStyle(context)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                spacing: AppStyles.kSpac8,
                children: [
                  Expanded(
                    flex: 1,
                    child: getCustomFormBuilderTextField(context, FormFields.energyTarget, energyTarget),
                  ),
                  Text(NutritionUnit.kcal.label, style: _Styles.getEnergyTargetUnitLabelTextStyle(context)),
                ],
              ),
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
            getEnergyTargetBreakdownRow(S.current.basalMetabolicRateLabel, '1650', hasInfoIcon: true),
            getEnergyTargetBreakdownRow(S.current.totalDailyEnergyExpenditureLabel, '350', hasInfoIcon: true),
            getEnergyTargetBreakdownRow(
              S.current.energyTargetLabel,
              '= 2000 ${NutritionUnit.kcal.label}',
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
  Widget getMacronutrientRatioContainer(String proteinRatio, String carbsRatio, String fatRatio) {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getEnergyTargetContainerDecoration(context),
        child: Column(
          children: [
            getDietTypeContainer(),
            getDivider(context),
            getMacroNutrientRationRow(MacroNutrients.protein, '124', proteinRatio),
            getDivider(context),
            getMacroNutrientRationRow(MacroNutrients.carbs, '225', carbsRatio),
            getDivider(context),
            getMacroNutrientRationRow(MacroNutrients.fat, '66', fatRatio),
            getDivider(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.current.percentTotalEnergyLabel, style: _Styles.getPercentTotalEnergyLabelTextStyle()),
                Text('100%', style: _Styles.getPercentTotalEnergyValueTextStyle()),
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
        Expanded(flex: 1, child: getCustomFormBuilderTextField(context, FormFields.energyTarget, '')),
      ],
    );
  }

  // Macronutrient Ratio Row
  Widget getMacroNutrientRationRow(MacroNutrients macroNutrient, String value, String ratio) {
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
            Text('$value ${NutritionUnit.g.label}', style: _Styles.getMacronutrientValueLabelTextStyle()),
          ],
        ),
        Spacer(),
        Row(
          spacing: AppStyles.kSpac4,
          children: [
            getCustomFormBuilderTextField(context, FormFields.email, ratio, width: AppStyles.kSize40),
            Text('%', style: _Styles.getPercentLabelTextStyle()),
          ],
        )
      ],
    );
  }

  // Custom Form Builder Text Field
  static Widget getCustomFormBuilderTextField(
    BuildContext context,
    FormFields field,
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
    return Quicksand.bold.withSize(FontSizes.small);
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
    return Quicksand.semiBold.withSize(FontSizes.medium);
  }

  // Custom Form Builder Text Field Label Text Style
  static TextStyle getCustomFormBuilderTextFieldLabelTextStyle() {
    return Quicksand.medium.withSize(FontSizes.medium);
  }

  // Percent Total Energy Label Text Style
  static TextStyle getPercentTotalEnergyLabelTextStyle() {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Percent Total Energy Value Text Style
  static TextStyle getPercentTotalEnergyValueTextStyle() {
    return Quicksand.medium.withSize(FontSizes.small);
  }
}
