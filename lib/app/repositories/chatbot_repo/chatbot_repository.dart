import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/services/chatbot_service/chatbot_service_gemini.dart';

class ChatbotRepository {
  ChatbotServiceGemini chatbotServiceGemini = ChatbotServiceGemini();

  Future<Response> sendMessage({required String userMessage}) {
    final response = chatbotServiceGemini.sendMessage(userMessage: userMessage);
    return response;
  }
}
