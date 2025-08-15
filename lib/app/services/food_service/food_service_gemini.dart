import 'package:camera/camera.dart';
import 'package:flux/app/assets/constants/constants.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/services/gemini_base_service.dart';

class FoodServiceGemini extends GeminiBaseService {
  Future<Response> getFoodDetailsFromMealScan({required XFile imageFile}) async {
    return callGemini(
      requestType: GeminiRequestType.imageWithText,
      textPrompt: 'Analyze this food image based on the provided system instruction and json schema',
      imageFile: imageFile,
      jsonSchema: GeminiJsonSchema.mealScan,
      systemInstruction: GeminiSystemInstruction.mealScan,
    );
  }

  Future<Response> enhanceWithAI({required String userInstruction, required String currentResult}) async {
    return callGemini(
      requestType: GeminiRequestType.text,
      textPrompt: currentResult,
      systemInstruction: GeminiSystemInstruction.enhanceWithAI(userInstruction: userInstruction),
    );
  }
}
