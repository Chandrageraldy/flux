import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppTextSpanButton extends StatelessWidget {
  const AppTextSpanButton({required this.primaryText, required this.secondaryText, required this.onPressed, super.key});

  final String primaryText;
  final String secondaryText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: _Styles.getTextButtonStyle(),
      child: RichText(text: TextSpan(children: getRichTextChildren(context))),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AppTextSpanButton {
  List<TextSpan> getRichTextChildren(BuildContext context) {
    return [
      TextSpan(text: primaryText, style: _Styles.getPrimaryLabelTextStyle(context)),
      TextSpan(text: secondaryText, style: _Styles.getSecondaryLabelTextStyle(context))
    ];
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Primary Label Text Style
  static TextStyle getPrimaryLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.mediumPlus).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Secondary Label Text Style
  static TextStyle getSecondaryLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumPlus).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Text Button Style
  static getTextButtonStyle() {
    return TextButton.styleFrom(
      padding: AppStyles.kPadd0,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashFactory: NoSplash.splashFactory,
    );
  }
}
