import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/virtual_pet_action_model/virtual_pet_action_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VirtualPetActionButton extends StatelessWidget {
  const VirtualPetActionButton({
    required this.action,
    required this.userEnergy,
    required this.isUpdatingCurrentExp,
    required this.onActionButtonPressed,
    super.key,
  });

  final VirtualPetActionModel action;
  final UserEnergyModel userEnergy;
  final bool isUpdatingCurrentExp;
  final void Function({required VirtualPetActionModel action, required UserEnergyModel userEnergy})
      onActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          isUpdatingCurrentExp ? null : onActionButtonPressed(action: action, userEnergy: userEnergy);
        },
        child: Container(
          decoration: _Styles.getVirtualPetActionButtonDecoration(context, isUpdatingCurrentExp),
          padding: AppStyles.kPaddSV4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppStyles.kSpac4,
            children: [
              Container(
                padding: AppStyles.kPadd8,
                decoration: _Styles.getActionIconContainerDecoration(context, action.color),
                child: FaIcon(action.icon, size: AppStyles.kSize12, color: context.theme.colorScheme.onPrimary),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(action.label, style: Quicksand.bold.withSize(FontSizes.small)),
                  Row(
                    children: [
                      Text('${action.energy}', style: Quicksand.medium.withSize(FontSizes.extraSmall)),
                      AppStyles.kSizedBoxW2,
                      Image.asset(ImagePath.energy, height: AppStyles.kSize12),
                      AppStyles.kSizedBoxW4,
                      Text('${action.exp}', style: Quicksand.medium.withSize(FontSizes.extraSmall)),
                      AppStyles.kSizedBoxW2,
                      Text(S.current.xpLabel, style: Quicksand.bold.withCustomSize(8)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Action Button Decoration
  static BoxDecoration getVirtualPetActionButtonDecoration(BuildContext context, bool isUpdatingCurrentExp) {
    return BoxDecoration(
      color: isUpdatingCurrentExp ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Action Icon Container Decoration
  static BoxDecoration getActionIconContainerDecoration(BuildContext context, Color color) {
    return BoxDecoration(color: color, shape: BoxShape.circle);
  }
}
