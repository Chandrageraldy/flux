import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/meal_scan_vm/meal_scan_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';

@RoutePage()
class MealScanResultPage extends StatelessWidget {
  const MealScanResultPage({required this.imageFile, super.key});

  final XFile imageFile;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => MealScanViewModel(), child: _MealScanResultPage(imageFile: imageFile));
  }
}

class _MealScanResultPage extends BaseStatefulPage {
  final XFile imageFile;

  const _MealScanResultPage({required this.imageFile});

  @override
  State<_MealScanResultPage> createState() => _MealScanResultPageState();
}

class _MealScanResultPageState extends BaseStatefulState<_MealScanResultPage> {
  @override
  bool hasDefaultPadding() => false;

  @override
  PreferredSizeWidget? appbar() => DefaultAppBar();

  @override
  Widget body() {
    return Center(
      child: Image.file(File(widget.imageFile.path), height: AppStyles.kSize100),
    );
  }
}
