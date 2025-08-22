import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_pet_model/user_pet_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/virtual_pet_shop_vm/virtual_pet_shop_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class VirtualPetShopPage extends StatelessWidget {
  const VirtualPetShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VirtualPetShopViewModel(),
      child: _VirtualPetShopPage(),
    );
  }
}

class _VirtualPetShopPage extends BaseStatefulPage {
  @override
  State<_VirtualPetShopPage> createState() => _VirtualPetShopPageState();
}

class _VirtualPetShopPageState extends BaseStatefulState<_VirtualPetShopPage> {
  @override
  PreferredSizeWidget? appbar() => const DefaultAppBar();

  @override
  void initState() {
    super.initState();
    _getVirtualPets();
    _getUserEnergies();
  }

  @override
  Widget body() {
    return Column(
      children: [
        getEnergiesContainer(),
        getPetsGridView(),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _VirtualPetShopPageState {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _VirtualPetShopPageState {
  Future<void> _getVirtualPets() async {
    await tryLoad(context, () => context.read<VirtualPetShopViewModel>().getVirtualPets());
  }

  Future<void> _buyPet({required int petId, required int energyCost}) async {
    final userEnergy = context.read<VirtualPetShopViewModel>().userEnergy;

    if ((userEnergy.energies ?? 0) < energyCost) {
      WidgetUtils.showSnackBar(context, S.current.notEnoughEnergyMessage);
      return;
    }

    await tryLoad(context, () => context.read<VirtualPetShopViewModel>().buyPet(petId: petId, energyCost: energyCost));
  }

  Future<void> _equipPet({required int petId}) async {
    await tryLoad(context, () => context.read<VirtualPetShopViewModel>().equipPet(petId: petId));
  }

  Future<void> _getUserEnergies() async {
    await tryLoad(context, () => context.read<VirtualPetShopViewModel>().getUserEnergies());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _VirtualPetShopPageState {
  // Energies Container
  Widget getEnergiesContainer() {
    final userEnergy = context.select((VirtualPetShopViewModel vm) => vm.userEnergy);
    return Container(
      decoration: _Styles.getEnergiesContainerDecoration(context),
      padding: AppStyles.kPaddSV6H12,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          FaIcon(FontAwesomeIcons.boltLightning, size: AppStyles.kSize16),
          Text('${userEnergy.energies}'),
        ],
      ),
    );
  }

  // Pets Grid View
  Widget getPetsGridView() {
    final userPets = context.select((VirtualPetShopViewModel vm) => vm.userPets);
    final shopPets = context.select((VirtualPetShopViewModel vm) => vm.shopPets);
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: shopPets.length,
        itemBuilder: (context, index) {
          final item = shopPets[index];
          return _buildPetCard(item, userPets);
        },
      ),
    );
  }

  Widget _buildPetCard(ShopPetItem item, List<UserPetModel> userPets) {
    final userPet = userPets.firstWhere(
      (p) => p.petId == item.pet.petId,
      orElse: () => UserPetModel(),
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.asset(
                ImagePath.egg,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.pet.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            if (!item.isOwned)
              ElevatedButton(
                onPressed: () {
                  _buyPet(petId: item.pet.petId ?? 0, energyCost: item.pet.energyCost ?? 0);
                },
                child: Text('Buy (${item.pet.energyCost} ⚡)'),
              )
            else if (userPet.isActive == true)
              const Text(
                'Equipped',
                style: TextStyle(color: Colors.green),
              )
            else
              ElevatedButton(
                onPressed: () {
                  _equipPet(petId: item.pet.petId ?? 0);
                },
                child: const Text('Equip'),
              ),
          ],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Energies Container Decoration
  static BoxDecoration getEnergiesContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary.withAlpha(150),
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }
}
