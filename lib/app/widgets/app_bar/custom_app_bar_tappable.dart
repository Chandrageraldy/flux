import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CustomAppBarTappablePosition {
  LEADING,
  TRAILING,
}

class CustomAppBarTappable extends StatelessWidget {
  const CustomAppBarTappable({
    required this.icon,
    required this.color,
    required this.label,
    required this.modalSheetBarTappablePosition,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String label;
  final CustomAppBarTappablePosition modalSheetBarTappablePosition;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          if (modalSheetBarTappablePosition == CustomAppBarTappablePosition.TRAILING)
            Text(label, style: _Styles.getLabelTextStyle(context, color)),
          FaIcon(icon, size: AppStyles.kSize16, color: color),
          if (modalSheetBarTappablePosition == CustomAppBarTappablePosition.LEADING)
            Text(label, style: _Styles.getLabelTextStyle(context, color)),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Label Text Style
  static getLabelTextStyle(BuildContext context, Color color) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: color);
  }
}
