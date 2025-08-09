import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/utils/extensions/extension.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/personal_details_vm/personal_details_view_model.dart';
import 'package:flux/app/widgets/list_tile/profile_settings_list_tile.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar.dart';
import 'package:flux/app/widgets/modal_sheet_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

@RoutePage()
class PersonalDetailsPage extends StatelessWidget {
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => PersonalDetailsViewModel(), child: _PersonalDetailsPage());
  }
}

class _PersonalDetailsPage extends BaseStatefulPage {
  @override
  State<_PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends BaseStatefulState<_PersonalDetailsPage> {
  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    return Column(
      spacing: AppStyles.kSpac12,
      children: [
        AppStyles.kEmptyWidget,
        getCustomAppBar(),
        getPersonalDetailsContainer(),
        getBMIContainer(),
        getWeightGoalContainer(),
        AppStyles.kEmptyWidget,
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _PersonalDetailsPageState {
  void _onPickerPressed(PersonalDetailsModel setting, bool isTargetWeeklyChangeEnabled) {
    // Retrieve the currently selected value
    final currentSelectedValue = context.read<PersonalDetailsViewModel>().personalDetails[setting.key] ?? '';
    // Get the index of the current selected value in the items list
    final initialItemIndex = setting.items.indexOf(currentSelectedValue);

    if (setting.key == PersonalDetailsSettings.targetWeeklyChange.key && !isTargetWeeklyChangeEnabled) {
      return;
    }

    WidgetUtils.showPickerDialog(
      context: context,
      label: setting.label,
      items: setting.items,
      unit: setting.unit ?? '',
      desc: setting.desc,
      initialItem: initialItemIndex,
      onItemSelected: (int index) {
        var selectedValue = setting.items[index];
        context.read<PersonalDetailsViewModel>().onItemSelected(setting.key, selectedValue);
      },
    );
  }

  void _onDatePickerPressed(PersonalDetailsModel setting) {
    // Retrieve the currently selected value
    final currentSelectedValue = context.read<PersonalDetailsViewModel>().personalDetails[setting.key] ?? '';

    final dateFormat = DateFormat.YEAR_MONTH_DAY;

    DateTime initialDate = currentSelectedValue.toDateTime(dateFormat);

    WidgetUtils.showDatePickerDialog(
      context: context,
      label: setting.label,
      desc: setting.desc,
      initialDate: initialDate,
      onDateSelected: (selectedDate) {
        context
            .read<PersonalDetailsViewModel>()
            .onItemSelected(setting.key, selectedDate.toFormattedString(dateFormat));
      },
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _PersonalDetailsPageState {
  String _calculateBMI() {
    final personalDetailsInfo = context.read<PersonalDetailsViewModel>().personalDetails;

    final heightStr = personalDetailsInfo[PersonalDetailsSettings.height.key];
    final weightStr = personalDetailsInfo[PersonalDetailsSettings.weight.key];

    if (heightStr == null || weightStr == null) return '';

    final heightCm = double.tryParse(heightStr);
    final weightKg = double.tryParse(weightStr);

    final heightM = heightCm! / 100;
    final bmi = weightKg! / (heightM * heightM);

    return bmi.toStringAsFixed(1);
  }

  String _getBMIStatus() {
    final bmi = _calculateBMI();
    final bmiValue = double.tryParse(bmi) ?? 0.0;

    if (bmiValue < 18.5) {
      return S.current.underweightLabel;
    } else if (bmiValue < 24.9) {
      return S.current.normalWeightLabel;
    } else if (bmiValue < 29.9) {
      return S.current.overweightLabel;
    } else {
      return S.current.obesityLabel;
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PersonalDetailsPageState {
  // Custom App Bar
  Widget getCustomAppBar() {
    return CustomAppBar(
      leadingButton: CustomAppBarTappable(
        icon: FontAwesomeIcons.chevronLeft,
        color: context.theme.colorScheme.primary,
        label: S.current.profileLabel,
        modalSheetBarTappablePosition: CustomAppBarTappablePosition.LEADING,
        onTap: () => context.router.maybePop(),
      ),
      trailingButton: AppStyles.kEmptyWidget,
      title: S.current.personalDetailsLabel,
    );
  }

  // Weight Goal Container
  Widget getWeightGoalContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getContainerDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [getWeightGoalLabel(), getWeightGoalDesc(), AppStyles.kSizedBoxH24, getWeightGoalListView()],
        ),
      ),
    );
  }

  // Weight Goal Label
  Widget getWeightGoalLabel() {
    return Text(S.current.weightGoalLabel, style: _Styles.getWeightGoalLabelTextStyle(context));
  }

  // Weight Goal Desc
  Widget getWeightGoalDesc() {
    return Text(S.current.weightGoalDesc, style: _Styles.getWeightGoalDescLabelTextStyle(context));
  }

  // Weight Goal List View
  Widget getWeightGoalListView() {
    final personalDetailsInfo = context.select((PersonalDetailsViewModel vm) => vm.personalDetails);
    final bool isTargetWeeklyChangeEnabled =
        context.select((PersonalDetailsViewModel vm) => vm.isTargetWeeklyChangeEnabled);

    return ListView.separated(
      itemCount: weightGoal.length,
      itemBuilder: (context, index) {
        final setting = weightGoal[index];
        return ProfileSettingsListTile(
          label: setting.label,
          value: personalDetailsInfo[setting.key] ?? '',
          onTap: () => _onPickerPressed(setting, isTargetWeeklyChangeEnabled),
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

  // Personal Details Container
  Widget getPersonalDetailsContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getContainerDecoration(context),
        child: getPersonalDetailsListView(),
      ),
    );
  }

  // Personal Details List View
  Widget getPersonalDetailsListView() {
    final personalDetailsInfo = context.select((PersonalDetailsViewModel vm) => vm.personalDetails);
    final bool isTargetWeeklyChangeEnabled =
        context.select((PersonalDetailsViewModel vm) => vm.isTargetWeeklyChangeEnabled);

    return ListView.separated(
      itemCount: personalDetails.length,
      itemBuilder: (context, index) {
        final setting = personalDetails[index];
        return ProfileSettingsListTile(
          label: setting.label,
          value: personalDetailsInfo[setting.key] ?? '',
          onTap: () => setting.key == PersonalDetailsSettings.dob.key
              ? _onDatePickerPressed(setting)
              : _onPickerPressed(setting, isTargetWeeklyChangeEnabled),
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

  // BMI Container
  Widget getBMIContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getContainerDecoration(context),
        child: ProfileSettingsListTile(
          label: S.current.bmiLabel,
          value: _calculateBMI(),
          trailingIcon: FontAwesomeIcons.circleInfo,
          trailingIconColor: context.theme.colorScheme.secondary,
          desc: _getBMIStatus(),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Weight Goal Label Text Style
  static TextStyle getWeightGoalLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Weight Goal Desc Label Text Style
  static TextStyle getWeightGoalDescLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }
}
