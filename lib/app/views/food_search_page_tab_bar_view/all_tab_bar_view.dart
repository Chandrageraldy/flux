import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/viewmodels/food_search_vm/food_search_view_model.dart';
import 'package:flux/app/widgets/empty_result/empty_result.dart';
import 'package:flux/app/widgets/food/food_display_card.dart';
import 'package:flux/app/widgets/skeleton/food_list_skeleton.dart';

class AllTabBarView extends StatelessWidget {
  final ScrollController scrollController;
  final void Function(FoodResponseModel) onFoodCardPressed;
  final VoidCallback onMealScanPressed;
  final VoidCallback onRefresh;
  final VoidCallback onBarcodeScanPressed;

  const AllTabBarView({
    super.key,
    required this.scrollController,
    required this.onFoodCardPressed,
    required this.onMealScanPressed,
    required this.onRefresh,
    required this.onBarcodeScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isSearching = context.select((FoodSearchViewModel vm) => vm.isSearching);

    return Padding(
      padding: AppStyles.kPaddSH16,
      child: RefreshIndicator(
        onRefresh: () async {
          onRefresh();
        },
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [if (!isSearching) getHeader(context), ...getFoodSliverList(context)],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AllTabBarView {
// Food Sliver List
  List<Widget> getFoodSliverList(BuildContext context) {
    final isSearching = context.select((FoodSearchViewModel vm) => vm.isSearching);
    final foodSearchResults = context.select((FoodSearchViewModel vm) => vm.foodSearchResults);
    final recentFoodResults = context.select((FoodSearchViewModel vm) => vm.recentFoodResults);

    final isRecentFoodLoading = context.select((FoodSearchViewModel vm) => vm.isRecentFoodLoading);

    final List<FoodResponseModel> foodList =
        isSearching ? foodSearchResults : recentFoodResults.map((e) => e.toFoodResponseModel()).toList();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: isRecentFoodLoading ? AppStyles.kPaddOT16 : AppStyles.kPaddOT16B6,
          child: Text(
            isSearching ? S.current.searchResultLabel.toUpperCase() : S.current.recentlyViewedLabel.toUpperCase(),
            style: Quicksand.semiBold.withCustomSize(11),
          ),
        ),
      ),
      if (foodList.isNotEmpty) ...[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final food = foodList[index];
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
            childCount: foodList.length, // ✅ Corrected this line
          ),
        )
      ] else ...[
        if (isRecentFoodLoading)
          FoodListSkeleton()
        else
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyResult(
              imagePath: ImagePath.pizza,
              title: isSearching ? S.current.noResultFoundLabel : S.current.noRecentItemsLabel,
              message: isSearching ? S.current.noResultFoundMessage : S.current.noRecentItemsMessage,
            ),
          ),
      ]
    ];
  }

  // Food Action Header
  Widget getHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          AppStyles.kSizedBoxH12,
          Row(
            spacing: AppStyles.kSpac8,
            children: [
              getHeaderActionButton(
                  context, S.current.scanABarcodeLabel, Icons.qr_code_scanner_outlined, onBarcodeScanPressed),
              getHeaderActionButton(context, S.current.scanYourMealLabel, Icons.camera_enhance, onMealScanPressed),
            ],
          )
        ],
      ),
    );
  }

  // Header Action Button
  Widget getHeaderActionButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: AppStyles.kPaddSV8H12,
          decoration: _Styles.getHeaderActionButtonContainerDecoration(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppStyles.kSpac4,
            children: [
              Icon(icon, size: AppStyles.kSize20, color: context.theme.colorScheme.secondary),
              Text(label, style: _Styles.getHeaderActionLabelTextStyle(context))
            ],
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Header Action Label Text Style
  static TextStyle getHeaderActionLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Header Action Row Button Container Decoration
  static BoxDecoration getHeaderActionButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }
}
