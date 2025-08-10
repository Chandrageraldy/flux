import 'package:camera/camera.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

enum GeminiRequestType {
  text,
  imageWithText,
}

final jsonSchema = GeminiJsonSchema.mealScan;

final systemInstruction = Content.system(GeminiSystemInstruction.mealScan);

class GeminiBaseService {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    generationConfig: GenerationConfig(responseMimeType: 'application/json', responseSchema: jsonSchema),
    systemInstruction: systemInstruction,
  );

  Future<Response> callGemini({
    required GeminiRequestType requestType,
    required String textPrompt,
    XFile? imageFile,
  }) async {
    try {
      GenerateContentResponse response;

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

      debugPrint(response.text);
    } catch (e) {
      debugPrint(e.toString());
    }

    return Response.complete('');
  }
}
