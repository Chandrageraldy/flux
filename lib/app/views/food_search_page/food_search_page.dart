import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_model/food_model.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/viewmodels/food_search_vm/food_search_view_model.dart';
import 'package:flux/app/views/food_search_page_tab_bar_view/all_tab_bar_view.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class FoodSearchPage extends StatelessWidget {
  const FoodSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => FoodSearchViewModel(), child: _FoodSearchPage());
  }
}

class _FoodSearchPage extends BaseStatefulPage {
  @override
  State<_FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends BaseStatefulState<_FoodSearchPage> {
  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [getHeaderContainer(), getTabBarView()],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _FoodSearchPageState {
  void _onBarcodeScannerPressed() {}

  void _onFoodCardPressed(FoodResponseModel foodResponseModel) {
    FoodModel food = FoodModel(
      foodName: 'Dummy Food',
      calories: 100,
      protein: 5,
      fat: 2,
      carbohydrate: 20,
      servingQuantity: 1,
      servingUnit: ['piece', 'cup', 'gram'],
      nutrients: [],
    );
    context.router.push(FoodDetailsRoute(food: food, foodResponseModel: foodResponseModel));
  }

  void _onChanged(String value) async {
    await tryCatch(context, () => context.read<FoodSearchViewModel>().searchInstant(value));

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _FoodSearchPageState {
  // Header Container
  Widget getHeaderContainer() {
    return Container(
      padding: AppStyles.kPaddSV12H20,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        children: [
          AppStyles.kSizedBoxH20,
          Row(
            children: [Expanded(child: getSearchTextFormField()), AppStyles.kSizedBoxW12, getBarcodeScannerButton()],
          ),
          AppStyles.kSizedBoxH12,
          getTabBarContainer(),
        ],
      ),
    );
  }

  // Search Text Form Field
  Widget getSearchTextFormField() {
    return AppTextFormField(
      field: FormFields.search,
      placeholder: S.current.searchFoodPlaceholder,
      validator: FormBuilderValidators.compose([]),
      icon: FaIcon(FontAwesomeIcons.search, size: AppStyles.kIconSize16),
      onChanged: _onChanged,
    );
  }

  // Barcode Scanner Button
  Widget getBarcodeScannerButton() {
    return GestureDetector(
      onTap: _onBarcodeScannerPressed,
      child: Container(
        height: AppStyles.kSize48,
        width: AppStyles.kSize48,
        decoration: BoxDecoration(color: context.theme.colorScheme.tertiaryFixedDim, borderRadius: AppStyles.kRad10),
        child: Icon(Icons.qr_code_scanner, color: context.theme.colorScheme.primary),
      ),
    );
  }

  // Tabs Container
  Widget getTabBarContainer() {
    return Container(
      height: AppStyles.kSize30,
      decoration: _Styles.getTabBarContainerDecoration(context),
      child: TabBar(
        indicator: _Styles.getTabBarIndicatorDecoration(context),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: context.theme.colorScheme.onPrimary,
        unselectedLabelColor: context.theme.colorScheme.onTertiary,
        tabs: [Tab(text: S.current.allLabel), Tab(text: S.current.myMealsLabel), Tab(text: S.current.favoritesLabel)],
      ),
    );
  }

  // Tab Bar View
  Widget getTabBarView() {
    return Expanded(
      child: TabBarView(
        children: [getAllTabBarView(), getMyMealsTabBarView(), getFavoritesTabBarView()],
      ),
    );
  }

  // Tab Bar View -> "All"
  Widget getAllTabBarView() {
    return AllTabBarView(
      scrollController: _scrollController,
      onFoodCardPressed: _onFoodCardPressed,
      onBarcodeScannerPressed: _onBarcodeScannerPressed,
    );
  }

  // Tab Bar View -> "My Meals"
  Widget getMyMealsTabBarView() {
    return Center(child: Text(S.current.myMealsLabel));
  }

  // Tab Bar View -> "Favorites"
  Widget getFavoritesTabBarView() {
    return Center(child: Text(S.current.favoritesLabel));
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
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

  // Tab Bar Container Decoration
  static BoxDecoration getTabBarContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Tab Bar Indicator Decoration
  static BoxDecoration getTabBarIndicatorDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.primary,
      borderRadius: AppStyles.kRad10,
    );
  }
}
