import 'package:flux/app/models/chat_message_model/chat_message_model.dart';
import 'package:flux/app/repositories/chatbot_repo/chatbot_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ChiaChatbotViewModel extends BaseViewModel {
  ChatbotRepository chatbotRepository = ChatbotRepository();

  final List<ChatMessageModel> messages = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage({required String userMessage}) async {
    messages.add(ChatMessageModel(text: userMessage, isUser: true));
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    final response = await chatbotRepository.sendMessage(userMessage: userMessage);

    checkError(response);

    _isLoading = false;

    messages.add(ChatMessageModel(text: response.data, isUser: false));

    notifyListeners();
  }
}
