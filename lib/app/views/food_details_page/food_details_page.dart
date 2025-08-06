import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/alt_measure_model/alt_measure_model.dart';
import 'package:flux/app/models/food_details_model/food_details_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/full_nutrients_model/full_nutrients_model.dart';
import 'package:flux/app/models/nutrition_mapping_model/nutrition_mapping_model.dart';
import 'package:flux/app/utils/regexp/regexp.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/food_details_vm/food_details_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/dropdown_form/app_dropdown_form.dart';
import 'package:flux/app/widgets/food/macronutrient_card.dart';
import 'package:flux/app/widgets/skeleton/food_details_skeleton.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:percent_indicator/multi_segment_linear_indicator.dart';

@RoutePage()
class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({required this.foodResponseModel, required this.fromAllTab, super.key});

  final FoodResponseModel foodResponseModel;
  final bool fromAllTab;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodDetailsViewModel(),
      child: _FoodDetailsPage(
        foodResponseModel: foodResponseModel,
        fromAllTab: fromAllTab,
      ),
    );
  }
}

class _FoodDetailsPage extends BaseStatefulPage {
  const _FoodDetailsPage({required this.foodResponseModel, required this.fromAllTab});

  final FoodResponseModel foodResponseModel;
  final bool fromAllTab;

  @override
  State<_FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends BaseStatefulState<_FoodDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSaved = false;
  bool isSavedEnabled = true;

  @override
  PreferredSizeWidget? appbar() =>
      DefaultAppBar(backgroundColor: context.theme.colorScheme.onPrimary, actionButton: getSaveContainer());

  @override
  defaultPadding() => AppStyles.kPadd0;

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  void initState() {
    super.initState();
    checkIfSaved();
    checkIfFromAllTab();
    getFoodDetails();
    print(widget.fromAllTab);
  }

  @override
  Widget body() {
    final isLoading = context.select((FoodDetailsViewModel vm) => vm.isLoading);

    if (isLoading) {
      return const FoodDetailsSkeleton();
    }

    final foodDetails = context.select((FoodDetailsViewModel vm) => vm.modifiedFoodDetails);
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
        getLogButton(),
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

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _FoodDetailsPageState {
  Future<void> checkIfSaved() async {
    final response = await tryCatch(
        context, () => context.read<FoodDetailsViewModel>().checkIfSaved(foodResponseModel: widget.foodResponseModel));

    if (response == true) {
      _setState(() {
        isSaved = true;
      });
    }
  }

  Future<void> getFoodDetails() async {
    await tryCatch(context,
        () => context.read<FoodDetailsViewModel>().getFoodDetails(foodResponseModel: widget.foodResponseModel));
  }

  void checkIfFromAllTab() {
    if (widget.fromAllTab) {
      saveToRecent();
    }
  }

  Future<void> saveToRecent() async {
    await tryCatch(
        context, () => context.read<FoodDetailsViewModel>().saveToRecent(foodResponseModel: widget.foodResponseModel));
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _FoodDetailsPageState {
  Future<void> _onSavePressed() async {
    _setState(() {
      isSavedEnabled = false;
    });

    final response = await tryCatch(
      context,
      () => context.read<FoodDetailsViewModel>().saveOrUnsaveFood(
            foodResponseModel: widget.foodResponseModel,
            isSaved: isSaved,
          ),
    );

    if (response == true) {
      _setState(() {
        isSaved = !isSaved;
        isSavedEnabled = true;
      });
    }
  }

  Future<void> _onServingQtyChanged(String? selectedUnit, List<AltMeasureModel> altMeasures) async {
    final selectedMeasure = selectedUnit!.replaceAll(Regexp.removeTrailingParentheses, '').trim();
    final selectedAlt = altMeasures.firstWhere((alt) => alt.measure == selectedMeasure);
    context.read<FoodDetailsViewModel>().selectAltMeasure(selectedAltMeasure: selectedAlt);
    context.read<FoodDetailsViewModel>().updateNutrientsData();
    _formKey.currentState?.fields[FormFields.quantity.name]?.didChange(selectedAlt.qty.toString());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _FoodDetailsPageState {
  // Save Container
  Widget getSaveContainer() {
    final isLoading = context.select((FoodDetailsViewModel vm) => vm.isLoading);

    Icon icon = isSaved
        ? Icon(Icons.bookmark, color: context.theme.colorScheme.primary)
        : Icon(Icons.bookmark_add_outlined, color: context.theme.colorScheme.primary);

    return isLoading
        ? AppStyles.kEmptyWidget
        : GestureDetector(
            onTap: isSavedEnabled ? _onSavePressed : null,
            child: Container(
              padding: AppStyles.kPadd8,
              decoration: _Styles.getSaveContainerDecoration(context),
              child: icon,
            ),
          );
  }

  // Header Container
  Widget getHeaderContainer(FoodDetailsModel foodDetails) {
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
    return AppTextFormField(
      field: FormFields.quantity,
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      topLabel: S.current.quantityLabel,
      initialValue: altMeasures.first.qty.toString(),
      keyboardType: TextInputType.number,
      height: AppStyles.kSize40,
      onChanged: (value) {
        final qty = double.tryParse(value ?? '');
        if (qty != null && qty != 0) {
          context.read<FoodDetailsViewModel>().updateNutrientsData(servingQty: qty);
        }
      },
    );
  }

  // Serving Unit Dropdown Form
  Widget getServingUnitDropdownForm(String servingUnit, double servingWeightGrams, List<AltMeasureModel> altMeasures) {
    List<String> servingUnits = [];

    for (final alt in altMeasures) {
      final String? measure = alt.measure;
      final double? weight = alt.servingWeight;

      if (measure != null && weight != null) {
        servingUnits.add('$measure (${weight.toStringAsFixed(0)}g)');
      }
    }

    return AppDropdownForm(
      field: FormFields.servingUnit,
      validator: FormBuilderValidators.compose([]),
      items: servingUnits.map((unit) => DropdownMenuItem<String>(value: unit, child: Text(unit))).toList(),
      initialValue: servingUnits.first,
      topLabel: S.current.servingUnitLabel,
      height: AppStyles.kSize40,
      onChanged: (String? selectedUnit) {
        _onServingQtyChanged(selectedUnit, altMeasures);
      },
    );
  }

  // Meal Type Dropdown Form
  Widget getMealTypeDropdownForm() {
    final mealTypes = [S.current.breakfastLabel, S.current.lunchLabel, S.current.dinnerLabel, S.current.snackLabel];
    return AppDropdownForm(
      field: FormFields.mealType,
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      items: mealTypes.map((type) => DropdownMenuItem<String>(value: type, child: Text(type))).toList(),
      initialValue: mealTypes.first,
      topLabel: S.current.mealTypeLabel,
      height: AppStyles.kSize40,
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

  // Log Button
  Widget getLogButton() {
    return Positioned(
      bottom: _Styles.getButtonBottomPositition,
      left: _Styles.getButtonHorizontalPosition,
      right: _Styles.getButtonHorizontalPosition,
      child: AppDefaultButton(label: S.current.logFoodLabel, onPressed: () {}),
    );
  }

  // Nutritional Information Container
  Widget getNutritionalInfoContainer(List<FullNutrient> fullNutrients) {
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

  // Nutritional Info Label
  Widget getNutritionalInfoLabel() {
    return Text(
      S.current.nutritionalInformationLabel,
      style: _Styles.getNutritionalInfoLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
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

  // Calorie Value Label Text Style
  static TextStyle getCalorieValueLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumHuge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Unit Label Text Style
  static TextStyle getCalorieUnitLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Button Positioning
  static double getButtonBottomPositition = 10.0;

  // Button Positioning
  static double getButtonHorizontalPosition = 16.0;

  // Linear Indicator Line Height
  static double linearIndicatorLineHeight = 8.0;

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

  // Nutritional Info Label Text Style
  static TextStyle getNutritionalInfoLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium);
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

  // Save Container Decoration
  static BoxDecoration getSaveContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryFixedDim,
      borderRadius: AppStyles.kRad10,
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

  // Branded Name Label Text Style
  static TextStyle getBrandedNameLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Label Text Style
  static TextStyle getCalorieLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }
}
