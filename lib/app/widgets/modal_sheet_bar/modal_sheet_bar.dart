import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class ModalSheetBar extends StatelessWidget {
  const ModalSheetBar({
    required this.leadingButton,
    required this.trailingButton,
    required this.title,
    super.key,
  });

  final Widget leadingButton;
  final Widget trailingButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.kPaddSV15,
      decoration: _Styles.getContainerDecoration(context),
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Row(
          children: [
            Expanded(flex: 1, child: leadingButton),
            Text(title, style: _Styles.getTitleTextStyle()),
            Expanded(
              flex: 1,
              child: Align(alignment: Alignment.centerRight, child: trailingButton),
            )
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
