import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/button/app_text_span_button.dart';
import 'package:flux/app/widgets/text_form_field/app_auth_text_form_field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class LoginPage extends BaseStatefulPage {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseStatefulState<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appbar() => DefaultAppBar();

  @override
  void initState() => super.initState();

  @override
  void dispose() => super.dispose();

  @override
  Widget body() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppStyles.kSpac16,
            children: [
              AppStyles.kSizedBoxH4,
              getAppTitleLabel(),
              getLoginDescriptionLabel(),
              AppStyles.kSizedBoxH16,
              Expanded(child: getFormBuilder()),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _LoginPageState {
  void _onSignUpPressed() {
    context.router.push(const PlanSelectionRoute());
  }

  void _onLoginPressed() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final email = _formKey.currentState!.fields[FormFields.email.name]!.value as String;
      final password = _formKey.currentState!.fields[FormFields.password.name]!.value as String;

      FocusScope.of(context).unfocus();

      final response = await tryLoad(
            context,
            () =>
                context.read<UserViewModel>().loginWithEmailAndPassword(email: email.trim(), password: password.trim()),
          ) ??
          false;

      if (response && mounted) {
        context.router.replaceAll([DashboardNavigatorRoute()]);
      }
    }
  }

  // void _onTestErrorPressed() async {
  //   await tryLoad(
  //       context, () => context.read<UserViewModel>().getUserProfile(userId: '62c1365a-55e4-413c-8195-1a8fa09cb032'));
  // }

  // void _onRemoveAllSP() async {
  //   await SharedPreferenceHandler().removeAll();
  // }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _LoginPageState {
  // Login Title Label
  Widget getAppTitleLabel() {
    return Text(
      S.current.loginScreenTitle,
      style: _Styles.getAppTitleLabelTextStyle(context),
    );
  }

  // Login Description Label
  Widget getLoginDescriptionLabel() {
    return Text(
      S.current.loginScreenDesc,
      style: _Styles.getLoginDescriptionLabelTextStyle(context),
    );
  }

  // Form Builder
  Widget getFormBuilder() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          getEmailTextField(),
          AppStyles.kSizedBoxH16,
          getPasswordTextField(),
          getForgotPasswordButton(),
          AppStyles.kSizedBoxH20,
          getLoginButton(),
          Spacer(),
          getSignUpCTAButton(),
          AppStyles.kSizedBoxH24,
        ],
      ),
    );
  }

  // Email Text Field
  Widget getEmailTextField() {
    return AppAuthTextFormField(
      field: FormFields.email,
      placeholder: S.current.emailLabel,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
    );
  }

  // Password Text Field
  Widget getPasswordTextField() {
    return AppAuthTextFormField(
      field: FormFields.password,
      placeholder: S.current.passwordLabel,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(8),
      ]),
    );
  }

  // Forgot Password Button
  Widget getForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: _Styles.getForgotPasswordButtonStyle(),
        child: Text(
          S.current.forgotPasswordLabel,
          style: _Styles.getForgotPasswordButtonLabelTextStyle(context),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  // Login Button
  Widget getLoginButton() {
    return AppDefaultButton(label: S.current.loginLabel, onPressed: _onLoginPressed);
  }

  // Sign Up Button
  Widget getSignUpCTAButton() {
    return AppTextSpanButton(
      primaryText: S.current.signUpPrimarySpanText,
      secondaryText: S.current.signUpSecondarySpanText,
      onPressed: _onSignUpPressed,
    );
  }
}

// * ---------------------------- Styles -----------------------------
abstract class _Styles {
  // App Title Label Text Style
  static getAppTitleLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraHuge).copyWith(color: context.theme.colorScheme.primary, height: 1);
  }

  // Login Description Label Text Style
  static getLoginDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.light.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Button Label Text Style
  static getForgotPasswordButtonLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Forgot Password Button Style
  static getForgotPasswordButtonStyle() {
    return TextButton.styleFrom(
      padding: AppStyles.kPadd0,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashFactory: NoSplash.splashFactory,
    );
  }
}
