import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/skeleton/skeleton.dart';

class FoodDetailsSkeleton extends StatelessWidget {
  const FoodDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildHeaderSkeleton(context),
            Padding(
              padding: AppStyles.kPaddSV12H20,
              child: Column(
                spacing: AppStyles.kSpac16,
                children: [
                  _buildCalorieSkeleton(context),
                  _buildMacronutrientRowSkeleton(context),
                ],
              ),
            ),
          ],
        ),
        _buildLogButtonSkeleton(context),
      ],
    );
  }

  Widget _buildHeaderSkeleton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppStyles.kPaddSV12H20,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          AppStyles.kSizedBoxH12,
          Skeleton(height: 50, width: double.infinity), // food name
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
                      child: Skeleton(height: 20),
                    ),
                    Skeleton(height: 45, width: double.infinity), // Full width
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
                      child: Skeleton(height: 20),
                    ),
                    Skeleton(height: 45, width: double.infinity), // Full width
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
                child: Skeleton(height: 20),
              ),
              Skeleton(height: 45, width: double.infinity), // Full width
            ],
          ),
          AppStyles.kSizedBoxH8,
        ],
      ),
    );
  }

  Widget _buildCalorieSkeleton(BuildContext context) {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: _Styles.getCalorieContainerDecoration(context),
      padding: AppStyles.kPaddSV20H16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppStyles.kSpac12,
        children: [
          Skeleton(height: 32, width: 100), // calorie text
          Skeleton(height: _Styles.linearIndicatorLineHeight, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildMacronutrientRowSkeleton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: AppStyles.kSpac12,
      children: List.generate(3, (_) => Expanded(child: Skeleton(height: 90, width: double.infinity))),
    );
  }

  Widget _buildLogButtonSkeleton(BuildContext context) {
    return Positioned(
      bottom: _Styles.getButtonBottomPositition,
      left: _Styles.getButtonHorizontalPosition,
      right: _Styles.getButtonHorizontalPosition,
      child: Skeleton(height: 70, width: double.infinity),
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

  // Nutritional Info Container Decoration
  static BoxDecoration getNutritionalInfoContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

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
