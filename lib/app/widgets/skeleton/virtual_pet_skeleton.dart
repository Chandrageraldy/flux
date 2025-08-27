import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class VirtualPetSkeleton extends StatelessWidget {
  const VirtualPetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSV12,
      child: Column(
        spacing: AppStyles.kSpac16,
        children: [
          Row(
            children: [
              Skeleton(width: 45, height: 28),
              Spacer(),
              Skeleton(width: 30, height: 30),
              AppStyles.kSizedBoxW4,
              Skeleton(width: 30, height: 30),
            ],
          ),
          Skeleton(width: AppStyles.kDoubleInfinity, height: 50),
          Skeleton(width: AppStyles.kDoubleInfinity, height: 320),
          Row(
            spacing: AppStyles.kSpac8,
            children: [
              Expanded(child: Skeleton(width: AppStyles.kDoubleInfinity, height: 35)),
              Expanded(child: Skeleton(width: AppStyles.kDoubleInfinity, height: 35)),
              Expanded(child: Skeleton(width: AppStyles.kDoubleInfinity, height: 35)),
            ],
          ),
          Skeleton(width: AppStyles.kDoubleInfinity, height: 160),
        ],
      ),
    );
  }
}
