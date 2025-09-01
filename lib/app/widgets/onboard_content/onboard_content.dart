import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({super.key, required this.onboardTitle, required this.onboardImage, required this.onboardDesc});

  final String onboardTitle;
  final String onboardImage;
  final String onboardDesc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: GradientAppColors.tertiaryGradient, borderRadius: AppStyles.kRad16),
      width: AppStyles.kDoubleInfinity,
      padding: AppStyles.kPadd24,
      child: Column(
        spacing: AppStyles.kSpac16,
        children: [
          getFluxLogoImage(),
          Expanded(child: getOnboardImage(context)),
          getTitleLabel(context),
          getDescriptionLabel(context),
        ],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on OnboardContent {
  // Flux Logo Image
  Widget getFluxLogoImage() {
    return Image.asset(
      ImagePath.fluxLogo,
      height: AppStyles.kSize56,
      width: AppStyles.kSize56,
    );
  }

  // Onboard Image
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
  Widget getDescriptionLabel(BuildContext context) {
    return Text(
      onboardDesc,
      style: _Styles.getDescriptionLabelTextStyle(context),
      textAlign: TextAlign.center,
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary);
  }

  // Description Text Style
  static TextStyle getDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
