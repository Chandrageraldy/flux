import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class FoodDetailsSkeleton extends StatelessWidget {
  const FoodDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                getHeaderSkeleton(context),
                Padding(
                  padding: AppStyles.kPaddSV12H20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: AppStyles.kSpac16,
                    children: [
                      getCalorieSkeleton(context),
                      getMacronutrientRowSkeleton(context),
                      getNutritionalInfoSkeleton(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
          getLogButtonSkeleton(context),
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on FoodDetailsSkeleton {
  Widget getHeaderSkeleton(BuildContext context) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      padding: AppStyles.kPaddSV12H20,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          AppStyles.kSizedBoxH12,
          Skeleton(height: AppStyles.kSize20),
          Skeleton(height: AppStyles.kSize20),
          Skeleton(height: AppStyles.kSize20),
          AppStyles.kSizedBoxH12,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppStyles.kSpac8,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.8, // Half width
                      child: Skeleton(height: AppStyles.kSize20),
                    ),
                    Skeleton(height: AppStyles.kSize45, width: AppStyles.kDoubleInfinity),
                  ],
                ),
              ),
              AppStyles.kSizedBoxW12,
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppStyles.kSpac8,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.5, // Half width
                      child: Skeleton(height: AppStyles.kSize20),
                    ),
                    Skeleton(height: AppStyles.kSize45, width: AppStyles.kDoubleInfinity),
                  ],
                ),
              ),
            ],
          ),
          AppStyles.kSizedBoxH6,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppStyles.kSpac8,
            children: [
              FractionallySizedBox(
                widthFactor: 0.3, // Half width
                child: Skeleton(height: AppStyles.kSize20),
              ),
              Skeleton(height: AppStyles.kSize45, width: AppStyles.kDoubleInfinity),
            ],
          ),
          AppStyles.kSizedBoxH8,
        ],
      ),
    );
  }

  Widget getCalorieSkeleton(BuildContext context) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getCalorieContainerDecoration(context),
      padding: AppStyles.kPaddSV20H16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          Skeleton(height: AppStyles.kSize32, width: AppStyles.kSize100),
          Skeleton(height: _Styles.linearIndicatorLineHeight, width: AppStyles.kDoubleInfinity),
        ],
      ),
    );
  }

  Widget getMacronutrientRowSkeleton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppStyles.kSpac12,
      children: List.generate(
          3, (_) => Expanded(child: Skeleton(height: AppStyles.kSize90, width: AppStyles.kDoubleInfinity))),
    );
  }

  Widget getNutritionalInfoSkeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac8,
      children: [
        FractionallySizedBox(
          widthFactor: 0.3, // Half width
          child: Skeleton(height: AppStyles.kSize20),
        ),
        Skeleton(
          width: AppStyles.kDoubleInfinity,
          height: AppStyles.kSize64,
        )
      ],
    );
  }

  Widget getLogButtonSkeleton(BuildContext context) {
    return Positioned(
      bottom: _Styles.getButtonBottomPositition,
      left: _Styles.getButtonHorizontalPosition,
      right: _Styles.getButtonHorizontalPosition,
      child: Skeleton(height: AppStyles.kSize70, width: AppStyles.kDoubleInfinity),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL20BR20,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Button Positioning
  static double getButtonBottomPositition = 10.0;

  // Button Positioning
  static double getButtonHorizontalPosition = 20.0;

  // Linear Indicator Line Height
  static double linearIndicatorLineHeight = 12.0;

  // Calorie Container Decoration
  static BoxDecoration getCalorieContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }
}
