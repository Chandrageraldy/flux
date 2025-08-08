// import 'package:camera/camera.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:flux/app/assets/exporter/exporter_app_general.dart';
// import 'package:flux/app/models/response_model.dart';

// enum GeminiRequestType {
//   text,
//   imageWithText,
// }

// class GeminiBaseService {
//   final Gemini _gemini = Gemini.instance;

//   Future<Response> callGeminiApi({
//     required GeminiRequestType requestType,
//     required String prompt,
//     XFile? imageFile,
//   }) async {
//     try {
//       final Candidates? response;

//       switch (requestType) {
//         case GeminiRequestType.text:
//           response = await _gemini.prompt(parts: [Part.text(prompt)]);
//           break;
//         case GeminiRequestType.imageWithText:
//           final imageBytes = await imageFile!.readAsBytes();
//           response = await _gemini.prompt(parts: [Part.text(prompt), Part.bytes(imageBytes)]);
//           break;
//       }

//       if (response != null && response.output != null) {
//         print(response.output!);
//         return Response.complete(response.output!);
//       }
//       print('ASU');
//       return Response.error('Gemini API returned no output.');
//     } on GeminiException catch (e) {
//       print(e.message);
//       return Response.error(e);
//     }
//   }
// }
