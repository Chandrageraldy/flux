import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/text_form_field/app_auth_text_form_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class SendResetTokenPage extends BaseStatefulPage {
  const SendResetTokenPage({super.key});

  @override
  State<SendResetTokenPage> createState() => _SendResetTokenPageState();
}

class _SendResetTokenPageState extends BaseStatefulState<SendResetTokenPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  PreferredSizeWidget? appbar() => DefaultAppBar();

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
              getTitleLabel(),
              getSendResetTokenDescriptionLabel(),
              AppStyles.kSizedBoxH4,
              Expanded(child: getFormBuilder()),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SendResetTokenPageState {
  Future<void> _onSendResetTokenPressed() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final email = _formKey.currentState!.fields[FormFields.email.name]!.value as String;
      final response = await tryLoad(context, () => context.read<UserViewModel>().sendResetToken(email: email));

      if (response == true && mounted) {
        context.router.push(VerifyOtpRoute(email: email));
      }
    }
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _SendResetTokenPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SendResetTokenPageState {
  // Title Label
  Widget getTitleLabel() {
    return Text(
      S.current.forgotYourPasswordLabel,
      style: _Styles.getTitleLabelTextStyle(context),
    );
  }

  // Send Reset Token Description Label
  Widget getSendResetTokenDescriptionLabel() {
    return Text(
      S.current.sendResetTokenDesc,
      style: _Styles.getendResetTokenDescriptionLabelTextStyle(context),
    );
  }

  // Form Builder
  Widget getFormBuilder() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        spacing: AppStyles.kSpac16,
        children: [
          getEmailTextField(),
          Spacer(),
          getSendCodeButton(),
          AppStyles.kSizedBoxH6,
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
      icon: Icons.email_outlined,
      height: AppStyles.kSize50,
    );
  }

  // Send Code Button
  Widget getSendCodeButton() {
    return AppDefaultButton(
      label: S.current.sendCodeLabel,
      onPressed: _onSendResetTokenPressed,
      borderRadius: AppStyles.kRad10,
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Title Text Style
  static getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary, height: 1);
  }

  // Send Reset Token Description Text Style
  static getendResetTokenDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
