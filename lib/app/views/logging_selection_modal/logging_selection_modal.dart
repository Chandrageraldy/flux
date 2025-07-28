import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/logging_selection_button.dart';
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
      padding: AppStyles.kPaddSV15,
      child: Row(
        spacing: AppStyles.kSpac16,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [...getLoggingSelectionButtonList()],
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
      LoggingSelectionButton(
        icon: FaIcon(
          FontAwesomeIcons.appleWhole,
          color: context.theme.colorScheme.primary,
          size: AppStyles.kSize16,
        ),
        label: S.current.loggingSelectionButtonTitle1,
        onPressed: _onLogFoodPressed,
      ),
      // Barcode Scan
      LoggingSelectionButton(
        icon: FaIcon(
          FontAwesomeIcons.qrcode,
          color: context.theme.colorScheme.primary,
          size: AppStyles.kSize16,
        ),
        label: S.current.loggingSelectionButtonTitle3,
        onPressed: _onBarcodeScanPressed,
      ),
      // Meal Scan
      LoggingSelectionButton(
        icon: FaIcon(
          FontAwesomeIcons.cameraRetro,
          color: context.theme.colorScheme.primary,
          size: AppStyles.kSize16,
        ),
        label: S.current.loggingSelectionButtonTitle2,
        onPressed: _onMealScanIPressed,
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
// abstract class _Styles {}
