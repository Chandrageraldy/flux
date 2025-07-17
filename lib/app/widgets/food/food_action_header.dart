import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodActionHeader extends StatelessWidget {
  const FoodActionHeader({required this.title, required this.icon, required this.onPressed, super.key});

  final String title;
  final FaIcon icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: _Styles.getFoodHeaderContainerDecoration(context),
        child: getFoodHeaderContent(context),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on FoodActionHeader {
  // Food Header Content
  Widget getFoodHeaderContent(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSV20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [icon, AppStyles.kSizedBoxH8, Text(title, style: _Styles.getTitleLabelTextStyle(context))],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getFoodHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Title Label Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumPlus);
  }
}
