import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class MealScanResultPage extends BaseStatefulPage {
  const MealScanResultPage({super.key});

  @override
  State<MealScanResultPage> createState() => _MealScanResultPageState();
}

class _MealScanResultPageState extends BaseStatefulState<MealScanResultPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('MealScanResultPage body'),
    );
  }
}
