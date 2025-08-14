import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class MealDetailsFoodListSkeleton extends StatelessWidget {
  const MealDetailsFoodListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) => Padding(
        padding: index == 0 ? AppStyles.kPadd0 : AppStyles.kPaddOT12,
        child: getSkeletonCard(context),
      ),
    );
  }

  Widget getSkeletonCard(BuildContext context) {
    return Skeleton(
      height: AppStyles.kSize50,
    );
  }
}
