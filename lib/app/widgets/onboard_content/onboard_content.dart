import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({super.key, required this.onboardTitle, required this.onboardImage, required this.onboardDesc});

  final String onboardTitle;
  final String onboardImage;
  final String onboardDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppStyles.kSpac8,
      children: [
        Expanded(child: getOnboardImage(context)),
        AppStyles.kSizedBoxH4,
        getTitleLabel(context),
        getDescriptionLabel()
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on OnboardContent {
  // Flutter Logo Image
  Widget getOnboardImage(BuildContext context) {
    return Image.asset(
      onboardImage,
    );
  }

  // Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(
      onboardTitle,
      style: _Styles.getTitleLabelTextStyle(context),
      textAlign: TextAlign.center,
    );
  }

  // Description Label
  Widget getDescriptionLabel() {
    return Text(
      onboardDesc,
      style: _Styles.getDescriptionLabelTextStyle(),
      textAlign: TextAlign.center,
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Description Text Style
  static TextStyle getDescriptionLabelTextStyle() {
    return Quicksand.regular.withSize(FontSizes.medium);
  }
}
