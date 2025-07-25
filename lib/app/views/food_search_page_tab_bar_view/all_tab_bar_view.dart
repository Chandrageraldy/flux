import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/viewmodels/food_search_vm/food_search_view_model.dart';
import 'package:flux/app/widgets/food/food_action_header.dart';
import 'package:flux/app/widgets/food/food_display_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllTabBarView extends StatelessWidget {
  final ScrollController scrollController;
  final void Function(FoodResponseModel) onFoodCardPressed;
  final VoidCallback onBarcodeScannerPressed;

  const AllTabBarView({
    super.key,
    required this.scrollController,
    required this.onFoodCardPressed,
    required this.onBarcodeScannerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSH20,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [getFoodActionHeader(context), getFoodSliverList(context)],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AllTabBarView {
  // Food Sliver List
  Widget getFoodSliverList(BuildContext context) {
    final foodSearchResults = context.select((FoodSearchViewModel vm) => vm.foodSearchResults);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final food = foodSearchResults[index];
          return Padding(
            padding: AppStyles.kPaddOB12,
            child: FoodDisplayCard(
              foodName: food.foodName ?? '',
              calories: food.calorieKcal ?? 0,
              servingUnit: food.servingUnit ?? '',
              servingQuantity: food.servingQty ?? 0,
              brandName: food.brandName ?? '',
              onCardPressed: () => onFoodCardPressed(food),
            ),
          );
        },
        childCount: foodSearchResults.length,
      ),
    );
  }

  // Food Action Header
  Widget getFoodActionHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          AppStyles.kSizedBoxH12,
          Row(
            children: [
              Expanded(
                child: FoodActionHeader(
                  title: S.current.scanABarcodeLabel,
                  icon: FaIcon(
                    FontAwesomeIcons.barcode,
                    size: AppStyles.kIconSize20,
                    color: context.theme.colorScheme.primary,
                  ),
                  onPressed: onBarcodeScannerPressed,
                ),
              ),
              AppStyles.kSizedBoxW12,
              Expanded(
                child: FoodActionHeader(
                  title: S.current.scanAMealLabel,
                  icon: FaIcon(
                    FontAwesomeIcons.camera,
                    size: AppStyles.kIconSize20,
                    color: context.theme.colorScheme.primary,
                  ),
                  onPressed: onBarcodeScannerPressed,
                ),
              ),
            ],
          ),
          AppStyles.kSizedBoxH12,
        ],
      ),
    );
  }
}
