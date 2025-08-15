import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class EmptyResult extends StatelessWidget {
  const EmptyResult({required this.title, required this.message, this.imagePath, this.icon, super.key});

  final String title;
  final String message;
  final String? imagePath;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppStyles.kPaddSH12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath != null) Image.asset(imagePath ?? '', width: AppStyles.kSize150, height: AppStyles.kSize150),
            if (icon != null) Icon(icon, size: AppStyles.kSize50, color: context.theme.colorScheme.primary),
            if (icon != null) AppStyles.kSizedBoxH24,
            Text(title, style: _Styles.getTitleLabelTextStyle(context), textAlign: TextAlign.center),
            AppStyles.kSizedBoxH8,
            Text(message, style: _Styles.getMessageLabelTextStyle(context), textAlign: TextAlign.center),
            AppStyles.kSizedBoxH60,
          ],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Title Label Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Message Label Text Style
  static TextStyle getMessageLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.tertiaryFixed);
  }
}
