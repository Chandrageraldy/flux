import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodDisplayCard extends StatelessWidget {
  const FoodDisplayCard({
    required this.calories,
    required this.foodName,
    required this.servingUnit,
    required this.servingQuantity,
    required this.onCardPressed,
    required this.brandName,
    super.key,
  });

  final double calories;
  final String foodName;
  final String servingUnit;
  final double servingQuantity;
  final VoidCallback onCardPressed;
  final String brandName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPressed,
      child: Container(
        decoration: _Styles.getFoodCardContainerDecoration(context),
        child: Padding(padding: AppStyles.kPaddSV16H16, child: getContentRow(context)),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on FoodDisplayCard {
  // Content Row
  Widget getContentRow(BuildContext context) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppStyles.kSpac4,
            children: [getTitleLabel(context), getServingAndBrandRow(context)],
          ),
        ),
        getCalorieTag(context),
        getIcon(context),
      ],
    );
  }

  // Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(
      foodName,
      style: _Styles.getTitleLabelTextStyle(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  // Get Icon
  Widget getIcon(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.chevronRight,
      size: AppStyles.kIconSize16,
    );
  }

  // Description Label
  // Widget getDescriptionLabel(BuildContext context) {
  //   return Text(
  //     '$servingQuantity $servingUnit',
  //     style: _Styles.getDescriptionTextStyle(context),
  //     maxLines: 1,
  //     overflow: TextOverflow.ellipsis,
  //     softWrap: false,
  //   );
  // }

  // Serving and Brand Row
  Widget getServingAndBrandRow(BuildContext context) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [
        Flexible(child: getServingRow(context)),
        if (brandName.isNotEmpty) Flexible(child: getBrandRow(context)),
      ],
    );
  }

  // Serving Row
  Widget getServingRow(BuildContext context) {
    return Row(
      spacing: AppStyles.kSpac4,
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(FontAwesomeIcons.pencil, size: AppStyles.kIconSize12),
        Flexible(
          child: Text(
            '$servingQuantity $servingUnit',
            style: _Styles.getServingAndBrandLabelTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget getBrandRow(BuildContext context) {
    return Row(
      spacing: AppStyles.kSpac4,
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(FontAwesomeIcons.tags, size: AppStyles.kIconSize12),
        Flexible(
          child: Text(
            brandName,
            style: _Styles.getServingAndBrandLabelTextStyle(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Calorie Tag
  Widget getCalorieTag(BuildContext context) {
    return NutritionTag(
      label: calories.toString(),
      icon: FaIcon(
        FontAwesomeIcons.fire,
        size: AppStyles.kIconSize16,
      ),
    );
  }

  // Icon Container
  // Widget getIconContainer(BuildContext context) {
  //   return GestureDetector(
  //     onTap: onCardPressed,
  //     child: Container(
  //       width: 32,
  //       height: 32,
  //       decoration: _Styles.getIconContainerDecoration(context),
  //       child: Center(child: getIcon(context)),
  //     ),
  //   );
  // }

  // Get Icon
  // Widget getIcon(BuildContext context) {
  //   return FaIcon(
  //     FontAwesomeIcons.add,
  //     size: AppStyles.kIconSize20,
  //     color: context.theme.colorScheme.onPrimary,
  //   );
  // }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getFoodCardContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Title Label Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Serving and Brand Label Text Style
  static TextStyle getServingAndBrandLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small);
  }
}
