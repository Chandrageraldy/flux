import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class FoodListSkeleton extends StatelessWidget {
  const FoodListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: AppStyles.kPaddOT12,
          child: getSkeletonCard(context),
        ),
        childCount: 7,
      ),
    );
  }

  Widget getSkeletonCard(BuildContext context) {
    return Skeleton(
      height: AppStyles.kSize56,
    );
  }
}
