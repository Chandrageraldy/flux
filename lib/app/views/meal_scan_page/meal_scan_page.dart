import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:camera/camera.dart';
import 'package:flux/app/utils/handler/starter_handler.dart';
import 'package:flux/app/utils/utils/painters.dart';
import 'package:flux/app/viewmodels/meal_scan_vm/meal_scan_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class MealScanPage extends StatelessWidget {
  const MealScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => MealScanViewModel(), child: _MealScanPage());
  }
}

class _MealScanPage extends BaseStatefulPage {
  @override
  State<_MealScanPage> createState() => _MealScanPageState();
}

class _MealScanPageState extends BaseStatefulState<_MealScanPage> {
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
      return Container();
    }

    return Stack(
      children: [
        getCameraPreview(),
        getTopNavigationBar(),
        SafeArea(
          child: Column(
            children: [
              AppStyles.kSizedBoxH60,
              getLabelColumn(),
              AppStyles.kSizedBoxH48,
              Expanded(child: getFrameContainer()),
              AppStyles.kSizedBoxH48,
              getSnapPictureButton(),
              AppStyles.kSizedBoxH32,
            ],
          ),
        ),
      ],
    );
  }

  void _setState(VoidCallback fn) {
    if (mounted) setState(fn);
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MealScanPageState {
  Future<void> _cycleFlashMode() async {
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

// * ------------------------ Private Methods ------------------------
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

// * ------------------------ Widget Factories ------------------------
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
      onTap: _cycleFlashMode,
      child: FaIcon(
        getFlashIcon(),
        color: context.theme.colorScheme.onPrimary,
        size: AppStyles.kSize20,
      ),
    );
  }

  // Snap Picture Button
  Widget getSnapPictureButton() {
    return Center(
      child: GestureDetector(
        onTap: snapPicture,
        child: Container(
          width: AppStyles.kSize64,
          height: AppStyles.kSize64,
          decoration: _Styles.getSnapPictureButtonDecoration(),
        ),
      ),
    );
  }

  // Label Column
  Widget getLabelColumn() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppStyles.kSpac8,
          children: [
            Icon(Icons.camera_enhance_rounded, color: context.theme.colorScheme.onPrimary),
            Text(S.current.scanYourMealLabel, style: _Styles.getLabelTextStyle(context)),
          ],
        ),
        Text(S.current.scanYourMealDesc, style: _Styles.getDescriptionTextStyle(context), textAlign: TextAlign.center),
      ],
    );
  }

  // Frame Container with corner-only border
  Widget getFrameContainer() {
    return Padding(
      padding: AppStyles.kPaddSH20,
      child: CustomPaint(
        painter: CornerFramePainter(color: context.theme.colorScheme.onPrimary),
        child: SizedBox(width: double.infinity),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Snap Picture Button Container Decoration
  static BoxDecoration getSnapPictureButtonDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(color: Colors.grey, width: 4),
    );
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Description Label Text Style
  static TextStyle getDescriptionTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }
}
