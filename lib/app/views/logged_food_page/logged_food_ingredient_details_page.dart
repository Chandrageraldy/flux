import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/full_nutrients_model/full_nutrients_model.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/models/nutrition_mapping_model/nutrition_mapping_model.dart';
import 'package:flux/app/utils/regexp/regexp.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/logged_food_vm/meal_scan_logged_food_details_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/dropdown_form/app_dropdown_form.dart';
import 'package:flux/app/widgets/food/macronutrient_card.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class LoggedFoodIngredientDetailsPage extends BaseStatefulPage {
  const LoggedFoodIngredientDetailsPage({required this.ingredient, required this.index, super.key});

  final IngredientModel ingredient;
  final int index;

  @override
  State<LoggedFoodIngredientDetailsPage> createState() => _LoggedFoodIngredientDetailsPageState();
}

class _LoggedFoodIngredientDetailsPageState extends BaseStatefulState<LoggedFoodIngredientDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appbar() => DefaultAppBar(backgroundColor: context.theme.colorScheme.onPrimary);

  @override
  bool hasDefaultPadding() => false;

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setCurrentSelectedIngredient(widget.ingredient);
    });
  }

  @override
  Widget body() {
    final currentSelectedIngredient =
        context.select((MealScanLoggedFoodDetailsViewModel vm) => vm.currentSelectedModifiedIngredient);
    final macroNutrientPercentage = FunctionUtils.calculateMacronutrientPercentage(
      carbs: currentSelectedIngredient.carbs ?? 0.0,
      fat: currentSelectedIngredient.fat ?? 0.0,
      protein: currentSelectedIngredient.protein ?? 0.0,
    );

    final vm = context.watch<MealScanLoggedFoodDetailsViewModel>();

    if (vm.selectedAltMeasure == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        SingleChildScrollView(
          padding: AppStyles.kPaddOB70,
          child: Column(
            children: [
              getHeaderContainer(),
              Padding(
                padding: AppStyles.kPaddSV12H16,
                child: Column(
                  spacing: AppStyles.kSpac12,
                  children: [
                    getCalorieContainer(macroNutrientPercentage, currentSelectedIngredient.calorie ?? 0.0),
                    getMacronutrientsRow(macroNutrientPercentage, currentSelectedIngredient.carbs ?? 0.0,
                        currentSelectedIngredient.fat ?? 0.0, currentSelectedIngredient.protein ?? 0.0),
                    getNutritionalInfoContainer(currentSelectedIngredient.fullNutrients ?? []),
                  ],
                ),
              ),
            ],
          ),
        ),
        getSaveButton(),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _LoggedFoodIngredientDetailsPageState {
  Future<void> _onServingQtyChanged(String? selectedUnit, List<AltMeasureModel> altMeasures) async {
    final selectedMeasure = selectedUnit!.replaceAll(Regexp.removeTrailingParentheses, '').trim();
    final selectedAlt = altMeasures.firstWhere((alt) => alt.measure == selectedMeasure);
    context
        .read<MealScanLoggedFoodDetailsViewModel>()
        .selectAltMeasureForCurrentSelectedIngredient(selectedAltMeasure: selectedAlt);
    context.read<MealScanLoggedFoodDetailsViewModel>().updateNutrientsDataForCurrentSelectedIngredient();
    _formKey.currentState?.fields[FormFields.quantity.name]?.didChange(selectedAlt.qty.toString());
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _LoggedFoodIngredientDetailsPageState {
  void _setCurrentSelectedIngredient(IngredientModel ingredient) {
    context.read<MealScanLoggedFoodDetailsViewModel>().setCurrentSelectedIngredient(ingredient);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _LoggedFoodIngredientDetailsPageState {
  // Header Container
  Widget getHeaderContainer() {
    return Container(
      width: double.infinity,
      padding: AppStyles.kPaddSV12H16,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac8,
          children: [
            getFoodNameLabel(widget.ingredient.foodName ?? ''),
            Row(
              spacing: AppStyles.kSpac16,
              children: [
                Expanded(flex: 1, child: getQuantityTextFormField(widget.ingredient.altMeasures ?? [])),
                Expanded(
                  flex: 3,
                  child: getServingUnitDropdownForm(
                    widget.ingredient.servingUnit ?? '',
                    widget.ingredient.servingWeight ?? 0.0,
                    widget.ingredient.altMeasures ?? [],
                  ),
                ),
              ],
            ),
            AppStyles.kSizedBoxH4,
          ],
        ),
      ),
    );
  }

  // Food Name Label
  Widget getFoodNameLabel(String foodName) {
    return Text(foodName, style: _Styles.getFoodNameLabelTextStyle(context));
  }

  // Quantity Text Form Field
  Widget getQuantityTextFormField(List<AltMeasureModel> altMeasures) {
    final selectedQty = context.read<MealScanLoggedFoodDetailsViewModel>().currentSelectedModifiedIngredient.servingQty;

    return AppTextFormField(
      field: FormFields.quantity,
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      topLabel: S.current.quantityLabel,
      initialValue: selectedQty.toString(),
      keyboardType: TextInputType.number,
      height: AppStyles.kSize40,
      borderRadius: AppStyles.kRad10,
      onChanged: (value) {
        final qty = double.tryParse(value ?? '');
        if (qty != null && qty != 0) {
          context
              .read<MealScanLoggedFoodDetailsViewModel>()
              .updateNutrientsDataForCurrentSelectedIngredient(servingQty: qty);
        }
      },
    );
  }

  // Serving Unit Dropdown Form
  Widget getServingUnitDropdownForm(String servingUnit, double servingWeightGrams, List<AltMeasureModel> altMeasures) {
    List<String> servingUnits =
        altMeasures.map((alt) => '${alt.measure} (${alt.servingWeight?.toStringAsFixed(0) ?? 0}g)').toList();

    final vm = context.read<MealScanLoggedFoodDetailsViewModel>();
    final currentSelectedUnit =
        '${vm.selectedAltMeasure!.measure} (${vm.selectedAltMeasure!.servingWeight?.toStringAsFixed(0) ?? 0}g)';

    return AppDropdownForm(
      field: FormFields.servingUnit,
      validator: FormBuilderValidators.compose([]),
      items: servingUnits.map((unit) => DropdownMenuItem<String>(value: unit, child: Text(unit))).toList(),
      initialValue: currentSelectedUnit,
      topLabel: S.current.servingUnitLabel,
      height: AppStyles.kSize40,
      onChanged: (String? selectedUnit) {
        _onServingQtyChanged(selectedUnit, altMeasures);
      },
    );
  }

  // Calories Container
  Widget getCalorieContainer(Map<String, double> macroNutrientPercentage, double calorie) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getCalorieContainerDecoration(context),
      padding: AppStyles.kPaddSV10H12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getCalorieLabel(),
              RichText(
                text: TextSpan(
                  children: [getCalorieValueLabel(calorie), getCalorieUnitLabel()],
                ),
              ),
            ],
          ),
          AppStyles.kSizedBoxH12,
          getMultiSegmentLinearIndicator(macroNutrientPercentage),
        ],
      ),
    );
  }

  // Calorie Label
  Text getCalorieLabel() {
    return Text(S.current.calorieLabel, style: _Styles.getCalorieLabelTextStyle(context));
  }

  // Calorie Value Label
  TextSpan getCalorieValueLabel(double calorie) {
    return TextSpan(text: calorie.toString(), style: _Styles.getCalorieValueLabelTextStyle(context));
  }

  // Calorie Unit Label
  TextSpan getCalorieUnitLabel() {
    return TextSpan(text: ' ${S.current.calorieUnit}', style: _Styles.getCalorieUnitLabelTextStyle(context));
  }

  // Mutli Segment Linear Indicator
  Widget getMultiSegmentLinearIndicator(Map<String, double> macroNutrientPercentage) {
    return MultiSegmentLinearIndicator(
      segments: [
        SegmentLinearIndicator(
          percent: macroNutrientPercentage[MacroNutrients.protein.key] ?? 0.0,
          color: MacroNutrients.protein.color,
        ),
        SegmentLinearIndicator(
          percent: macroNutrientPercentage[MacroNutrients.carbs.key] ?? 0.0,
          color: MacroNutrients.carbs.color,
        ),
        SegmentLinearIndicator(
          percent: macroNutrientPercentage[MacroNutrients.fat.key] ?? 0.0,
          color: MacroNutrients.fat.color,
        ),
      ],
      width: AppStyles.kDoubleInfinity,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: _Styles.linearIndicatorLineHeight,
    );
  }

  // Macronutrients Row
  Widget getMacronutrientsRow(Map<String, double> macroNutrientPercentage, double carbs, double fat, double protein) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppStyles.kSpac12,
      children: [
        MacronutrientCard(
          label: MacroNutrients.protein.label,
          value: protein.toString(),
          macroNutrient: MacroNutrients.protein,
          percentage: macroNutrientPercentage[MacroNutrients.protein.key] ?? 0.0,
        ),
        MacronutrientCard(
          label: MacroNutrients.carbs.label,
          value: carbs.toString(),
          macroNutrient: MacroNutrients.carbs,
          percentage: macroNutrientPercentage[MacroNutrients.carbs.key] ?? 0.0,
        ),
        MacronutrientCard(
          label: MacroNutrients.fat.label,
          value: fat.toString(),
          macroNutrient: MacroNutrients.fat,
          percentage: macroNutrientPercentage[MacroNutrients.fat.key] ?? 0.0,
        ),
      ],
    );
  }

  // Nutritional Information Container
  Widget getNutritionalInfoContainer(List<FullNutrientsModel> fullNutrients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac8,
      children: [
        getNutritionalInfoLabel(),
        Container(
          decoration: _Styles.getNutritionalInfoContainerDecoration(context),
          padding: AppStyles.kPadd16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // only show mapped nutriets in nutrientMapping
              ...fullNutrients.where((nutrient) => nutrientsMapping.containsKey(nutrient.attrId)).map(
                (nutrient) {
                  final nutrientInformation = nutrientsMapping[nutrient.attrId];
                  return Padding(
                    padding: AppStyles.kPaddSV6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(nutrientInformation?.label ?? '', style: _Styles.getNutrientLabelTextStyle(context)),
                        RichText(
                          text: TextSpan(
                            children: [
                              getNutritionValueLabel(nutrient.value ?? 0),
                              getNutrientUnitLabel(nutrientInformation?.unit ?? '')
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Nutritional Info Label
  Widget getNutritionalInfoLabel() {
    return Text(
      S.current.nutritionalInformationLabel,
      style: _Styles.getNutritionalInfoLabelTextStyle(context),
    );
  }

  // Nutrition Value Label
  TextSpan getNutritionValueLabel(double value) {
    return TextSpan(
      text: '$value',
      style: _Styles.getNutrientValueLabelTextStyle(context),
    );
  }

  // Nutritient Unit Label
  TextSpan getNutrientUnitLabel(String unit) {
    return TextSpan(
      text: unit,
      style: _Styles.getNutrientUnitLabelTextStyle(context),
    );
  }

  // Save Button
  Widget getSaveButton() {
    return Positioned(
      bottom: _Styles.getButtonBottomPositition,
      left: _Styles.getButtonHorizontalPosition,
      right: _Styles.getButtonHorizontalPosition,
      child: AppDefaultButton(
        label: S.current.saveLabel,
        onPressed: () {
          context.read<MealScanLoggedFoodDetailsViewModel>().updateIngredients(widget.index);
          context.read<MealScanLoggedFoodDetailsViewModel>().clearCurrentSelectedIngredient();
          context.router.maybePop();
        },
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL20BR20,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Food Name Label Text Style
  static TextStyle getFoodNameLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumHuge);
  }

  // Calorie Container Decoration
  static BoxDecoration getCalorieContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Calorie Label Text Style
  static TextStyle getCalorieLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Value Label Text Style
  static TextStyle getCalorieValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumHuge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Unit Label Text Style
  static TextStyle getCalorieUnitLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Linear Indicator Line Height
  static double linearIndicatorLineHeight = 8.0;

  // Nutritional Info Label Text Style
  static TextStyle getNutritionalInfoLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Nutritional Info Container Decoration
  static BoxDecoration getNutritionalInfoContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Nutritient Label Text Style
  static TextStyle getNutrientLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Nutritient Value Label Text Style
  static TextStyle getNutrientValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Nutrient Unit Label Text Style
  static TextStyle getNutrientUnitLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary);
  }

  // Button Positioning
  static double getButtonBottomPositition = 10.0;

  // Button Positioning
  static double getButtonHorizontalPosition = 16.0;
}
