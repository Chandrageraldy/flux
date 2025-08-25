import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/utils/utils/painters.dart';
import 'package:flux/app/viewmodels/barcode_scan_vm/barcode_scan_view_model.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class BarcodeScanPage extends StatelessWidget {
  const BarcodeScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => BarcodeScanViewModel(), child: _BarcodeScanPage());
  }
}

class _BarcodeScanPage extends BaseStatefulPage {
  @override
  State<_BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends BaseStatefulState<_BarcodeScanPage> {
  @override
  bool hasDefaultPadding() => false;

  @override
  bool useGradientBackground() => false;

  @override
  Color backgroundColor() => context.theme.colorScheme.onPrimary;

  final MobileScannerController controller = MobileScannerController(
    facing: CameraFacing.back,
  );

  bool isFlashOn = false;
  bool isProcessing = false;

  @override
  Widget body() {
    return Stack(
      children: [
        MobileScanner(controller: controller, onDetect: _onBarcodeDetected),
        getTopNavigationBar(),
        getLabelColumn(),
        getFrameContainer(),
      ],
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
extension _Actions on _BarcodeScanPageState {
  void _onBarcodeDetected(BarcodeCapture capture) async {
    if (isProcessing) return;

    final barcode = capture.barcodes.first;
    debugPrint('Barcode detected: ${barcode.rawValue}');

    isProcessing = true;

    final result = await tryLoad(
        context, () => context.read<BarcodeScanViewModel>().getFoodDetailsWithUPC(upc: barcode.rawValue ?? ''));

    if (!mounted) return;

    if (result == true) {
      final scannedFood = context.read<BarcodeScanViewModel>().scannedFood;
      context.router.push(FoodDetailsRoute(foodResponseModel: scannedFood, saveRecent: true)).then((_) {
        isProcessing = false;
      });
    } else {
      context.router
          .push(ErrorRoute(
        label: S.current.barcodeNotRecognizedLabel,
        description: S.current.barcodeNotRecognizedDesc,
        actions: [getTryAgainButton(), getUseAiMealScanButton()],
        icon: Icons.qr_code_scanner_outlined,
        iconBackgroundColor: AppColors.redColor,
      ))
          .then((_) {
        isProcessing = false;
      });
    }
  }

  void _tryAgainPressed() {
    context.router.maybePop();
  }

  void _useAiMealScanPressed() {}
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _BarcodeScanPageState {
  // Top Navigation Bar
  Widget getTopNavigationBar() {
    return Positioned(
      top: 30,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [getBackButton(), getFlashlightButton()],
      ),
    );
  }

  // Back Button
  Widget getBackButton() {
    return GestureDetector(
      onTap: () => context.router.maybePop(),
      child: FaIcon(
        FontAwesomeIcons.arrowLeft,
        color: context.theme.colorScheme.onPrimary,
        size: AppStyles.kSize20,
      ),
    );
  }

  // Flashlight Button
  Widget getFlashlightButton() {
    return GestureDetector(
      onTap: () {
        controller.toggleTorch();
        _setState(() {
          isFlashOn = !isFlashOn;
        });
      },
      child: Container(
        decoration: _Styles.getFlashlightButtonContainerDecoration(context, isFlashOn),
        padding: AppStyles.kPadd6,
        child: Icon(
          isFlashOn == true ? Icons.flash_on : Icons.flash_off_outlined,
          color: isFlashOn == true ? context.theme.colorScheme.onTertiary : context.theme.colorScheme.onPrimary,
          size: AppStyles.kSize20,
        ),
      ),
    );
  }

  // Label Column
  Widget getLabelColumn() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 64,
      left: 0,
      right: 0,
      child: Center(
        child: Column(
          children: [
            Row(
              spacing: AppStyles.kSize8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.qr_code_scanner_sharp, color: context.theme.colorScheme.onPrimary),
                Text(S.current.locatingBarcodeLabel, style: _Styles.getLabelTextStyle(context)),
              ],
            ),
            Text(S.current.locatingBarcodeDesc, style: _Styles.getDescriptionTextStyle(context)),
          ],
        ),
      ),
    );
  }

  Widget getFrameContainer() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: AppStyles.kPaddSH20,
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: CustomPaint(
            painter: CornerFramePainter(color: context.theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }

  // Try Again Button
  Widget getTryAgainButton() {
    return AppDefaultButton(
      label: S.current.tryAgainLabel.toUpperCase(),
      onPressed: _tryAgainPressed,
      padding: AppStyles.kPaddSV12,
      labelStyle: _Styles.getTryAgainButtonTextStyle(context),
    );
  }

  // Use AI Meal Scan Button
  Widget getUseAiMealScanButton() {
    return AppDefaultButton(
      label: S.current.useAiMealScanLabel.toUpperCase(),
      onPressed: _useAiMealScanPressed,
      padding: AppStyles.kPaddSV12,
      labelStyle: _Styles.getUseAiMealScanButtonTextStyle(context),
      backgroundColor: context.theme.colorScheme.secondary.withAlpha(20),
    );
  }
}

// * ----------------------------- Styles ----------------------------
class _Styles {
  // Flashlight Button Container Decoration
  static BoxDecoration getFlashlightButtonContainerDecoration(BuildContext context, bool isFlashOn) {
    return BoxDecoration(
      color: isFlashOn == true ? context.theme.colorScheme.onPrimary : AppColors.transparentColor,
      shape: BoxShape.circle,
    );
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Description Text Style
  static TextStyle getDescriptionTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Try Again Button Text Style
  static TextStyle getTryAgainButtonTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Use AI Meal Scan Button Text Style
  static TextStyle getUseAiMealScanButtonTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary);
  }
}
