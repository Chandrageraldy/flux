import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({this.backgroundColor = Colors.transparent, this.actionButton, super.key});

  final Color backgroundColor;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [if (actionButton != null) actionButton!],
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
