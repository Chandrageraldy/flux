import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/meal_scan_vm/meal_scan_view_model.dart';

@RoutePage()
class MealScanNavigatorPage extends StatelessWidget {
  const MealScanNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealScanViewModel(),
      child: AutoRouter(),
    );
  }
}
