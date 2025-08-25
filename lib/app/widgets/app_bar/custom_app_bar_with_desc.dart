import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class CustomAppBarWithDesc extends StatelessWidget {
  const CustomAppBarWithDesc({
    super.key,
    required this.leadingButton,
    required this.trailingButton,
    required this.title,
    required this.desc,
    this.image,
    this.imageSize,
  });

  final Widget leadingButton;
  final Widget trailingButton;
  final String title;
  final String desc;
  final String? image;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.kPaddSV8,
      decoration: _Styles.getContainerDecoration(context),
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Row(
          children: [
            Expanded(flex: 1, child: leadingButton),
            Column(
              children: [
                Row(
                  spacing: AppStyles.kSpac4,
                  children: [
                    if (image != null) Image.asset(image!, width: AppStyles.kSize20, height: AppStyles.kSize20),
                    Text(title, style: _Styles.getTitleTextStyle()),
                  ],
                ),
                Text(desc, style: _Styles.getDescTextStyle(context)),
              ],
            ),
            Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: trailingButton))
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Label Text Style
  static getTitleTextStyle() {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Desc Label Text Style
  static getDescTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(
          height: 1,
          color: context.theme.colorScheme.onTertiaryContainer,
        );
  }

  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL10BR10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }
}
