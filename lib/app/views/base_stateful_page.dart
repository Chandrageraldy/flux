import 'package:flux/app/utils/mixins/error_handling_mixin.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({super.key});
}

abstract class BaseStatefulState<Screen extends BaseStatefulPage> extends State<Screen> with ErrorHandlingMixin {
  PreferredSizeWidget? appbar() => null;

  Widget body();

  Widget? floatingActionButton() => null;

  EdgeInsets defaultPadding() => AppStyles.kPaddSH16;

  Color backgroundColor() => context.theme.colorScheme.surface;

  bool topSafeAreaEnabled() => true;

  bool bottomSafeAreaEnabled() => true;

  bool hasDefaultPadding() => true;

  bool useGradientBackground() => true;

  bool resizeToAvoidBottomInset() => false;

  bool isModal() => false;

  LinearGradient backgroundGradient() => GradientAppColors.primaryGradient;

  /// Each Page are meant to be build with a [Scaffold] structure
  /// include with [AppBar], [Body], [FloatingActionButton]
  @override
  Widget build(BuildContext context) {
    if (isModal()) {
      return SafeArea(
        top: topSafeAreaEnabled(),
        bottom: bottomSafeAreaEnabled(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: hasDefaultPadding() ? defaultPadding() : EdgeInsets.zero,
            child: body(),
          ),
        ),
      );
    }

    final scaffold = Scaffold(
      backgroundColor: useGradientBackground() ? AppColors.transparentColor : backgroundColor(),
      appBar: appbar(),
      body: SafeArea(
        left: false,
        right: false,
        top: topSafeAreaEnabled(),
        bottom: bottomSafeAreaEnabled(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: hasDefaultPadding() ? defaultPadding() : EdgeInsets.all(0),
            child: body(),
          ),
        ),
      ),
      floatingActionButton: floatingActionButton(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
    );

    if (useGradientBackground()) {
      return Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient(),
        ),
        child: scaffold,
      );
    }

    return scaffold;
  }
}
