import 'package:camera/camera.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

enum GeminiRequestType {
  text,
  imageWithText,
}

final jsonSchema = GeminiJsonSchema.mealScan;

final systemInstruction = Content.system(GeminiSystemInstruction.mealScan);

abstract class GeminiBaseService {
  Future<Response> callGemini({
    required GeminiRequestType requestType,
    required String textPrompt,
    XFile? imageFile,
    Schema? jsonSchema,
    required String systemInstruction,
  }) async {
    try {
      GenerateContentResponse response;

      final model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
        generationConfig: GenerationConfig(responseMimeType: 'application/json', responseSchema: jsonSchema),
        systemInstruction: Content.system(systemInstruction),
      );

      switch (requestType) {
        case GeminiRequestType.text:
          final prompt = [Content.text(textPrompt)];
          response = await model.generateContent(prompt);
          break;
        case GeminiRequestType.imageWithText:
          final prompt = TextPart(textPrompt);
          final image = await imageFile!.readAsBytes();
          final imagePart = InlineDataPart('image/jpeg', image);
          response = await model.generateContent([
            Content.multi([prompt, imagePart])
          ]);
          // final prompt = TextPart(textPrompt);

          // // Load dummy image from assets
          // final image = await rootBundle.load(ImagePath.fluxLogo);
          // final imageBytes = image.buffer.asUint8List();

          // final imagePart = InlineDataPart('image/jpeg', imageBytes);

          // response = await model.generateContent([
          //   Content.multi([prompt, imagePart])
          // ]);
          break;
      }
      // debugPrint(response.text);
      return Response.complete(response.text);
    } catch (e) {
      debugPrint(e.toString());
      return Response.error(e.toString());
    }
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
