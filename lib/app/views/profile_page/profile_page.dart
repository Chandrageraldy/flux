import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ProfilePage extends BaseStatefulPage {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseStatefulState<ProfilePage> {
  final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

  @override
  PreferredSizeWidget? appbar() => AppBar(
        title: Text(
          S.current.profileLabel,
          style: Quicksand.bold.withSize(FontSizes.mediumPlus),
        ),
        backgroundColor: context.theme.colorScheme.onPrimary,
        centerTitle: true,
        toolbarHeight: AppStyles.kSize45,
      );

  @override
  bool useGradientBackground() => false;

  @override
  Widget body() {
    return Column(
      children: [AppStyles.kSizedBoxH12, getHeaderContainer()],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProfilePageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProfilePageState {
  // Header Container
  Widget getHeaderContainer() {
    return Container(
      decoration: _Styles.getHeaderContainerDecoration(context),
      padding: AppStyles.kPaddSV10H16,
      child: Column(
        spacing: AppStyles.kSpac12,
        children: [getHeaderRow(), getDivider(context), getHeaderStatsRow()],
      ),
    );
  }

  // Header Row
  Widget getHeaderRow() {
    final dob = userProfile?.bodyMetrics?.dob?.toDateTime(DateFormat.YEAR_MONTH_DAY);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: AppStyles.kSpac20,
      children: [
        getUserProfileImage(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userProfile?.username ?? '', style: _Styles.getUsernameLabelTextStyle(context)),
            Text(
              '${FunctionUtils.calculateAge(dob!)} ${S.current.yearsLabel}',
              style: _Styles.getAgeLabelTextStyle(context),
            ),
            AppStyles.kSizedBoxH4
          ],
        ),
      ],
    );
  }

  // Header Stats Row
  Widget getHeaderStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: getHeaderStatsColumn(
            FaIcon(FontAwesomeIcons.bowlFood, size: AppStyles.kIconSize16),
            S.current.dietLabel,
            userProfile?.bodyMetrics?.dietType?.toString().capitalize() ?? '',
          ),
        ),
        Expanded(
          flex: 2,
          child: getHeaderStatsColumn(
            FaIcon(FontAwesomeIcons.weightScale, size: AppStyles.kIconSize16),
            S.current.targetWeightLabel,
            '${userProfile?.bodyMetrics?.targetWeight?.toString()} ${Unit.kg.label}',
          ),
        ),
        Expanded(
          child: getHeaderStatsColumn(
            FaIcon(FontAwesomeIcons.bullseye, size: AppStyles.kIconSize16),
            S.current.goalLabel,
            '${userProfile?.bodyMetrics?.goal?.toString().capitalize()} ${S.current.weightLabel}',
          ),
        ),
      ],
    );
  }

  // User Profile Image
  Widget getUserProfileImage() {
    return Stack(
      children: [
        Image.asset(ImagePath.profilePlaceholder, width: AppStyles.kSize64, height: AppStyles.kSize64),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: AppStyles.kSize20,
            height: AppStyles.kSize20,
            decoration: _Styles.getUserProfileAddButtonContainerDecoration(context),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: AppStyles.kPadd6,
                child: FaIcon(FontAwesomeIcons.add, color: context.theme.colorScheme.onPrimary),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Divider
  Widget getDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: context.theme.colorScheme.tertiaryFixedDim,
    );
  }

  // Header Row
  Widget getHeaderStatsColumn(FaIcon icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: AppStyles.kPadd12,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onPrimary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: icon,
        ),
        AppStyles.kSizedBoxH8,
        Text(value, style: _Styles.getHeaderColumnValueLabelTextStyle(context)),
        Text(label, style: _Styles.getHeaderColumnLabelTextStyle(context)),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Username Label Text Style
  static TextStyle getUsernameLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium);
  }

  // Age Label Text Style
  static TextStyle getAgeLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.primary);
  }

  // User Profile Add Button Container Decoration
  static BoxDecoration getUserProfileAddButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      shape: BoxShape.circle,
      border: Border.all(color: context.theme.colorScheme.onPrimary, width: 1),
    );
  }

  // Header Row Label Text Style
  static TextStyle getHeaderColumnLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Header Row Value Label Text Style
  static TextStyle getHeaderColumnValueLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary);
  }
}
