import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class PersonalDetailsPage extends BaseStatefulPage {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends BaseStatefulState<PersonalDetailsPage> {
  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  Widget body() {
    return Column(
      children: [
        getCustomAppBar(),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PersonalDetailsPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PersonalDetailsPageState {
  // Top Bar
  Widget getCustomAppBar() {
    return CustomAppBar(
      leadingButton: CustomAppBarTappable(
        icon: FontAwesomeIcons.chevronLeft,
        color: context.theme.colorScheme.secondary,
        label: 'Profile',
        modalSheetBarTappablePosition: CustomAppBarTappablePosition.LEADING,
        onTap: () => context.router.maybePop(),
      ),
      trailingButton: AppStyles.kEmptyWidget,
      title: 'Personal Details',
    );
  }
}

// * ----------------------------- Styles ----------------------------
// abstract class _Styles {}
