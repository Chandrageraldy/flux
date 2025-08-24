import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_pet_model/user_pet_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/virtual_pet_shop_vm/virtual_pet_shop_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class VirtualPetShopPage extends StatelessWidget {
  const VirtualPetShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => VirtualPetShopViewModel(), child: _VirtualPetShopPage());
  }
}

class _VirtualPetShopPage extends BaseStatefulPage {
  @override
  State<_VirtualPetShopPage> createState() => _VirtualPetShopPageState();
}

class _VirtualPetShopPageState extends BaseStatefulState<_VirtualPetShopPage> {
  late PageController _pageController;

  int _currentPageIndex = 0;

  bool _needRefresh = false;

  @override
  PreferredSizeWidget? appbar() => const DefaultAppBar();

  @override
  bool isModal() => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VirtualPetShopViewModel>().initialize();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    final isLoading = context.select((VirtualPetShopViewModel vm) => vm.isLoading);

    return SizedBox(
      width: AppStyles.kDoubleInfinity,
      child: Padding(
        padding: AppStyles.kPaddSV12H4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac12,
          children: [
            getHeader(),
            if (isLoading) ...[
              Skeleton(height: AppStyles.kSize200, width: AppStyles.kDoubleInfinity),
              Skeleton(height: AppStyles.kSize45, width: AppStyles.kDoubleInfinity)
            ] else ...[
              getPetsContainer(),
              getActionButton(),
            ]
          ],
        ),
      ),
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
extension _Actions on _VirtualPetShopPageState {
  Future<void> _buyPet({required int petId, required int energyCost}) async {
    final userEnergy = context.read<VirtualPetShopViewModel>().userEnergy;

    if ((userEnergy.energies ?? 0) < energyCost) {
      WidgetUtils.showSnackBar(context, S.current.notEnoughEnergyMessage);
      return;
    }

    await tryLoad(context, () => context.read<VirtualPetShopViewModel>().buyPet(petId: petId, energyCost: energyCost));
    _needRefresh = true;
  }

  Future<void> _equipPet({required int petId}) async {
    await tryLoad(context, () => context.read<VirtualPetShopViewModel>().equipPet(petId: petId));
    _needRefresh = true;

    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _VirtualPetShopPageState {
  // Header
  Widget getHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppStyles.kSpac4,
            children: [
              Row(
                spacing: AppStyles.kSpac8,
                children: [
                  FaIcon(FontAwesomeIcons.bagShopping, size: AppStyles.kSize16),
                  Text(S.current.chooseYourCompanionLabel, style: _Styles.getHeaderTitleTextStyle(context)),
                ],
              ),
              Text(S.current.chooseYourCompanionMessage, style: _Styles.getHeaderMessageTextStyle(context)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.router.maybePop(_needRefresh),
          child: Icon(Icons.close, size: AppStyles.kSize20, color: context.theme.colorScheme.onTertiaryContainer),
        )
      ],
    );
  }

  // Pets Container
  Widget getPetsContainer() {
    final userPets = context.select((VirtualPetShopViewModel vm) => vm.userPets);
    final shopPets = context.select((VirtualPetShopViewModel vm) => vm.shopPets);

    if (shopPets.isEmpty) {
      return AppStyles.kEmptyWidget;
    }

    return Container(
      padding: AppStyles.kPadd12,
      decoration: _Styles.getPetContainerDecoration(context),
      child: SizedBox(
        height: AppStyles.kSize200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: shopPets.length,
              onPageChanged: (index) {
                _setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final item = shopPets[index];
                return getPetCard(item, userPets);
              },
            ),
            getPreviousButton(),
            getNextButton(),
            getPageIndicatorRow(items: shopPets),
          ],
        ),
      ),
    );
  }

  // Previous Button
  Widget getPreviousButton() {
    return Positioned(
      left: 0,
      child: GestureDetector(
        onTap: () {
          if (_pageController.page! > 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Container(
          decoration: _Styles.getNextPreviousButtonDecoration(context),
          padding: AppStyles.kPadd6,
          child: Icon(Icons.arrow_back, color: context.theme.colorScheme.onPrimary, size: AppStyles.kSize20),
        ),
      ),
    );
  }

  // Next Button
  Widget getNextButton() {
    final shopPets = context.read<VirtualPetShopViewModel>().shopPets;
    return Positioned(
      right: 0,
      child: GestureDetector(
        onTap: () {
          if (_pageController.page! < shopPets.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Container(
          decoration: _Styles.getNextPreviousButtonDecoration(context),
          padding: AppStyles.kPadd6,
          child: Icon(Icons.arrow_forward, color: context.theme.colorScheme.onPrimary, size: AppStyles.kSize20),
        ),
      ),
    );
  }

  // Pet Card
  Widget getPetCard(ShopPetItem item, List<UserPetModel> userPets) {
    return Center(
      child: Padding(
        padding: AppStyles.kPadd12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getPetImage(),
            getPetNameLabel(item: item),
            getEnergyCostContainer(energyCost: item.pet.energyCost ?? 0),
            AppStyles.kSizedBoxH24,
          ],
        ),
      ),
    );
  }

  // Page Indicator Row
  Widget getPageIndicatorRow({required List<ShopPetItem> items}) {
    return Positioned(
      bottom: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppStyles.kSpac8,
        children: [
          FaIcon(FontAwesomeIcons.chevronLeft, size: AppStyles.kSize10),
          Row(spacing: AppStyles.kSpac4, children: List.generate(items.length, (index) => getPageIndicator(index))),
          FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kSize10),
        ],
      ),
    );
  }

  // Page Indicator
  Widget getPageIndicator(int index) {
    return Container(
      width: AppStyles.kSize8,
      height: AppStyles.kSize8,
      decoration: _Styles.getPageIndicatorContainerDecoration(context, index, _currentPageIndex),
    );
  }

  // Pet Image
  Widget getPetImage() {
    return Image.asset(
      ImagePath.egg,
      fit: BoxFit.contain,
    );
  }

  // Pet Name Label
  Widget getPetNameLabel({required ShopPetItem item}) {
    return Text(item.pet.name ?? '', style: _Styles.getPetNameLabelTextStyle(context));
  }

  // Action Button
  Widget getActionButton() {
    String label;
    VoidCallback? onTap;
    Color backgroundColor = context.theme.colorScheme.secondary;
    Color textColor = context.theme.colorScheme.onPrimary;

    final shopPets = context.select((VirtualPetShopViewModel vm) => vm.shopPets);
    final userPets = context.select((VirtualPetShopViewModel vm) => vm.userPets);
    final userEnergy = context.select((VirtualPetShopViewModel vm) => vm.userEnergy);

    if (shopPets.isEmpty) {
      return const SizedBox.shrink();
    }

    bool canBuy = (userEnergy.energies ?? 0) >= (shopPets[_currentPageIndex].pet.energyCost ?? 0);

    final currentPet = shopPets[_currentPageIndex];
    final userPet = userPets.firstWhere(
      (p) => p.petId == currentPet.pet.petId,
      orElse: () => UserPetModel(),
    );

    if (!currentPet.isOwned) {
      textColor = canBuy ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiary;
      label = canBuy ? S.current.buyLabel : S.current.notEnoughEnergyLabel;
      onTap = () => canBuy
          ? _buyPet(
              petId: currentPet.pet.petId ?? 0,
              energyCost: currentPet.pet.energyCost ?? 0,
            )
          : null;
      backgroundColor = canBuy ? context.theme.colorScheme.secondary : context.theme.colorScheme.tertiary;
    } else if (userPet.isActive == true) {
      label = S.current.equippedLabel;
      onTap = null;
      backgroundColor = Color(0xff369376);
    } else {
      label = S.current.equipLabel;
      onTap = () => _equipPet(petId: currentPet.pet.petId ?? 0);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: AppStyles.kPaddSV12,
        decoration: _Styles.getActionButtonDecoration(context, backgroundColor),
        alignment: Alignment.center,
        child: Text(label, style: _Styles.getActionButtonLabelTextStyle(context, textColor)),
      ),
    );
  }

  // Energy Cost Container
  Widget getEnergyCostContainer({required int energyCost}) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppStyles.kSpac4,
        children: [
          Image.asset(ImagePath.energy, height: AppStyles.kSize12),
          Text('$energyCost', style: Quicksand.medium.withSize(FontSizes.small)),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Pet Name Label Text Style
  static TextStyle getPetNameLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.primary);
  }

  // Page Indicator Container Decoration
  static BoxDecoration getPageIndicatorContainerDecoration(BuildContext context, int index, int currentPageIndex) {
    return BoxDecoration(
      color: currentPageIndex == index ? context.theme.colorScheme.secondary : context.theme.colorScheme.tertiary,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Header Title Label
  static TextStyle getHeaderTitleTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Header Message Label
  static TextStyle getHeaderMessageTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall).copyWith(
          color: context.theme.colorScheme.onTertiaryContainer,
        );
  }

  // Pet Container Decoration
  static BoxDecoration getPetContainerDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: GradientAppColors.primaryGradient,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: Offset(0, 2)),
      ],
    );
  }

  // Next Previous Button Decoration
  static BoxDecoration getNextPreviousButtonDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: GradientAppColors.secondaryGradient,
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2))
      ],
    );
  }

  // Action Button Decoration
  static BoxDecoration getActionButtonDecoration(BuildContext context, Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Action Button Label Text Style
  static TextStyle getActionButtonLabelTextStyle(BuildContext context, Color textColor) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: textColor);
  }
}
