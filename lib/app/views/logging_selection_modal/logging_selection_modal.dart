import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/selection_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class LoggingSelectionModal extends BaseStatefulPage {
  const LoggingSelectionModal({super.key});

  @override
  State<LoggingSelectionModal> createState() => _LoggingSelectionModalState();
}

class _LoggingSelectionModalState extends BaseStatefulState<LoggingSelectionModal> {
  @override
  Color backgroundColor() => context.theme.colorScheme.primary;

  @override
  bool useGradientBackground() => false;

  @override
  bool isModal() => true;

  @override
  Widget body() {
    return Padding(
      padding: AppStyles.kPaddO10B20,
      child: Column(
        spacing: AppStyles.kSpac16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AppStyles.kSizedBoxH2, ...getLoggingSelectionButtonList()],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _LoggingSelectionModalState {
  void _onLogFoodPressed() {
    context.router.replaceAll([FoodSearchRoute()]);
  }

  void _onMealScanIPressed() {}

  void _onBarcodeScanPressed() {}
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _LoggingSelectionModalState {
  // Logging Selection Button List
  List<Widget> getLoggingSelectionButtonList() {
    return [
      // Log Food
      SelectionButton(
        title: S.current.loggingSelectionButtonTitle1,
        description: S.current.loggingSelectionButtonDesc1,
        icon: FaIcon(
          FontAwesomeIcons.appleWhole,
          color: context.theme.colorScheme.primary,
        ),
        onPressed: _onLogFoodPressed,
      ),
      // Meal Scan
      SelectionButton(
        title: S.current.loggingSelectionButtonTitle2,
        description: S.current.loggingSelectionButtonDesc2,
        icon: FaIcon(
          FontAwesomeIcons.cameraRetro,
          color: context.theme.colorScheme.primary,
        ),
        onPressed: _onMealScanIPressed,
      ),
      SelectionButton(
        title: S.current.loggingSelectionButtonTitle3,
        description: S.current.loggingSelectionButtonDesc3,
        icon: FaIcon(
          FontAwesomeIcons.barcode,
          color: context.theme.colorScheme.primary,
        ),
        onPressed: _onBarcodeScanPressed,
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
// abstract class _Styles {}
