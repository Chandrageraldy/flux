import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ModalSheetBarTappablePosition {
  LEADING,
  TRAILING,
}

class ModalSheetBarTappable extends StatelessWidget {
  const ModalSheetBarTappable({
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
  final ModalSheetBarTappablePosition modalSheetBarTappablePosition;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          if (modalSheetBarTappablePosition == ModalSheetBarTappablePosition.TRAILING)
            Text(label, style: _Styles.getLabelTextStyle(context, color)),
          FaIcon(icon, size: AppStyles.kSize16, color: color),
          if (modalSheetBarTappablePosition == ModalSheetBarTappablePosition.LEADING)
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
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: color);
  }
}
