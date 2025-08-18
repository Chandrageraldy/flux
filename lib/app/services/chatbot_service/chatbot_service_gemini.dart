import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/services/gemini_base_service.dart';

class ChatbotServiceGemini extends GeminiBaseService {
  Future<Response> sendMessage({required String userMessage}) {
    return callGemini(
      requestType: GeminiRequestType.text,
      textPrompt: userMessage,
      systemInstruction: GeminiSystemInstruction.chatBot,
      isChat: true,
      responseMimeType: GeminiResponseMimeType.text,
    );
  }
}
