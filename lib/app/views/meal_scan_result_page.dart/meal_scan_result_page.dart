import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/meal_scan_vm/meal_scan_view_model.dart';
import 'package:flux/app/widgets/food/meal_scan_macronutrient_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;

@RoutePage()
class MealScanResultPage extends StatelessWidget {
  const MealScanResultPage({required this.imageFile, super.key});

  final XFile imageFile;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealScanViewModel(),
      child: _MealScanResultPage(imageFile: imageFile),
    );
  }
}

class _MealScanResultPage extends BaseStatefulPage {
  final XFile imageFile;

  const _MealScanResultPage({required this.imageFile});

  @override
  State<_MealScanResultPage> createState() => _MealScanResultPageState();
}

class _MealScanResultPageState extends BaseStatefulState<_MealScanResultPage> {
  File? croppedImageFile;
  bool isProcessing = true;
  int stepperCount = 1;

  @override
  void initState() {
    super.initState();
    _cropImageToSquare();
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
    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.88,
        builder: (context, scrollController) {
          return getScrollableSheetContainer(scrollController);
        },
      ),
    );
  }

  // Scrollable Sheet Container
  Widget getScrollableSheetContainer(ScrollController scrollController) {
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
              Row(
                spacing: AppStyles.kSpac12,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Chinese Crepe Delight with Egg and Sausage',
                        style: _Styles.getFoodNameLabelTextStyle(context)),
                  ),
                  getNumberStepper(),
                ],
              ),
              getHealthScoreContainer(),
              getCalorieContainer(),
              getMacronutrientsRow(),
              Text('Ingredients'.toUpperCase(), style: Quicksand.semiBold.withCustomSize(11))
            ],
          ),
        ),
      ),
    );
  }

  // Number Stepper
  Widget getNumberStepper() {
    return Container(
      decoration: _Styles.getNumberStepperContainerDecoration(context),
      padding: AppStyles.kPaddSV4H6,
      child: Row(
        spacing: AppStyles.kSpac24,
        children: [
          GestureDetector(onTap: _decrementStepper, child: FaIcon(FontAwesomeIcons.minus, size: AppStyles.kSize12)),
          Text('$stepperCount', style: _Styles.getNumberStepperLabelTextStyle(context)),
          GestureDetector(onTap: _incrementStepper, child: FaIcon(FontAwesomeIcons.plus, size: AppStyles.kSize12)),
        ],
      ),
    );
  }

  // Calories Container
  Widget getCalorieContainer() {
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
                text: TextSpan(children: [getCalorieValueLabel(500), getCalorieUnitLabel()]),
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
    return TextSpan(text: calorie.toString(), style: _Styles.getCalorieValueLabelTextStyle(context));
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
  Widget getMacronutrientsRow() {
    return Row(
      spacing: AppStyles.kSpac12,
      children: [
        MealScanMacronutrientCard(nutrient: MacroNutrients.protein, value: 22, icon: FontAwesomeIcons.fish),
        MealScanMacronutrientCard(nutrient: MacroNutrients.carbs, value: 10, icon: FontAwesomeIcons.wheatAwn),
        MealScanMacronutrientCard(nutrient: MacroNutrients.fat, value: 5, icon: FontAwesomeIcons.bacon)
      ],
    );
  }

  // Health Score Container
  Widget getHealthScoreContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getHealthScoreContainerDecoration(context),
      padding: AppStyles.kPaddSV10H12,
      child: Column(
        spacing: AppStyles.kSpac4,
        children: [
          getNutritionScoreHeader(),
          Text(
            'A protein-packed breakfast 🥚🥓 with eggs and sausage, offering sustained energy ⚡ from the crepe. Slightly high in sodium 🧂, but well-balanced for an active day 💪.',
            style: _Styles.getNutritionScoreContentTextStyle(context),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  // Nutrition Score Header
  Widget getNutritionScoreHeader() {
    return Row(
      spacing: AppStyles.kSpac4,
      children: [
        Icon(Icons.star_purple500_rounded, size: AppStyles.kSize20, color: context.theme.colorScheme.secondary),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(S.current.nutritionScoreLabel, style: _Styles.getNutritionScoreLabelTextStyle(context))],
        ),
        Spacer(),
        Text('7/10', style: _Styles.getNutritionScoreValueTextStyle(context)),
      ],
    );
  }

  // Action Button Row
  Widget getActionButtonRow() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: AppStyles.kPaddSV12H20,
        decoration: _Styles.getActionButtonContainerDecoration(context),
        child: Row(
          spacing: AppStyles.kSpac12,
          children: [getEnhanceWithAIButton(), getLogFoodButton()],
        ),
      ),
    );
  }

  // Enhance with AI Button
  Widget getEnhanceWithAIButton() {
    return Expanded(
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
    );
  }

  // Log Food Button
  Widget getLogFoodButton() {
    return Expanded(
      child: Container(
        padding: AppStyles.kPaddSV12,
        decoration: _Styles.getLogFoodButtonDecoration(context),
        child: Center(
          child: Text(S.current.logFoodLabel, style: _Styles.getLogFoodButtonTextStyle(context)),
        ),
      ),
    );
  }

  // Meal Form Builder Drop Down
  Widget getMealFormBuilderDropDown() {
    return Container(
      padding: AppStyles.kPaddSH6,
      width: AppStyles.kSize100,
      decoration: _Styles.getFieldContainerDecoration(context),
      child: FormBuilderDropdown<String>(
        name: FormFields.mealType.name,
        items: [
          DropdownMenuItem(value: MealType.breakfast.label, child: Text(MealType.breakfast.label)),
          DropdownMenuItem(value: MealType.lunch.label, child: Text(MealType.lunch.label)),
          DropdownMenuItem(value: MealType.dinner.label, child: Text(MealType.dinner.label)),
          DropdownMenuItem(value: MealType.snack.label, child: Text(MealType.snack.label)),
        ],
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

  // Health Score Container Decoration
  static BoxDecoration getHealthScoreContainerDecoration(BuildContext context) {
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
