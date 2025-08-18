import 'package:camera/camera.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

enum GeminiRequestType {
  text,
  imageWithText,
}

enum GeminiResponseMimeType {
  json('application/json'),
  text('text/plain');

  final String mimeType;

  const GeminiResponseMimeType(this.mimeType);
}

final jsonSchema = GeminiJsonSchema.mealScan;

final systemInstruction = Content.system(GeminiSystemInstruction.mealScan);

abstract class GeminiBaseService {
  // keep chat history in memory
  final List<Content> _chatHistory = [];

  Future<Response> callGemini({
    required GeminiRequestType requestType,
    required String textPrompt,
    XFile? imageFile,
    Schema? jsonSchema,
    required String systemInstruction,
    bool isChat = false, // 👈 flag to know if it's multi-turn
  }) async {
    try {
      GenerateContentResponse response;

      final model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: jsonSchema,
        ),
        systemInstruction: Content.system(systemInstruction),
      );

      List<Content> prompt = [];

      if (isChat) {
        prompt.addAll(_chatHistory);
      }

      switch (requestType) {
        case GeminiRequestType.text:
          final userMessage = Content.text(textPrompt);
          prompt.add(userMessage);
          break;

        case GeminiRequestType.imageWithText:
          final textPart = TextPart(textPrompt);
          final image = await imageFile!.readAsBytes();
          final imagePart = InlineDataPart('image/jpeg', image);
          final userMessage = Content.multi([textPart, imagePart]);
          prompt.add(userMessage);
          break;
      }

      // send to model
      response = await model.generateContent(prompt);

      final reply = response.text ?? '';

      if (isChat) {
        // store both user + model messages in history
        _chatHistory.add(Content.text(textPrompt));
        _chatHistory.add(Content.model([TextPart(reply)]));
      }

      return Response.complete(reply);
    } catch (e) {
      debugPrint(e.toString());
      return Response.error(e.toString());
    }
  }

  // 👇 optional helper to clear conversation
  void resetChat() {
    _chatHistory.clear();
  }
}

enum GeminiMealScanStatus {
  NOFOODDETECTED,
  IMAGETAKENFROMSCREEN,
  INSTRUCTIONSUNCLEAR,
  COMPLETE;

  String get type {
    switch (this) {
      case GeminiMealScanStatus.NOFOODDETECTED:
        return 'No food detected';
      case GeminiMealScanStatus.IMAGETAKENFROMSCREEN:
        return 'Image taken from a screen';
      case GeminiMealScanStatus.INSTRUCTIONSUNCLEAR:
        return 'Instructions unclear';
      case GeminiMealScanStatus.COMPLETE:
        return 'Complete';
    }
  }

  String get label {
    switch (this) {
      case GeminiMealScanStatus.NOFOODDETECTED:
        return S.current.noFoodDetectedLabel;
      case GeminiMealScanStatus.IMAGETAKENFROMSCREEN:
        return S.current.imageTakenFromScreenLabel;
      case GeminiMealScanStatus.INSTRUCTIONSUNCLEAR:
        return S.current.instructionsUnclearLabel;
      case GeminiMealScanStatus.COMPLETE:
        return '';
    }
  }

  String get message {
    switch (this) {
      case GeminiMealScanStatus.NOFOODDETECTED:
        return S.current.noFoodDetectedMessage;
      case GeminiMealScanStatus.IMAGETAKENFROMSCREEN:
        return S.current.imageTakenFromScreenMessage;
      case GeminiMealScanStatus.INSTRUCTIONSUNCLEAR:
        return S.current.instructionsUnclearMessage;
      case GeminiMealScanStatus.COMPLETE:
        return '';
    }
  }
}
