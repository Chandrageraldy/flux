import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class ScanBarcodePage extends BaseStatefulPage {
  const ScanBarcodePage({super.key});

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends BaseStatefulState<ScanBarcodePage> {
  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  final MobileScannerController controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates, facing: CameraFacing.back, returnImage: true);

  bool isFlashOn = false;

  @override
  Widget body() {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final barcode = capture.barcodes.first;
            debugPrint(barcode.rawValue);
          },
        ),
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
extension _Actions on _ScanBarcodePageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ScanBarcodePageState {
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
        decoration: _Styles.flashlightButtonContainerDecoration(context, isFlashOn),
        padding: AppStyles.kPadd6,
        child: Icon(
          isFlashOn == true ? Icons.flashlight_on_outlined : Icons.flashlight_off_outlined,
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
                Text(S.current.locatingBarcodeLabel, style: _Styles.labelTextStyle(context)),
              ],
            ),
            Text(S.current.locatingBarcodeDesc, style: _Styles.descriptionTextStyle(context)),
          ],
        ),
      ),
    );
  }

  // Frame Container
  Widget getFrameContainer() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: AppStyles.kPaddSH20,
        child: Container(
          width: double.infinity,
          height: AppStyles.kSize150,
          decoration: _Styles.frameContainerDecoration(context),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
class _Styles {
  // Flashlight Button Container Decoration
  static BoxDecoration flashlightButtonContainerDecoration(BuildContext context, bool isFlashOn) {
    return BoxDecoration(
      color: isFlashOn == true ? context.theme.colorScheme.onPrimary : Colors.transparent,
      shape: BoxShape.circle,
    );
  }

  // Label Text Style
  static TextStyle labelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Description Text Style
  static TextStyle descriptionTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Frame Container Decoration
  static BoxDecoration frameContainerDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        color: context.theme.colorScheme.onPrimary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
