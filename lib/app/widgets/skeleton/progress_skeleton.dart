import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class ProgressSkeleton extends StatelessWidget {
  const ProgressSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSV12,
      child: Column(
        spacing: AppStyles.kSpac12,
        children: [
          Skeleton(height: 260, width: AppStyles.kDoubleInfinity),
          Skeleton(height: 245, width: AppStyles.kDoubleInfinity),
        ],
      ),
    );
  }
}
