import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/services/gemini_base_service.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/logged_food_vm/meal_scan_logged_food_details_view_model.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/food/ingredient_card.dart';
import 'package:flux/app/widgets/food/meal_scan_macronutrient_card.dart';
import 'package:flux/app/widgets/skeleton/meal_scan_result_skeleton.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img; // <-- for cropping
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class MealScanLoggedFoodDetailsPage extends BaseStatefulPage {
  const MealScanLoggedFoodDetailsPage({super.key});

  @override
  State<MealScanLoggedFoodDetailsPage> createState() => _MealScanLoggedFoodDetailsPageState();
}

class _MealScanLoggedFoodDetailsPageState extends BaseStatefulState<MealScanLoggedFoodDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _dialogFormKey = GlobalKey<FormBuilderState>();

  File? croppedImageFile;
  bool isProcessing = true;

  @override
  void initState() {
    super.initState();
    _cropImageToSquare();
  }

  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
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
extension _Actions on _MealScanLoggedFoodDetailsPageState {
  // Increment Meal Quantity
  void _incrementStepper() {
    context.read<MealScanLoggedFoodDetailsViewModel>().incrementMealQuantity();
  }

  // Decrement Meal Quantity
  void _decrementStepper() {
    context.read<MealScanLoggedFoodDetailsViewModel>().decrementMealQuantity();
  }

  void _onIngredientPressed(IngredientModel ingredient, int index) {
    context.router.push(LoggedFoodIngredientDetailsRoute(ingredient: ingredient, index: index)).then((_) {
      if (mounted) {
        context.read<MealScanLoggedFoodDetailsViewModel>().clearCurrentSelectedIngredient();
      }
    });
  }

  void _onDeleteIngredientPressed(index) {
    context.read<MealScanLoggedFoodDetailsViewModel>().deleteIngredient(index);
  }

  Future<void> _onEditFoodPressed({required Map<String, double> nutritionTotals}) async {
    final response = await tryLoad(context,
        () => context.read<MealScanLoggedFoodDetailsViewModel>().editLoggedFood(nutritionTotals: nutritionTotals));

    if (response == true && mounted) {
      WidgetUtils.showSnackBar(context, S.current.editSuccessfulMessage);
      context.router.maybePop(true);
    } else if (response == null && mounted) {
      context.router.maybePop();
    }
  }

  Future<void> _onDeleteFoodPressed() async {
    WidgetUtils.showConfirmationDialog(
      context: context,
      label: S.current.deleteLoggedFoodLabel,
      desc: S.current.deleteLoggedFoodDesc,
      confirmLabel: S.current.confirmLabel,
      color: AppColors.redColor,
      onConfirm: () async {
        final response = await tryLoad(
          context,
          () => context.read<MealScanLoggedFoodDetailsViewModel>().deleteLoggedFood(),
        );

        if (response == true && mounted) {
          context.router.maybePop(true);
        }
      },
    );
  }

  void _onEnhanceWithAIPressed() {
    WidgetUtils.showFieldDialog(
      placeholder: S.current.enhanceWithAIPlaceholder,
      context: context,
      label: S.current.enhanceWithAILabel,
      desc: S.current.enhanceWithAIDesc,
      formField: FormFields.enhanceWithAi,
      buttonLabel: S.current.enhanceLabel,
      icon: FontAwesomeIcons.edit,
      formKey: _dialogFormKey,
      onPressed: _onEnhancePressed,
      textFieldPadding: AppStyles.kPaddSH12,
      maxLines: 5,
      minLines: 3,
    );
  }

  void _onEnhancePressed() async {
    final content = _dialogFormKey.currentState?.fields[FormFields.enhanceWithAi.name]?.value ?? '';

    if (content.isNotEmpty) {
      final response = await tryCatch(
          context, () => context.read<MealScanLoggedFoodDetailsViewModel>().enhanceWithAI(userInstruction: content));

      if (response == GeminiMealScanStatus.INSTRUCTIONSUNCLEAR && mounted) {
        context.router.push(
          ErrorRoute(
            label: GeminiMealScanStatus.INSTRUCTIONSUNCLEAR.label,
            description: GeminiMealScanStatus.INSTRUCTIONSUNCLEAR.message,
            iconBackgroundColor: AppColors.redColor,
            actions: [getDismissButton()],
          ),
        );
      }
    }
  }

  void _dismissPressed() {
    context.router.maybePop();
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _MealScanLoggedFoodDetailsPageState {
  // Crops the center of the image
  Future<void> _cropImageToSquare() async {
    final loggedFood = context.read<MealScanLoggedFoodDetailsViewModel>().modifiedMealScanResult;

    final uri = Uri.parse(loggedFood.imageUrl!);
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(uri);
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);

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
      final tempDir = Directory.systemTemp;
      final tempPath = '${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final newFile = File(tempPath);
      await newFile.writeAsBytes(img.encodeJpg(cropped));

      _setState(() {
        croppedImageFile = newFile;
        isProcessing = false;
      });
    }
  }

  Map<String, double> _calculateTotalNutrition(List<IngredientModel>? ingredients, double? quantity) {
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

    double qty = quantity ?? 1;

    double round2(double val) => double.parse(val.toStringAsFixed(2));

    return {
      Nutrition.calorie.key: round2(totalCalories * qty),
      Nutrition.protein.key: round2(totalProtein * qty),
      Nutrition.carbs.key: round2(totalCarbs * qty),
      Nutrition.fat.key: round2(totalFat * qty),
    };
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealScanLoggedFoodDetailsPageState {
  // Image
  Widget getImage() {
    if (isProcessing) {
      return Skeleton(height: AppStyles.kDoubleInfinity);
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: Image.file(croppedImageFile!, fit: BoxFit.contain),
      );
    }
  }

  // Top Bar
  Widget getTopBar() {
    return FormBuilder(
      key: _formKey,
      child: Positioned(
        top: 30,
        left: 20,
        right: 20,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.router.maybePop(),
              child: Container(
                padding: AppStyles.kPadd8,
                decoration: _Styles.getTopBarButtonDecoration(context),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: context.theme.colorScheme.onTertiary,
                  size: AppStyles.kSize16,
                ),
              ),
            ),
            Spacer(),
            getMealFormBuilderDropDown(),
            AppStyles.kSizedBoxW8,
            GestureDetector(
              onTap: _onDeleteFoodPressed,
              child: Container(
                padding: AppStyles.kPadd8,
                decoration: _Styles.getTopBarButtonDecoration(context),
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  color: AppColors.redColor,
                  size: AppStyles.kSize16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Meal Form Builder Drop Down
  Widget getMealFormBuilderDropDown() {
    final mealTypes = [MealType.breakfast.value, MealType.lunch.value, MealType.dinner.value, MealType.snack.value];

    final loggedFood = context.read<MealScanLoggedFoodDetailsViewModel>().modifiedMealScanResult;

    return Container(
      padding: AppStyles.kPaddSH6,
      width: AppStyles.kSize100,
      decoration: _Styles.getFieldContainerDecoration(context),
      child: FormBuilderDropdown<String>(
        name: FormFields.mealType.name,
        initialValue: loggedFood.mealType,
        items: mealTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
        style: _Styles.getFieldDropDownTextStyle(context),
        decoration: _Styles.getFieldInputDecoration(),
        onChanged: (String? selectedMealType) {
          context.read<MealScanLoggedFoodDetailsViewModel>().updateMealType(mealType: selectedMealType ?? '');
        },
      ),
    );
  }

  // Scrollable Sheet
  Widget getScrollableSheet() {
    final isLoading = context.select((MealScanLoggedFoodDetailsViewModel vm) => vm.isLoading);
    final loggedFood = context.select((MealScanLoggedFoodDetailsViewModel vm) => vm.modifiedMealScanResult);

    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.88,
        builder: (context, scrollController) {
          return getScrollableSheetContainer(scrollController, loggedFood, isLoading);
        },
      ),
    );
  }

  // Scrollable Sheet Container
  Widget getScrollableSheetContainer(
    ScrollController scrollController,
    LoggedFoodModel loggedFood,
    bool isLoading,
  ) {
    final nutritionTotals = _calculateTotalNutrition(loggedFood.ingredients, loggedFood.quantity);

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
                getHeader(foodName: loggedFood.foodName, quantity: loggedFood.quantity),
                getNutritionScoreContainer(
                    healthScore: loggedFood.healthScore, healthScoreDesc: loggedFood.healthScoreDesc),
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
                    getIngredientListView(ingredients: loggedFood.ingredients),
                  ],
                ),
                AppStyles.kSizedBoxH32,
              ]
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
          GestureDetector(
            onTap: _decrementStepper,
            child: Padding(
              padding: AppStyles.kPadd3,
              child: FaIcon(FontAwesomeIcons.minus, size: AppStyles.kSize12),
            ),
          ),
          Text(quantity?.toStringAsFixed(1) ?? '0', style: _Styles.getNumberStepperLabelTextStyle(context)),
          GestureDetector(
            onTap: _incrementStepper,
            child: Padding(
              padding: AppStyles.kPadd3,
              child: FaIcon(FontAwesomeIcons.plus, size: AppStyles.kSize12),
            ),
          ),
        ],
      ),
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

  // Calorie Value Label
  TextSpan getCalorieValueLabel(double calorie) {
    return TextSpan(text: calorie.toStringAsFixed(2), style: _Styles.getCalorieValueLabelTextStyle(context));
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

  // Calorie Label
  Text getCalorieLabel() {
    return Text(S.current.calorieLabel, style: _Styles.getCalorieLabelTextStyle(context));
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
    final isLoading = context.select((MealScanLoggedFoodDetailsViewModel vm) => vm.isLoading);
    final mealScanResult = context.select((MealScanLoggedFoodDetailsViewModel vm) => vm.modifiedMealScanResult);

    final quantity = mealScanResult.quantity;
    final ingredients = mealScanResult.ingredients;

    final nutritionTotals = _calculateTotalNutrition(ingredients, quantity);
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
              getEditFoodButton(nutritionTotals: nutritionTotals),
            ]
          ],
        ),
      ),
    );
  }

  // Enhance with AI Button
  Widget getEnhanceWithAIButton() {
    return Expanded(
      child: GestureDetector(
        onTap: _onEnhanceWithAIPressed,
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

  // Edit Food Button
  Widget getEditFoodButton({required Map<String, double> nutritionTotals}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onEditFoodPressed(nutritionTotals: nutritionTotals),
        child: Container(
          padding: AppStyles.kPaddSV12,
          decoration: _Styles.getEditFoodButtonDecoration(context),
          child: Center(
            child: Text(S.current.editFoodLabel, style: _Styles.getEditFoodButtonTextStyle(context)),
          ),
        ),
      ),
    );
  }

  // Dismiss Button
  Widget getDismissButton() {
    return AppDefaultButton(
      label: S.current.dismissLabel,
      onPressed: _dismissPressed,
      padding: AppStyles.kPaddSV12,
      labelStyle: _Styles.getDismissButtonTextStyle(context),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Back Button Container Decoration
  static BoxDecoration getTopBarButtonDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.tertiary.withAlpha(150), shape: BoxShape.circle);
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

  // Scrollable Sheet Container Decoration
  static BoxDecoration getScrollableSheetDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.onPrimary, borderRadius: AppStyles.kRadVT15);
  }

  // Food Name Label Text Style
  static TextStyle getFoodNameLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
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

  // Number Stepper Label Text Style
  static TextStyle getNumberStepperLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium);
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

  // Nutrition Score Description Text Style
  static TextStyle getNutritionScoreContentTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Nutrition Score Label Text Style
  static TextStyle getNutritionScoreLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Nutrition Score Value Text Style
  static TextStyle getNutritionScoreValueTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
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

  // Calorie Unit Label Text Style
  static TextStyle getCalorieUnitLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onSurface);
  }

  // Calorie Icon Container Decoration
  static BoxDecoration getCalorieIconContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad100,
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

  // Edit Food Button Decoration
  static BoxDecoration getEditFoodButtonDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.primary,
      borderRadius: AppStyles.kRad10,
    );
  }

  // Edit Food Button Text Style
  static TextStyle getEditFoodButtonTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Dismiss Button Text Style
  static TextStyle getDismissButtonTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }
}
