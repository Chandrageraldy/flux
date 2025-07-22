import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_model/food_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/food_details_vm/food_details_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/dropdown_form/app_dropdown_form.dart';
import 'package:flux/app/widgets/food/macronutrient_card.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:percent_indicator/multi_segment_linear_indicator.dart';

@RoutePage()
class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({required this.food, required this.foodSearchModel, super.key});

  final FoodModel food;
  final FoodResponseModel foodSearchModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FoodDetailsViewModel(), child: _FoodDetailsPage(food: food, foodSearchModel: foodSearchModel));
  }
}

class _FoodDetailsPage extends BaseStatefulPage {
  const _FoodDetailsPage({required this.food, required this.foodSearchModel});

  final FoodModel food;
  final FoodResponseModel foodSearchModel;

  @override
  State<_FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends BaseStatefulState<_FoodDetailsPage> {
  @override
  PreferredSizeWidget? appbar() =>
      DefaultAppBar(backgroundColor: context.theme.colorScheme.onPrimary, actionButton: getSaveContainer());

  @override
  defaultPadding() => AppStyles.kPadd0;

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  Widget body() {
    final macroNutrientPercentage = FunctionUtils.calculateMacronutrientPercentage(
      carbs: widget.food.carbohydrate,
      fat: widget.food.fat,
      protein: widget.food.protein,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          padding: AppStyles.kPaddOB70,
          child: Column(
            children: [
              getHeaderContainer(),
              Padding(
                padding: AppStyles.kPaddSV12H20,
                child: Column(
                  spacing: AppStyles.kSpac12,
                  children: [
                    getCalorieContainer(macroNutrientPercentage),
                    getMacronutrientsRow(macroNutrientPercentage),
                    // getNutritionalInfoContainer(),
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
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _FoodDetailsPageState {
  Future<void> _onSavePressed() async {
    final response =
        await tryLoad(context, () => context.read<FoodDetailsViewModel>().saveFood(widget.foodSearchModel));

    if (response == true) {}
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _FoodDetailsPageState {
  // Save Container
  Widget getSaveContainer() {
    return GestureDetector(
      onTap: _onSavePressed,
      child: Container(
        padding: AppStyles.kPadd8,
        decoration: _Styles.getSaveContainerDecoration(context),
        child: Icon(Icons.bookmark_add_outlined, color: context.theme.colorScheme.primary),
      ),
    );
  }

  // Header Container
  Widget getHeaderContainer() {
    return Container(
      width: double.infinity,
      padding: AppStyles.kPaddSV12H20,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [getFoodNameLabel()],
          ),
          AppStyles.kSizedBoxH4,
          Row(
            children: [
              Expanded(flex: 1, child: getQuantityTextFormField()),
              AppStyles.kSizedBoxW12,
              Expanded(flex: 3, child: getServingUnitDropdownForm()),
            ],
          ),
          getMealTypeDropdownForm(),
          AppStyles.kSizedBoxH4,
        ],
      ),
    );
  }

  // Food Name Label
  Widget getFoodNameLabel() {
    return Text(
      widget.food.foodName,
      style: _Styles.getFoodNameLabelTextStyle(context),
    );
  }

  // Quantity Text Form Field
  Widget getQuantityTextFormField() {
    return AppTextFormField(
      field: FormFields.search,
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      initialValue: widget.food.servingQuantity.toString(),
      topLabel: S.current.quantityLabel,
    );
  }

  // Serving Unit Dropdown Form
  Widget getServingUnitDropdownForm() {
    return AppDropdownForm(
      field: FormFields.servingUnit,
      validator: FormBuilderValidators.compose([]),
      items: widget.food.servingUnit.map((unit) => DropdownMenuItem<String>(value: unit, child: Text(unit))).toList(),
      initialValue: widget.food.servingUnit.first,
      topLabel: S.current.servingUnitLabel,
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
    );
  }

  // Calories Container
  Widget getCalorieContainer(Map<String, double> macroNutrientPercentage) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getCalorieContainerDecoration(context),
      padding: AppStyles.kPadd16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [getCalorieValueLabel(), getCalorieUnitLabel()],
            ),
          ),
          AppStyles.kSizedBoxH12,
          getMultiSegmentLinearIndicator(macroNutrientPercentage),
        ],
      ),
    );
  }

  // Calorie Value Label
  TextSpan getCalorieValueLabel() {
    return TextSpan(
      text: widget.food.calories.toString(),
      style: _Styles.getCalorieValueLabelTextStyle(context),
    );
  }

  // Calorie Unit Label
  TextSpan getCalorieUnitLabel() {
    return TextSpan(
      text: ' ${S.current.calorieUnit}',
      style: _Styles.getCalorieUnitLabelTextStyle(context),
    );
  }

  // Mutli Segment Linear Indicator
  Widget getMultiSegmentLinearIndicator(Map<String, double> macroNutrientPercentage) {
    return MultiSegmentLinearIndicator(
      segments: [
        SegmentLinearIndicator(
          percent: macroNutrientPercentage[MacroNutrients.protein.key] ?? 0.0,
          color: Color(0xFFdf9149),
        ),
        SegmentLinearIndicator(
          percent: macroNutrientPercentage[MacroNutrients.carbs.key] ?? 0.0,
          color: Color(0xFF6bd0e9),
        ),
        SegmentLinearIndicator(
          percent: macroNutrientPercentage[MacroNutrients.fat.key] ?? 0.0,
          color: Color(0xFF7770c0),
        ),
      ],
      width: AppStyles.kDoubleInfinity,
      padding: AppStyles.kPadd0,
      barRadius: Radius.circular(AppStyles.kSpac20),
      lineHeight: _Styles.linearIndicatorLineHeight,
    );
  }

  // Macronutrients Row
  Widget getMacronutrientsRow(Map<String, double> macroNutrientPercentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppStyles.kSpac12,
      children: [
        MacronutrientCard(
          label: MacroNutrients.protein.label,
          value: widget.food.protein.toString(),
          macroNutrient: MacroNutrients.protein,
          percentage: macroNutrientPercentage[MacroNutrients.protein.key] ?? 0.0,
        ),
        MacronutrientCard(
          label: MacroNutrients.carbs.label,
          value: widget.food.carbohydrate.toString(),
          macroNutrient: MacroNutrients.carbs,
          percentage: macroNutrientPercentage[MacroNutrients.carbs.key] ?? 0.0,
        ),
        MacronutrientCard(
          label: MacroNutrients.fat.label,
          value: widget.food.fat.toString(),
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
  Widget getNutritionalInfoContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac12,
      children: [
        getNutritionalInfoLabel(),
        Container(
          decoration: _Styles.getNutritionalInfoContainerDecoration(context),
          padding: AppStyles.kPadd16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.food.nutrients.map(
                (nutrient) => Padding(
                  padding: AppStyles.kPaddSV6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(nutrient.name),
                      Text('${nutrient.amount} ${nutrient.unit}'),
                    ],
                  ),
                ),
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
}

// * ----------------------------- Styles -----------------------------
class _Styles {
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

  // Food Name Label Text Style
  static TextStyle getFoodNameLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.massive);
  }

  // Calorie Value Label Text Style
  static TextStyle getCalorieValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.massive).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Unit Label Text Style
  static TextStyle getCalorieUnitLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Button Positioning
  static double getButtonBottomPositition = 10.0;

  // Button Positioning
  static double getButtonHorizontalPosition = 20.0;

  // Linear Indicator Line Height
  static double linearIndicatorLineHeight = 8.0;

  // Nutritional Info Container Decoration
  static BoxDecoration getNutritionalInfoContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Nutritional Info Label Text Style
  static TextStyle getNutritionalInfoLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Container Decoration
  static BoxDecoration getCalorieContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
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
}
