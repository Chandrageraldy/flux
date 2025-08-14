import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/full_nutrients_model/full_nutrients_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/nutrition_mapping_model/nutrition_mapping_model.dart';
import 'package:flux/app/utils/regexp/regexp.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/logged_food_vm/food_search_logged_food_details_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/dropdown_form/app_dropdown_form.dart';
import 'package:flux/app/widgets/food/macronutrient_card.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

@RoutePage()
class FoodSearchLoggedFoodDetailsPage extends StatelessWidget {
  const FoodSearchLoggedFoodDetailsPage({required this.loggedFood, super.key});

  final LoggedFoodModel loggedFood;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodSearchLoggedFoodDetailsViewModel(loggedFood: loggedFood),
      child: _FoodSearchLoggedFoodDetailsPage(loggedFood: loggedFood),
    );
  }
}

class _FoodSearchLoggedFoodDetailsPage extends BaseStatefulPage {
  const _FoodSearchLoggedFoodDetailsPage({required this.loggedFood});

  final LoggedFoodModel loggedFood;

  @override
  State<_FoodSearchLoggedFoodDetailsPage> createState() => _FoodSearchLoggedFoodDetailsPageState();
}

class _FoodSearchLoggedFoodDetailsPageState extends BaseStatefulState<_FoodSearchLoggedFoodDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appbar() =>
      DefaultAppBar(backgroundColor: context.theme.colorScheme.onPrimary, actionButton: getDeleteContainer());

  @override
  bool hasDefaultPadding() => false;

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  Widget body() {
    final foodDetails = context.select((FoodSearchLoggedFoodDetailsViewModel vm) => vm.modifiedFoodDetails);
    final macroNutrientPercentage = FunctionUtils.calculateMacronutrientPercentage(
      carbs: foodDetails.carbsG ?? 0.0,
      fat: foodDetails.fatG ?? 0.0,
      protein: foodDetails.proteinG ?? 0.0,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          padding: AppStyles.kPaddOB70,
          child: Column(
            children: [
              getHeaderContainer(foodDetails),
              Padding(
                padding: AppStyles.kPaddSV12H16,
                child: Column(
                  spacing: AppStyles.kSpac12,
                  children: [
                    getCalorieContainer(macroNutrientPercentage, foodDetails.calorieKcal ?? 0.0),
                    getMacronutrientsRow(macroNutrientPercentage, foodDetails.carbsG ?? 0.0, foodDetails.fatG ?? 0.0,
                        foodDetails.proteinG ?? 0.0),
                    getNutritionalInfoContainer(foodDetails.fullNutrients ?? []),
                  ],
                ),
              ),
            ],
          ),
        ),
        getEditButton(),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _FoodSearchLoggedFoodDetailsPageState {
  Future<void> _onServingQtyChanged(String? selectedUnit, List<AltMeasureModel> altMeasures) async {
    final selectedMeasure = selectedUnit!.replaceAll(Regexp.removeTrailingParentheses, '').trim();
    final selectedAlt = altMeasures.firstWhere((alt) => alt.measure == selectedMeasure);
    context.read<FoodSearchLoggedFoodDetailsViewModel>().selectAltMeasure(selectedAltMeasure: selectedAlt);
    context.read<FoodSearchLoggedFoodDetailsViewModel>().updateNutrientsData();
    _formKey.currentState?.fields[FormFields.quantity.name]?.didChange(selectedAlt.qty.toString());
  }

  Future<void> _onEditFoodPressed() async {
    // final mealType = _formKey.currentState!.fields[FormFields.mealType.name]!.value as String;
    // tryLoad(context, () => context.read<FoodDetailsViewModel>().logFood(mealType: mealType));
  }

  Future<void> _onDeleteFoodPressed() async {}
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _FoodSearchLoggedFoodDetailsPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _FoodSearchLoggedFoodDetailsPageState {
  // Save Container
  Widget getDeleteContainer() {
    return GestureDetector(
      onTap: _onDeleteFoodPressed,
      child: Container(
        padding: AppStyles.kPadd8,
        decoration: _Styles.getDeleteContainerDecoration(context),
        child: Icon(Icons.delete, color: AppColors.redColor),
      ),
    );
  }

  // Header Container
  Widget getHeaderContainer(LoggedFoodModel foodDetails) {
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
            if (foodDetails.brandName != null) getBrandedNameLabel(foodDetails.brandName ?? ''),
            getFoodNameLabel(foodDetails.foodName ?? ''),
            Row(
              spacing: AppStyles.kSpac16,
              children: [
                Expanded(flex: 1, child: getQuantityTextFormField(foodDetails.altMeasures ?? [])),
                Expanded(
                  flex: 3,
                  child: getServingUnitDropdownForm(
                    foodDetails.servingUnit ?? '',
                    foodDetails.servingWeightGrams ?? 0.0,
                    foodDetails.altMeasures ?? [],
                  ),
                ),
              ],
            ),
            getMealTypeDropdownForm(),
            AppStyles.kSizedBoxH4,
          ],
        ),
      ),
    );
  }

  // Branded Name Label
  Widget getBrandedNameLabel(String brandedName) {
    return Row(
      spacing: AppStyles.kSpac4,
      children: [
        FaIcon(FontAwesomeIcons.tags, size: AppStyles.kSize12, color: context.theme.colorScheme.secondary),
        Text(brandedName, style: _Styles.getBrandedNameLabelTextStyle(context)),
      ],
    );
  }

  // Food Name Label
  Widget getFoodNameLabel(String foodName) {
    return Text(
      foodName,
      style: _Styles.getFoodNameLabelTextStyle(context),
    );
  }

  // Quantity Text Form Field
  Widget getQuantityTextFormField(List<AltMeasureModel> altMeasures) {
    final selectedQty = context.read<FoodSearchLoggedFoodDetailsViewModel>().unmodifiedFoodDetails.servingQty;

    return AppTextFormField(
      field: FormFields.quantity,
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      topLabel: S.current.quantityLabel,
      initialValue: selectedQty?.toString() ?? '1.0',
      keyboardType: TextInputType.number,
      height: AppStyles.kSize40,
      borderRadius: AppStyles.kRad10,
      onChanged: (value) {
        final qty = double.tryParse(value ?? '');
        if (qty != null && qty != 0) {
          context.read<FoodSearchLoggedFoodDetailsViewModel>().updateNutrientsData(servingQty: qty);
        }
      },
    );
  }

  // Serving Unit Dropdown Form
  Widget getServingUnitDropdownForm(String servingUnit, double servingWeightGrams, List<AltMeasureModel> altMeasures) {
    List<String> servingUnits =
        altMeasures.map((alt) => '${alt.measure} (${alt.servingWeight?.toStringAsFixed(1) ?? 0}g)').toList();

    final vm = context.read<FoodSearchLoggedFoodDetailsViewModel>();
    final currentSelectedUnit =
        '${vm.selectedAltMeasure!.measure} (${vm.selectedAltMeasure!.servingWeight?.toStringAsFixed(1) ?? 0}g)';

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

  // Meal Type Dropdown Form
  Widget getMealTypeDropdownForm() {
    final mealTypes = [MealType.breakfast.value, MealType.lunch.value, MealType.dinner.value, MealType.snack.value];
    return AppDropdownForm(
      field: FormFields.mealType,
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      items: mealTypes.map((type) => DropdownMenuItem<String>(value: type, child: Text(type))).toList(),
      initialValue: widget.loggedFood.mealType,
      topLabel: S.current.mealTypeLabel,
      height: AppStyles.kSize40,
      onChanged: (String? selectedMealType) {
        context.read<FoodSearchLoggedFoodDetailsViewModel>().updateMealType(mealType: selectedMealType ?? '');
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

  // Edit Button
  Widget getEditButton() {
    return Positioned(
      bottom: _Styles.getButtonBottomPositition,
      left: _Styles.getButtonHorizontalPosition,
      right: _Styles.getButtonHorizontalPosition,
      child: AppDefaultButton(label: S.current.editFoodLabel, onPressed: _onEditFoodPressed),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Delete Container Decoration
  static BoxDecoration getDeleteContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryFixedDim,
      borderRadius: AppStyles.kRad10,
    );
  }

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

  // Branded Name Label Text Style
  static TextStyle getBrandedNameLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
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
