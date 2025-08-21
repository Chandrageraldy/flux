import 'package:flutter/material.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppStyles.kSpac4,
                children: [
                  FaIcon(action.icon, size: AppStyles.kSize14, color: context.theme.colorScheme.primary),
                  Text(action.label)
                ],
              ),
              Text('${action.exp} EXP'),
              Text('${action.energy} ENERGY'),
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
      color: isUpdatingCurrentExp
          ? context.theme.colorScheme.onPrimary.withAlpha(100)
          : context.theme.colorScheme.onPrimary.withAlpha(150),
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }
}
