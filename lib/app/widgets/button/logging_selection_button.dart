import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoggingSelectionButton extends StatelessWidget {
  const LoggingSelectionButton({required this.icon, required this.label, required this.onPressed, super.key});

  final FaIcon icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        spacing: AppStyles.kSpac4,
        children: [
          Container(
            decoration: _Styles.getContainerDecoration(context),
            height: AppStyles.kSize40,
            width: AppStyles.kSize40,
            child: Center(child: icon),
          ),
          Text(label, style: _Styles.getLabelTextStyle(context))
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on LoggingSelectionButton {}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.medium.withSize(FontSizes.medium);
  }
}
