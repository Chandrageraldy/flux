import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/selection_button.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class PlanSelectionModal extends BaseStatefulPage {
  const PlanSelectionModal({super.key});

  @override
  State<PlanSelectionModal> createState() => _PlanSelectionModalState();
}

class _PlanSelectionModalState extends BaseStatefulState<PlanSelectionModal> {
  @override
  Color backgroundColor() => context.theme.colorScheme.onPrimary;

  @override
  bool useGradientBackground() => false;

  @override
  bool isModal() => true;

  @override
  Widget body() {
    return Padding(
      padding: AppStyles.kPaddSV20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStyles.kSizedBoxH8,
          getTitleLabel(),
          AppStyles.kSizedBoxH4,
          getDescriptionLabel(),
          AppStyles.kSizedBoxH24,
          ...getPlanSelectionButtonList()
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PlanSelectionModalState {
  void _onManualCustomPlanPressed() {
    context.router.maybePop();
    context.router.push(ManualPlanSetupRoute());
  }

  void _onSmartPlanWithAIPressed() {
    context.router.push(SignUpRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PlanSelectionModalState {
  // Title Label
  Widget getTitleLabel() {
    return Text(S.current.planSelectionTitle, style: _Styles.getTitleLabelTextStyle(context));
  }

  // Description Label
  Widget getDescriptionLabel() {
    return Text(S.current.planSelectionDesc, style: _Styles.getDescriptionLabelTextStyle(context));
  }

  // Plan Selection Button List
  List<Widget> getPlanSelectionButtonList() {
    return [
      // Manual Custom Plan
      SelectionButton(
        title: S.current.planSelectionButtonTitle1,
        description: S.current.planSelectionButtonDesc1,
        icon: FaIcon(
          FontAwesomeIcons.pencil,
          color: context.theme.colorScheme.primary,
        ),
        onPressed: _onManualCustomPlanPressed,
      ),
      AppStyles.kSizedBoxH16,
      // Smart Plan with AI
      SelectionButton(
        title: S.current.planSelectionButtonTitle2,
        description: S.current.planSelectionButtonDesc2,
        icon: FaIcon(
          FontAwesomeIcons.rocket,
          color: context.theme.colorScheme.primary,
        ),
        onPressed: _onSmartPlanWithAIPressed,
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Label Text Style
  static getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Description Label Text Style
  static getDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }
}
