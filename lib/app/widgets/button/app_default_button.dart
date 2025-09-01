import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppDefaultButton extends StatelessWidget {
  const AppDefaultButton({
    required this.label,
    required this.onPressed,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.labelColor,
    this.labelStyle,
    this.borderRadius,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final BorderRadius? borderRadius;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppStyles.kDoubleInfinity,
      child: getButton(context),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AppDefaultButton {
  // Get Started Button
  Widget getButton(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _Styles.getButtonStyle(context, backgroundColor, borderColor, padding, borderRadius),
      child: Row(
        spacing: AppStyles.kSpac4,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, size: AppStyles.kSize20, color: labelColor ?? context.theme.colorScheme.onPrimary),
          getButtonLabel(context, label),
        ],
      ),
    );
  }

  // Button Label
  Widget getButtonLabel(BuildContext context, String label) {
    return Text(
      label,
      style: labelStyle ?? _Styles.getButtonLabelTextStyle(context, labelColor),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Button Label Style
  static TextStyle getButtonLabelTextStyle(BuildContext context, Color? labelColor) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(
          color: labelColor ?? context.theme.colorScheme.onPrimary,
        );
  }

  // Button Background Color
  static Color getButtonBackgroundColor(BuildContext context, Color? backgroundColor) {
    return backgroundColor ?? context.theme.colorScheme.secondary;
  }

  // Button Style
  static getButtonStyle(BuildContext context, Color? backgroundColor, Color? borderColor, EdgeInsetsGeometry? padding,
      BorderRadius? borderRadius) {
    return ElevatedButton.styleFrom(
      backgroundColor: _Styles.getButtonBackgroundColor(context, backgroundColor),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppStyles.kRad10,
        side: BorderSide(
          color: borderColor ?? AppColors.transparentColor,
        ),
      ),
      padding: padding ?? AppStyles.kPaddSV20,
      elevation: 0,
      splashFactory: NoSplash.splashFactory,
    );
  }
}
