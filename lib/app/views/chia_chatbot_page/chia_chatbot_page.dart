import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/chat_message_model/chat_message_model.dart';
import 'package:flux/app/models/quick_prompt_model/quick_prompt_model.dart';
import 'package:flux/app/viewmodels/chia_chatbot_vm/chia_chatbot_view_model.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:typewritertext/typewritertext.dart';

@RoutePage()
class ChiaChatbotPage extends BaseStatefulPage {
  const ChiaChatbotPage({super.key, required this.initialPrompt});

  final String initialPrompt;

  @override
  State<ChiaChatbotPage> createState() => _ChiaChatbotPageState();
}

class _ChiaChatbotPageState extends BaseStatefulState<ChiaChatbotPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ScrollController _scrollController = ScrollController();

  bool _isSendMessageEnabled = false;
  bool _isTypingEnabled = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool hasDefaultPadding() => false;

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  void initState() {
    super.initState();
    _isSendMessageEnabled = true;
  }

  @override
  Widget body() {
    return Column(
      children: [
        getTopBar(),
        Expanded(
          child: getChatMessagesListView(),
        ),
        getPromptContainer(),
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
extension _Actions on _ChiaChatbotPageState {
  Future<void> _onSendMessage() async {
    final userMessage = _formKey.currentState!.fields[FormFields.prompt.name]!.value as String;

    _formKey.currentState!.fields[FormFields.prompt.name]!.didChange('');
    FocusScope.of(context).unfocus();

    _setState(() {
      _isSendMessageEnabled = false;
      _isTypingEnabled = false;
    });

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.ease,
      );
    }

    await tryCatch(context, () => context.read<ChiaChatbotViewModel>().sendMessage(userMessage: userMessage));
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ChiaChatbotPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChiaChatbotPageState {
// Top Bar
  Widget getTopBar() {
    return Container(
      padding: AppStyles.kPaddSV12,
      decoration: _Styles.getTopBarContainerDecoration(context),
      child: Padding(
        padding: AppStyles.kPaddSH16,
        child: Row(
          spacing: AppStyles.kSpac12,
          children: [getBackButtonContainer(), getTopBarLabelColumn()],
        ),
      ),
    );
  }

  // Back Button Container
  Widget getBackButtonContainer() {
    return GestureDetector(
      onTap: () => context.router.maybePop(),
      child: Container(
        decoration: _Styles.getBackButtonDecoration(context),
        padding: AppStyles.kPadd10,
        child: FaIcon(FontAwesomeIcons.chevronLeft, size: AppStyles.kSize12),
      ),
    );
  }

  // Top Bar Label Column
  Widget getTopBarLabelColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppStyles.kSpac4,
          children: [Text(S.current.chiaLabel, style: _Styles.getTitleTextStyle()), getGeminiTagContainer()],
        ),
        Text(S.current.nutritionSpecialistLabel, style: _Styles.getNutritionSpecialistTextStyle(context)),
      ],
    );
  }

  // Gemini Tag Container
  Widget getGeminiTagContainer() {
    return Container(
      padding: AppStyles.kPaddSV3H6,
      decoration: _Styles.getGeminiTagContainerDecoration(context),
      child: Text(S.current.gemini25Label, style: _Styles.getGeminiTagTextStyle(context)),
    );
  }

  // Chat Messages List View
  Widget getChatMessagesListView() {
    final chatMessages = context.select((ChiaChatbotViewModel vm) => vm.chatMessages);
    final isLoading = context.select((ChiaChatbotViewModel vm) => vm.isLoading);

    return ListView.builder(
      controller: _scrollController,
      itemCount: chatMessages.length + (isLoading ? 1 : 0),
      padding: AppStyles.kPaddSV12H16.copyWith(
        bottom: AppStyles.kPaddSV12H16.bottom + 20,
      ),
      itemBuilder: (context, index) {
        if (index == chatMessages.length && isLoading) {
          return Lottie.asset(AnimationPath.loadingAnimation, width: AppStyles.kSize70, height: AppStyles.kSize70);
        }

        final chatMessage = chatMessages[index];
        return Padding(
          padding: AppStyles.kPaddSV6,
          child: getMessageBubbleContainer(chatMessage, index),
        );
      },
    );
  }

  // Message Bubble Container
  Widget getMessageBubbleContainer(ChatMessageModel chatMessage, int index) {
    return Align(
      alignment: chatMessage.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: chatMessage.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        spacing: AppStyles.kSpac8,
        children: [
          Container(
            decoration: _Styles.getMessageBubbleContainerDecoration(context, chatMessage),
            padding: AppStyles.kPadd12,
            child: chatMessage.isUser
                ? Text(
                    chatMessage.text,
                    style: _Styles.getMessageLabelTextStyle(context, chatMessage),
                  )
                : chatMessage.isTypedComplete
                    ? Text(
                        chatMessage.text,
                        style: _Styles.getMessageLabelTextStyle(context, chatMessage),
                      )
                    : TypeWriter.text(
                        chatMessage.text,
                        duration: const Duration(microseconds: 500),
                        style: _Styles.getMessageLabelTextStyle(context, chatMessage),
                        maintainSize: false,
                        onFinished: (value) {
                          context
                              .read<ChiaChatbotViewModel>()
                              .changeIsTypedComplete(index: index, isTypedComplete: true);
                          _setState(() {
                            _isTypingEnabled = true;
                            _isSendMessageEnabled = false;
                          });
                        },
                      ),
          ),
          getTimeLabel(chatMessage),
        ],
      ),
    );
  }

  // Get Date Label
  Widget getTimeLabel(ChatMessageModel chatMessage) {
    return Text(DateFormat('hh:mm a').format(chatMessage.timestamp), style: _Styles.getTimeLabelTextStyle(context));
  }

  // Prompt Container
  Widget getPromptContainer() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          getQuickPromptScrollableRow(),
          Container(
            padding: AppStyles.kPaddSV12H12,
            decoration: _Styles.getPromptContainerDecoration(context),
            child: SafeArea(
              top: false,
              child: Row(
                spacing: AppStyles.kSpac8,
                children: [getPromptField(), getSendMessageButton()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Quick Prompt Scrollable Row
  Widget getQuickPromptScrollableRow() {
    return Padding(
      padding: AppStyles.kPaddSV12H12,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: quickPromptsForChatbotPage
              .map(
                (quickPrompt) => Padding(
                  padding: EdgeInsets.only(right: AppStyles.kSpac8),
                  child: getQuickPromptContainer(quickPrompt.prompt),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // Quick Prompt Container
  Widget getQuickPromptContainer(String label) {
    return GestureDetector(
      onTap: () {
        _formKey.currentState?.fields[FormFields.prompt.name]?.didChange(label);
      },
      child: Container(
        padding: AppStyles.kPaddSV6H12,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary.withAlpha(80),
          borderRadius: AppStyles.kRad100,
        ),
        child: Text(
          label,
          style: Quicksand.semiBold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary),
        ),
      ),
    );
  }

  // Prompt Field
  Widget getPromptField() {
    return Expanded(
      child: AppTextFormField(
        field: FormFields.prompt,
        validator: null,
        initialValue: widget.initialPrompt,
        placeholder: S.current.typeToStartChattingLabel,
        icon: FaIcon(FontAwesomeIcons.paperPlane, size: AppStyles.kSize16),
        height: AppStyles.kSize40,
        isEnabled: _isTypingEnabled,
        onChanged: (value) {
          _setState(() {
            _isSendMessageEnabled = value?.isNotEmpty ?? false;
          });
        },
      ),
    );
  }

  // Send Message Button
  Widget getSendMessageButton() {
    return GestureDetector(
      onTap: _isSendMessageEnabled ? _onSendMessage : null,
      child: CircleAvatar(
        backgroundColor: _isSendMessageEnabled
            ? context.theme.colorScheme.primary
            : context.theme.colorScheme.primary.withOpacity(0.5),
        child: Icon(Icons.send, color: context.theme.colorScheme.onPrimary, size: AppStyles.kSize16),
      ),
    );
  }
}

// * ----------------------------- Styles ----------------------------
class _Styles {
  // Back Button Container Decoration
  static BoxDecoration getBackButtonDecoration(BuildContext context) {
    return BoxDecoration(border: Border.all(color: context.theme.colorScheme.tertiary), shape: BoxShape.circle);
  }

  // Gemini Tag Text Style
  static TextStyle getGeminiTagTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary, height: 1);
  }

  // Nutrition Specialist Text Style
  static TextStyle getNutritionSpecialistTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.onTertiary);
  }

  // Title Label Text Style
  static TextStyle getTitleTextStyle() {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Top Bar Container Decoration
  static BoxDecoration getTopBarContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL10BR10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Gemini Tag Container Decoration
  static BoxDecoration getGeminiTagContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.secondary.withAlpha(80), borderRadius: AppStyles.kRad100);
  }

  // Prompt Container Decoration
  static BoxDecoration getPromptContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOTL10TR10,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, -2)),
      ],
    );
  }

  // Message Label Text Style
  static TextStyle getMessageLabelTextStyle(BuildContext context, ChatMessageModel chatMessage) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(
          color: chatMessage.isUser ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onTertiary,
          fontStyle: chatMessage.isUser ? FontStyle.italic : FontStyle.normal,
        );
  }

  // Message Bubble Container Decoration
  static BoxDecoration getMessageBubbleContainerDecoration(BuildContext context, ChatMessageModel chatMessage) {
    return BoxDecoration(
      color: chatMessage.isUser ? context.theme.colorScheme.secondary : context.theme.colorScheme.onPrimary,
      borderRadius: chatMessage.isUser ? AppStyles.kRadOBL10BR10TL10TR0 : AppStyles.kRadOBL10BR10TL0TR10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // Time Label Text Style
  static TextStyle getTimeLabelTextStyle(BuildContext context) {
    return Quicksand.medium
        .withSize(FontSizes.extraSmall)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
