import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/models/meal_scan_result_model.dart/meal_scan_result_model.dart';
import 'package:flux/app/viewmodels/meal_scan_vm/meal_scan_view_model.dart';
import 'package:flux/app/widgets/food/ingredient_card.dart';
import 'package:flux/app/widgets/food/meal_scan_macronutrient_card.dart';
import 'package:flux/app/widgets/skeleton/meal_scan_result_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;

@RoutePage()
class MealScanResultPage extends BaseStatefulPage {
  final XFile imageFile;

  const MealScanResultPage({super.key, required this.imageFile});

  @override
  State<MealScanResultPage> createState() => _MealScanResultPageState();
}

class _MealScanResultPageState extends BaseStatefulState<MealScanResultPage> {
  File? croppedImageFile;
  bool isProcessing = true;
  int stepperCount = 1;

  @override
  void initState() {
    super.initState();
    _cropImageToSquare();
    _getFoodDetailsFromMealScan();
  }

  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    if (isProcessing) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        getImage(),
        getTopBar(),
        getScrollableSheet(),
        getActionButtonRow(),
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
extension _Actions on _MealScanResultPageState {
  // Increment Stepper Count
  void _incrementStepper() {
    _setState(() {
      stepperCount++;
    });
  }

  // Decrement Stepper Count
  void _decrementStepper() {
    if (stepperCount > 1) {
      _setState(() {
        stepperCount--;
      });
    }
  }

  void _onIngredientPressed(IngredientModel ingredient, int index) {
    context.router.push(IngredientDetailsRoute(ingredient: ingredient, index: index)).then((_) {
      if (mounted) {
        context.read<MealScanViewModel>().clearCurrentSelectedIngredient();
      }
    });
  }

  void _onDeleteIngredientPressed(index) {
    context.read<MealScanViewModel>().deleteIngredient(index);
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _MealScanResultPageState {
  // Crops the center of the image
  Future<void> _cropImageToSquare() async {
    final originalFile = File(widget.imageFile.path);
    final bytes = await originalFile.readAsBytes();
    final originalImage = img.decodeImage(bytes);

    if (originalImage != null) {
      final squareSize = originalImage.width < originalImage.height ? originalImage.width : originalImage.height;

      final startX = (originalImage.width - squareSize) ~/ 2;
      final startY = (originalImage.height - squareSize) ~/ 2;

      final cropped = img.copyCrop(
        originalImage,
        x: startX,
        y: startY,
        width: squareSize,
        height: squareSize,
      );

      // Save cropped image to a temp file
      final tempPath = '${originalFile.parent.path}/cropped_${originalFile.uri.pathSegments.last}';
      final newFile = File(tempPath);
      await newFile.writeAsBytes(img.encodeJpg(cropped));

      _setState(() {
        croppedImageFile = newFile;
        isProcessing = false;
      });
    }
  }

  Future<void> _getFoodDetailsFromMealScan() async {
    await tryCatch(
      context,
      () => context.read<MealScanViewModel>().getFoodDetailsFromMealScan(imageFile: widget.imageFile),
    );
  }

  Map<String, double> _calculateTotalNutrition(List<IngredientModel>? ingredients) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    if (ingredients != null) {
      for (final ingredient in ingredients) {
        totalCalories += ingredient.calorie ?? 0;
        totalProtein += ingredient.protein ?? 0;
        totalCarbs += ingredient.carbs ?? 0;
        totalFat += ingredient.fat ?? 0;
      }
    }

    return {
      Nutrition.calorie.key: totalCalories,
      Nutrition.protein.key: totalProtein,
      Nutrition.carbs.key: totalCarbs,
      Nutrition.fat.key: totalFat,
    };
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealScanResultPageState {
// Top Bar
  Widget getTopBar() {
    return Positioned(
      top: 30,
      left: 20,
      right: 20,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.router.maybePop(),
            child: Container(
              padding: AppStyles.kPadd6,
              decoration: _Styles.getBackButtonDecoration(context),
              child: FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: context.theme.colorScheme.onTertiary,
                size: AppStyles.kSize16,
              ),
            ),
          ),
          Spacer(),
          getMealFormBuilderDropDown(),
        ],
      ),
    );
  }

  // Image
  Widget getImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: Image.file(croppedImageFile!, fit: BoxFit.contain),
    );
  }

  // Scrollable Sheet
  Widget getScrollableSheet() {
    final isLoading = context.select((MealScanViewModel vm) => vm.isLoading);

    final mealScanResult = context.select((MealScanViewModel vm) => vm.mealScanResult);

    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.88,
        builder: (context, scrollController) {
          return getScrollableSheetContainer(scrollController, isLoading, mealScanResult: mealScanResult);
        },
      ),
    );
  }

  // Scrollable Sheet Container
  Widget getScrollableSheetContainer(
    ScrollController scrollController,
    bool isLoading, {
    required MealScanResultModel mealScanResult,
  }) {
    final foodName = mealScanResult.foodName;
    final quantity = mealScanResult.quantity;
    final healthScore = mealScanResult.healthScore;
    final healthScoreDesc = mealScanResult.healthScoreDesc;
    final ingredients = mealScanResult.ingredients;

    final nutritionTotals = _calculateTotalNutrition(ingredients);

    return Container(
      decoration: _Styles.getScrollableSheetDecoration(context),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: AppStyles.kPaddSV20H20,
          child: Column(
            spacing: AppStyles.kSpac16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLoading)
                const MealScanResultSkeleton()
              else ...[
                getHeader(foodName: foodName, quantity: quantity),
                getNutritionScoreContainer(healthScore: healthScore, healthScoreDesc: healthScoreDesc),
                getCalorieContainer(calories: nutritionTotals[Nutrition.calorie.key] ?? 0),
                getMacronutrientsRow(
                  protein: nutritionTotals[Nutrition.protein.key] ?? 0,
                  carbs: nutritionTotals[Nutrition.carbs.key] ?? 0,
                  fat: nutritionTotals[Nutrition.fat.key] ?? 0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppStyles.kSpac4,
                  children: [
                    Text(S.current.ingredientsLabel.toUpperCase(), style: Quicksand.semiBold.withCustomSize(11)),
                    getIngredientListView(ingredients: ingredients),
                  ],
                ),
                AppStyles.kSizedBoxH32,
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Header
  Widget getHeader({required String? foodName, required double? quantity}) {
    return Row(
      spacing: AppStyles.kSpac12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(foodName ?? '', style: _Styles.getFoodNameLabelTextStyle(context)),
        ),
        getNumberStepper(quantity: quantity),
      ],
    );
  }

  // Number Stepper
  Widget getNumberStepper({required double? quantity}) {
    return Container(
      decoration: _Styles.getNumberStepperContainerDecoration(context),
      padding: AppStyles.kPaddSV4H6,
      child: Row(
        spacing: AppStyles.kSpac24,
        children: [
          GestureDetector(onTap: _decrementStepper, child: FaIcon(FontAwesomeIcons.minus, size: AppStyles.kSize12)),
          Text(quantity?.toStringAsFixed(0) ?? '0', style: _Styles.getNumberStepperLabelTextStyle(context)),
          GestureDetector(onTap: _incrementStepper, child: FaIcon(FontAwesomeIcons.plus, size: AppStyles.kSize12)),
        ],
      ),
    );
  }

  // Calories Container
  Widget getCalorieContainer({required double calories}) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getCalorieContainerDecoration(context),
      padding: AppStyles.kPaddSV10H8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: AppStyles.kSpac8,
                children: [getCalorieIconContainer(), getCalorieLabel()],
              ),
              RichText(
                text: TextSpan(children: [getCalorieValueLabel(calories), getCalorieUnitLabel()]),
              ),
            ],
          ),
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
    return TextSpan(text: calorie.toStringAsFixed(1), style: _Styles.getCalorieValueLabelTextStyle(context));
  }

  // Calorie Unit Label
  TextSpan getCalorieUnitLabel() {
    return TextSpan(text: ' ${S.current.calorieUnit}', style: _Styles.getCalorieUnitLabelTextStyle(context));
  }

  // Calorie Icon Container
  Widget getCalorieIconContainer() {
    return Container(
      height: AppStyles.kSize30,
      width: AppStyles.kSize30,
      decoration: _Styles.getCalorieIconContainerDecoration(context),
      child: Center(child: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize16)),
    );
  }

  // Macronutrients Row
  Widget getMacronutrientsRow({
    required double protein,
    required double carbs,
    required double fat,
  }) {
    return Row(
      spacing: AppStyles.kSpac12,
      children: [
        MealScanMacronutrientCard(nutrient: MacroNutrients.protein, value: protein, icon: FontAwesomeIcons.fish),
        MealScanMacronutrientCard(nutrient: MacroNutrients.carbs, value: carbs, icon: FontAwesomeIcons.wheatAwn),
        MealScanMacronutrientCard(nutrient: MacroNutrients.fat, value: fat, icon: FontAwesomeIcons.bacon)
      ],
    );
  }

  // Nutrition Score Container
  Widget getNutritionScoreContainer({required double? healthScore, required String? healthScoreDesc}) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getNutritionScoreContainerDecoration(context),
      padding: AppStyles.kPaddSV10H12,
      child: Column(
        spacing: AppStyles.kSpac4,
        children: [
          getNutritionScoreHeader(healthScore: healthScore),
          Text(
            healthScoreDesc ?? '',
            style: _Styles.getNutritionScoreContentTextStyle(context),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  // Nutrition Score Header
  Widget getNutritionScoreHeader({required double? healthScore}) {
    return Row(
      spacing: AppStyles.kSpac4,
      children: [
        Icon(Icons.star_purple500_rounded, size: AppStyles.kSize20, color: context.theme.colorScheme.secondary),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(S.current.nutritionScoreLabel, style: _Styles.getNutritionScoreLabelTextStyle(context))],
        ),
        Spacer(),
        Text('${healthScore?.toStringAsFixed(0) ?? '0'}/10', style: _Styles.getNutritionScoreValueTextStyle(context)),
      ],
    );
  }

  // Ingredient List View
  Widget getIngredientListView({required List<IngredientModel>? ingredients}) {
    return ListView.builder(
      itemCount: ingredients?.length ?? 0,
      itemBuilder: (context, index) {
        final ingredient = ingredients![index];
        return IngredientCard(
          ingredient: ingredient,
          onPressed: (ingredient) => _onIngredientPressed(ingredient, index),
          onDeletePressed: () => _onDeleteIngredientPressed(index),
        );
      },
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  // Action Button Row
  Widget getActionButtonRow() {
    final isLoading = context.select((MealScanViewModel vm) => vm.isLoading);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: AppStyles.kPaddSV12H20,
        decoration: _Styles.getActionButtonContainerDecoration(context),
        child: Row(
          spacing: AppStyles.kSpac12,
          children: [
            if (isLoading) ...[
              MealScanActionButtonRowSkeleton(),
              MealScanActionButtonRowSkeleton()
            ] else ...[
              getEnhanceWithAIButton(),
              getLogFoodButton(),
            ],
          ],
        ),
      ),
    );
  }

  // Enhance with AI Button
  Widget getEnhanceWithAIButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: AppStyles.kPaddSV12,
          decoration: _Styles.getEnhanceWithAIButtonDecoration(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppStyles.kSpac8,
            children: [
              FaIcon(FontAwesomeIcons.edit, size: AppStyles.kSize16),
              Text(S.current.enhanceWithAILabel, style: _Styles.getEnhanceWithAIButtonTextStyle(context)),
            ],
          ),
        ),
      ),
    );
  }

  // Log Food Button
  Widget getLogFoodButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          debugPrint(context.read<MealScanViewModel>().mealScanResult.toString());
        },
        child: Container(
          padding: AppStyles.kPaddSV12,
          decoration: _Styles.getLogFoodButtonDecoration(context),
          child: Center(
            child: Text(S.current.logFoodLabel, style: _Styles.getLogFoodButtonTextStyle(context)),
          ),
        ),
      ),
    );
  }

  // Meal Form Builder Drop Down
  Widget getMealFormBuilderDropDown() {
    final mealTypes = [MealType.breakfast.label, MealType.lunch.label, MealType.dinner.label, MealType.snack.label];
    return Container(
      padding: AppStyles.kPaddSH6,
      width: AppStyles.kSize100,
      decoration: _Styles.getFieldContainerDecoration(context),
      child: FormBuilderDropdown<String>(
        name: FormFields.mealType.name,
        initialValue: MealType.breakfast.label,
        items: mealTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
        style: _Styles.getFieldDropDownTextStyle(context),
        decoration: _Styles.getFieldInputDecoration(),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Scrollable Sheet Container Decoration
  static BoxDecoration getScrollableSheetDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.onPrimary, borderRadius: AppStyles.kRadVT15);
  }

  // Back Button Container Decoration
  static BoxDecoration getBackButtonDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.tertiary.withAlpha(150), shape: BoxShape.circle);
  }

  // Food Name Label Text Style
  static TextStyle getFoodNameLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Number Stepper Label Text Style
  static TextStyle getNumberStepperLabelTextStyle(BuildContext context) {
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

  // Calorie Label Text Style
  static TextStyle getCalorieLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Value Label Text Style
  static TextStyle getCalorieValueLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Calorie Unit Label Text Style
  static TextStyle getCalorieUnitLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Number Stepper Container Decoration
  static BoxDecoration getNumberStepperContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Calorie Icon Container Decoration
  static BoxDecoration getCalorieIconContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Action Button Container Decoration
  static BoxDecoration getActionButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOTL15TR15,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, -1)),
      ],
    );
  }

  // Nutrition Score Container Decoration
  static BoxDecoration getNutritionScoreContainerDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: GradientAppColors.tertiaryGradient,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Nutrition Score Label Text Style
  static TextStyle getNutritionScoreLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Nutrition Score Description Text Style
  static TextStyle getNutritionScoreContentTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Nutrition Score Value Text Style
  static TextStyle getNutritionScoreValueTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Enhance with AI Button Decoration
  static BoxDecoration getEnhanceWithAIButtonDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary.withAlpha(40),
      borderRadius: AppStyles.kRad10,
    );
  }

  // Enhance with AI Button Text Style
  static TextStyle getEnhanceWithAIButtonTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary);
  }

  // Log Food Button Decoration
  static BoxDecoration getLogFoodButtonDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.primary,
      borderRadius: AppStyles.kRad10,
    );
  }

  // Log Food Button Text Style
  static TextStyle getLogFoodButtonTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Field Container Decoration
  static BoxDecoration getFieldContainerDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: GradientAppColors.tertiaryGradient,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Field Drop Down Text Style
  static TextStyle getFieldDropDownTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.primary);
  }

  // Text Field Input Decoration
  static InputDecoration getFieldInputDecoration() {
    return InputDecoration(border: InputBorder.none, isDense: true, contentPadding: AppStyles.kPaddOL4T2B2);
  }
}
