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
      child: Container(
        color: context.theme.colorScheme.onPrimary,
        child: Row(
          spacing: AppStyles.kSpac16,
          children: [
            icon,
            Text(label, style: _Styles.getLabelTextStyle(context)),
            Spacer(),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: AppStyles.kSize12,
            )
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on LoggingSelectionButton {}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }
}
