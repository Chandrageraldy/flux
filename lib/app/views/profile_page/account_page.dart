import 'dart:io';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/profile_settings_model/profile_settings_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/account_vm/account_view_model.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/image_profile/image_profile.dart';
import 'package:flux/app/widgets/list_tile/profile_settings_list_tile.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar.dart';
import 'package:flux/app/widgets/app_bar/custom_app_bar_tappable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => AccountViewModel(), child: _AccountPage());
  }
}

class _AccountPage extends BaseStatefulPage {
  @override
  State<_AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends BaseStatefulState<_AccountPage> {
  final _usernameFormKey = GlobalKey<FormBuilderState>();
  final _emailFormKey = GlobalKey<FormBuilderState>();
  final UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

  File? _selectedImage;

  @override
  bool hasDefaultPadding() => false;

  @override
  Widget body() {
    return Column(
      spacing: AppStyles.kSpac12,
      children: [
        getCustomAppBar(),
        AppStyles.kEmptyWidget,
        getHeaderContainer(),
        getAccountContainer(),
        getActionContainer(),
      ],
    );
  }

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _AccountPageState {
  void _onPressed(AccountModel account) {
    final currentValue = context.read<AccountViewModel>().modifiedAccount[account.key] ?? '';

    WidgetUtils.showFieldDialog(
      context: context,
      label: account.label,
      formField: account.formFields,
      onPressed: () {
        final content = account.formKey.currentState?.fields[account.formFields.name]?.value ?? '';
        if (content.isNotEmpty) {
          context.read<AccountViewModel>().onConfirm(account.key, content);
        }
      },
      formKey: account.formKey,
      initialValue: currentValue,
      maxLines: 1,
      textFieldHeight: AppStyles.kSize45,
      textFieldPadding: AppStyles.kPaddSH12,
      desc: account.desc,
    );
  }

  void _onAddProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _onLogoutPressed() async {
    WidgetUtils.showConfirmationDialog(
      context: context,
      label: S.current.leavingSoSoonLabel,
      desc: S.current.leavingSoSoonDesc,
      confirmLabel: S.current.logOutLabel,
      color: AppColors.redColor,
      onConfirm: () async {
        final response = await tryLoad(context, () => context.read<UserViewModel>().logout());

        if (response == true && mounted) {
          context.router.replaceAll([RootRoute()]);
        }
      },
    );
  }

  Future<void> _onSavePressed() async {
    final username = context.read<AccountViewModel>().modifiedAccount[AccountSettings.username.key] ?? '';

    if (username.isEmpty) {
      WidgetUtils.showSnackBar(context, S.current.usernameRequiredError);
      return;
    } else if (username.length < 8) {
      WidgetUtils.showSnackBar(context, S.current.usernameLengthError);
      return;
    }

    WidgetUtils.showConfirmationDialog(
      context: context,
      label: S.current.confirmUpdateLabel,
      desc: S.current.confirmAccountUpdateDesc,
      confirmLabel: S.current.confirmLabel,
      color: context.theme.colorScheme.secondary,
      onConfirm: () async {
        final response =
            await tryLoad(context, () => context.read<AccountViewModel>().updateAccount(selectedImage: _selectedImage));

        if (response == true && mounted) {
          WidgetUtils.showSnackBar(context, S.current.accountDetailsUpdatedLabel);
          context.router.pushAndPopUntil(ProfileRoute(), predicate: (_) => false);
        } else if (mounted) {
          context.router.maybePop();
        }
      },
    );
  }

  Future<void> _onResetPasswordPressed() async {
    final response =
        await tryLoad(context, () => context.read<UserViewModel>().sendResetToken(email: userProfile?.email ?? ''));

    if (response == true && mounted) {
      context.router.push(VerifyOtpRoute(email: userProfile?.email ?? ''));
    }
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _AccountPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _AccountPageState {
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
      trailingButton: GestureDetector(
        onTap: _onSavePressed,
        child: Text(
          S.current.saveLabel,
          style: Quicksand.bold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.secondary),
        ),
      ),
      title: S.current.accountLabel,
    );
  }

  // Header Top Container
  Widget getHeaderContainer() {
    return Padding(padding: AppStyles.kPaddSH16, child: getHeaderColumn());
  }

  // Header Column
  Widget getHeaderColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppStyles.kSpac12,
      children: [
        getUserProfileImage(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userProfile?.username ?? '', style: _Styles.getUsernameLabelTextStyle(context)),
            AppStyles.kSizedBoxH4
          ],
        ),
      ],
    );
  }

  // User Profile Image
  Widget getUserProfileImage() {
    final userProfile = SharedPreferenceHandler().getUser();
    return Stack(
      children: [
        ImageProfile(photoUrl: userProfile?.photoUrl ?? '', selectedImage: _selectedImage),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _onAddProfileImage,
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
          ),
        ),
      ],
    );
  }

  // Account Container
  Widget getAccountContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getAccountContainerDecoration(context),
        child: getAccountListView(),
      ),
    );
  }

  // Action Container
  Widget getActionContainer() {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: Container(
        padding: AppStyles.kPaddSV12H16,
        decoration: _Styles.getAccountContainerDecoration(context),
        child: getActionListView(),
      ),
    );
  }

  // Action List View
  Widget getActionListView() {
    return Column(
      children: [
        ProfileSettingsListTile(
          label: S.current.resetPasswordLabel,
          onTap: _onResetPasswordPressed,
        ),
        Padding(
          padding: AppStyles.kPaddSV6,
          child: Divider(color: context.theme.colorScheme.tertiaryFixedDim),
        ),
        ProfileSettingsListTile(
          label: S.current.logOutLabel,
          onTap: _onLogoutPressed,
          leadingIcon: FontAwesomeIcons.arrowRightFromBracket,
        ),
      ],
    );
  }

  // Account List View
  Widget getAccountListView() {
    final accountInfo = context.select((AccountViewModel vm) => vm.modifiedAccount);

    final accountsSettings = accountSettings(usernameFormKey: _usernameFormKey, emailFormKey: _emailFormKey);

    return ListView.separated(
      itemCount: accountsSettings.length,
      itemBuilder: (context, index) {
        final setting = accountsSettings[index];
        return ProfileSettingsListTile(
          label: setting.label,
          value: accountInfo[setting.key] ?? '',
          onTap: () {
            setting.key == AccountSettings.email.key ? null : _onPressed(setting);
          },
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

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // User Profile Add Button Container Decoration
  static BoxDecoration getUserProfileAddButtonContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      shape: BoxShape.circle,
      border: Border.all(color: context.theme.colorScheme.onPrimary, width: 1),
    );
  }

  // Username Label Text Style
  static TextStyle getUsernameLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Account Container Decoration
  static BoxDecoration getAccountContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }
}
