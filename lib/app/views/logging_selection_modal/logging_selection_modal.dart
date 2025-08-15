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
    return SizedBox(
      width: AppStyles.kDoubleInfinity,
      child: Padding(
        padding: AppStyles.kPaddSV16H12,
        child: Column(
          spacing: AppStyles.kSpac20,
          children: [...getLoggingSelectionButtonList()],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _LoggingSelectionModalState {
  void _onLogFoodPressed() {
    context.router.replaceAll([FoodSearchRoute()]);
  }

  void _onMealScanIPressed() {
    context.router.push(MealScanRoute());
  }

  void _onBarcodeScanPressed() {
    context.router.push(BarcodeScanRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _LoggingSelectionModalState {
  // Logging Selection Button List
  List<Widget> getLoggingSelectionButtonList() {
    return [
      // Log Food
      LoggingSelectionButton(
        icon: FaIcon(FontAwesomeIcons.appleWhole, color: MacroNutrients.protein.color, size: AppStyles.kSize16),
        label: S.current.loggingSelectionButtonTitle1,
        onPressed: _onLogFoodPressed,
      ),
      // Barcode Scan
      LoggingSelectionButton(
        icon: FaIcon(FontAwesomeIcons.qrcode, color: MacroNutrients.carbs.color, size: AppStyles.kSize16),
        label: S.current.loggingSelectionButtonTitle3,
        onPressed: _onBarcodeScanPressed,
      ),
      // Meal Scan
      LoggingSelectionButton(
        icon: FaIcon(FontAwesomeIcons.cameraRetro, color: MacroNutrients.fat.color, size: AppStyles.kSize16),
        label: S.current.loggingSelectionButtonTitle2,
        onPressed: _onMealScanIPressed,
      ),
    ];
  }
}
