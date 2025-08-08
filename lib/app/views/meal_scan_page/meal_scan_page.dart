import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:camera/camera.dart';
import 'package:flux/app/utils/handler/starter_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class MealScanPage extends BaseStatefulPage {
  const MealScanPage({super.key});

  @override
  State<MealScanPage> createState() => _MealScanPageState();
}

class _MealScanPageState extends BaseStatefulState<MealScanPage> {
  CameraController? controller;
  FlashMode currentFlashMode = FlashMode.off;

  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> snapPicture() async {
    if (controller == null || !controller!.value.isInitialized || controller!.value.isTakingPicture) {
      return;
    }

    final XFile picture = await controller!.takePicture();
    debugPrint('Picture taken: ${picture.path}');
  }

  @override
  Widget body() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [getCameraPreview(), getTopNavigationBar(), getSnapPictureButton()],
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
extension _Actions on _MealScanPageState {
  Future<void> cycleFlashMode() async {
    if (controller == null || !controller!.value.isInitialized) return;

    FlashMode newMode;
    switch (currentFlashMode) {
      case FlashMode.off:
        newMode = FlashMode.auto;
        break;
      case FlashMode.auto:
        newMode = FlashMode.always;
        break;
      case FlashMode.always:
      default:
        newMode = FlashMode.off;
        break;
    }

    await controller!.setFlashMode(newMode);
    _setState(() {
      currentFlashMode = newMode;
    });
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _MealScanPageState {
  Future<void> initCamera() async {
    controller = CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
    await controller!.initialize();
    currentFlashMode = controller!.value.flashMode;

    if (mounted) _setState(() {});
  }

  IconData getFlashIcon() {
    switch (currentFlashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
      default:
        return Icons.flash_off;
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealScanPageState {
  // Camera Preview
  Widget getCameraPreview() {
    final size = MediaQuery.of(context).size;
    final scale = 1 / (controller!.value.aspectRatio * size.aspectRatio);

    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: Center(child: CameraPreview(controller!)),
    );
  }

  // Top Navigation Bar
  Widget getTopNavigationBar() {
    return Positioned(
      top: 30,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [getBackButton(), getFlashModeButton()],
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

  // Flash Mode Button
  Widget getFlashModeButton() {
    return GestureDetector(
      onTap: cycleFlashMode,
      child: FaIcon(
        getFlashIcon(),
        color: context.theme.colorScheme.onPrimary,
        size: AppStyles.kSize20,
      ),
    );
  }

  // Snap Picture Button
  Widget getSnapPictureButton() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: snapPicture,
          child: Container(width: 70, height: 70, decoration: _Styles.snapPictureButtonDecoration),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Snap Picture Button Container Decoration
  static BoxDecoration get snapPictureButtonDecoration {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(color: Colors.grey, width: 4),
    );
  }
}
