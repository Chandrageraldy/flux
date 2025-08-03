import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/list_tile/profile_settings_list_tile.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar.dart';
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
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    return Column(
      children: [
        getCustomAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: AppStyles.kPaddSH16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppStyles.kSpac12,
              children: [
                AppStyles.kEmptyWidget,
                getHeaderContainer(),
                getPlanGenerationContainer(),
                getPlanCustomizationColumn(),
                getPersonalInfoColumn(),
                AppStyles.kEmptyWidget,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProfilePageState {
  void _onGeneratePlanPressed() {}
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ProfilePageState {
  void _onLogoutPressed() async {
    final response = await tryLoad(context, () => context.read<UserViewModel>().logout());

    if (response == true && mounted) {
      context.router.replaceAll([RootRoute()]);
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProfilePageState {
  // Top Bar
  Widget getCustomAppBar() {
    return CustomAppBar(
      leadingButton: AppStyles.kEmptyWidget,
      trailingButton: AppStyles.kEmptyWidget,
      title: S.current.profileLabel,
    );
  }

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
            FaIcon(FontAwesomeIcons.bowlFood, size: AppStyles.kSize16),
            S.current.dietLabel,
            userProfile?.bodyMetrics?.dietType?.toString().capitalize() ?? '',
          ),
        ),
        Expanded(
          flex: 2,
          child: getHeaderStatsColumn(
            FaIcon(FontAwesomeIcons.weightScale, size: AppStyles.kSize16),
            S.current.targetWeightLabel,
            '${userProfile?.bodyMetrics?.targetWeight?.toString()} ${Unit.kg.label}',
          ),
        ),
        Expanded(
          child: getHeaderStatsColumn(
            FaIcon(FontAwesomeIcons.bullseye, size: AppStyles.kSize16),
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
        Text(value, style: _Styles.getHeaderColumnValueLabelTextStyle(context)),
        Text(label, style: _Styles.getHeaderColumnLabelTextStyle(context)),
      ],
    );
  }

  // Plan Generation Container
  Widget getPlanGenerationContainer() {
    return Container(
      width: AppStyles.kDoubleInfinity,
      decoration: BoxDecoration(
        gradient: GradientAppColors.secondaryGradient,
        borderRadius: AppStyles.kRad10,
      ),
      padding: AppStyles.kPaddSV12H16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [getPlanGenerationLabel(), getPlanGenerationDesc()],
          ),
          getPlanGenerationButton()
        ],
      ),
    );
  }

  // Plan Generation Label
  Widget getPlanGenerationLabel() {
    return Text(S.current.wantToStartFreshLabel, style: _Styles.getPlanGenerationLabelTextStyle(context));
  }

  // Plan Generation Description
  Widget getPlanGenerationDesc() {
    return Text(S.current.wantToStartFreshDesc, style: _Styles.getPlanGenerationDescTextStyle(context));
  }

  // Plan Generation Button
  Widget getPlanGenerationButton() {
    return GestureDetector(
      onTap: _onGeneratePlanPressed,
      child: Container(
        decoration: _Styles.getPlanGenerationButtonContainerDecoration(context),
        padding: AppStyles.kPaddSV3H12,
        child: Text(S.current.generateLabel, style: _Styles.getPlanGenerationButtonTextStyle(context)),
      ),
    );
  }

  // Personal Info Column
  Widget getPersonalInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac4,
      children: [
        Text(S.current.personalInfoLabel, style: Quicksand.bold.withSize(FontSizes.small)),
        Container(
          padding: AppStyles.kPaddSV12H20,
          decoration: _Styles.getPersonalInfoContainerDecoration(context),
          child: getPersonalInfoListView(),
        ),
      ],
    );
  }

  // Profile Settings List View
  Widget getPersonalInfoListView() {
    final personalInfoSettings = personalInfo(context, _onLogoutPressed);

    return ListView.separated(
      itemCount: personalInfoSettings.length,
      itemBuilder: (context, index) {
        final setting = personalInfoSettings[index];
        return ProfileSettingsListTile(
          leadingIcon: setting.icon,
          label: setting.label,
          desc: setting.desc,
          onTap: setting.onTap,
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: AppStyles.kPaddSV6,
        child: Divider(color: context.theme.colorScheme.tertiaryFixedDim),
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  // Plan Customization Column
  Widget getPlanCustomizationColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppStyles.kSpac4,
      children: [
        Text(S.current.planCustomizationLabel, style: Quicksand.bold.withSize(FontSizes.small)),
        Container(
          padding: AppStyles.kPaddSV12H20,
          decoration: _Styles.getPersonalInfoContainerDecoration(context),
          child: getPlanCustomizationListView(),
        ),
      ],
    );
  }

  // Plan Customization List View
  Widget getPlanCustomizationListView() {
    final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();
    final PlanModel? planModel = SharedPreferenceHandler().getPlan();
    final planCustomizationSettings = planCustomization(
      planModel?.calorieKcal.toString() ?? '',
      userProfile?.bodyMetrics?.dietType?.capitalize() ?? '',
      context,
    );

    return ListView.separated(
      itemCount: planCustomizationSettings.length,
      itemBuilder: (context, index) {
        final setting = planCustomizationSettings[index];
        return ProfileSettingsListTile(
          leadingIcon: setting.icon,
          label: setting.label,
          desc: setting.desc,
          onTap: setting.onTap,
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: AppStyles.kPaddSV6,
        child: Divider(color: context.theme.colorScheme.tertiaryFixedDim),
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
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

  // Personal Info Container Decoration
  static BoxDecoration getPersonalInfoContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Plan Generation Label Text Style
  static TextStyle getPlanGenerationLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Plan Generation Description Text Style
  static TextStyle getPlanGenerationDescTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Plan Generation Button Container Decoration
  static BoxDecoration getPlanGenerationButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.onPrimary, borderRadius: AppStyles.kRad10);
  }

  // Plan Generation Button Text Style
  static TextStyle getPlanGenerationButtonTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }
}
