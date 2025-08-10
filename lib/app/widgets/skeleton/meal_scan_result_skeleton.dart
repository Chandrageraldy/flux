import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class MealScanResultSkeleton extends StatelessWidget {
  const MealScanResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppStyles.kSpac16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHeader(),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealScanResultSkeleton {
  // Header
  Widget getHeader() {
    return Row(
      spacing: AppStyles.kSpac12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            spacing: AppStyles.kSpac4,
            children: [Skeleton(height: 20), Skeleton(height: 20)],
          ),
        ),
        Expanded(child: Skeleton(height: 20)),
      ],
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {}
