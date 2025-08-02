import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({this.height, this.width, super.key});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        height: height,
        width: width,
        padding: AppStyles.kPadd8,
        decoration: _Styles.getContainerDecoration(context),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
        color: context.theme.colorScheme.onTertiary.withValues(alpha: 0.04), borderRadius: AppStyles.kRad10);
  }
}
