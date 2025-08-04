import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar(
      {this.backgroundColor = AppColors.transparentColor,
      this.actionButton,
      this.centerTitle = false,
      this.title,
      super.key});

  final Color backgroundColor;
  final Widget? actionButton;
  final String? title;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      title: Text(title ?? '', style: _Styles.getTitleLabelTextStyle(context)),
      centerTitle: centerTitle,
      actions: [
        if (actionButton != null) Padding(padding: AppStyles.kPaddOR16, child: actionButton!),
      ],
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () async {
          context.router.maybePop();
        },
        child: const Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Title Label Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.mediumHuge).copyWith(color: context.theme.colorScheme.primary);
  }
}
