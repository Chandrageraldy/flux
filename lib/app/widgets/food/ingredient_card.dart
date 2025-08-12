import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({super.key, required this.ingredient, required this.onPressed, required this.onDeletePressed});

  final IngredientModel ingredient;
  final void Function(IngredientModel) onPressed;
  final void Function() onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddOB12,
      child: GestureDetector(
        onTap: () => onPressed(ingredient),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onPrimary,
            borderRadius: AppStyles.kRad10,
            boxShadow: [
              BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
            ],
          ),
          padding: AppStyles.kPaddSV8H12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: AppStyles.kSpac8,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.foodName ?? 'Unknown Ingredient',
                      style: _Styles.getFoodNameLabelTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      spacing: AppStyles.kSpac4,
                      children: [
                        Text('${ingredient.servingQty} ${ingredient.servingUnit}',
                            style: _Styles.getServingLabelTextStyle(context)),
                        NutritionTag(
                          label: '${ingredient.calorie?.toStringAsFixed(2)}kcal',
                          icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                spacing: AppStyles.kSpac12,
                children: [
                  FaIcon(FontAwesomeIcons.edit, size: AppStyles.kSize14),
                  GestureDetector(
                      onTap: onDeletePressed,
                      child: FaIcon(FontAwesomeIcons.trashCan, size: AppStyles.kSize14, color: AppColors.redColor)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on IngredientCard {}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Food Name Label Text Style
  static TextStyle getFoodNameLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small);
  }

  // Serving Label Text Style
  static TextStyle getServingLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall);
  }
}
