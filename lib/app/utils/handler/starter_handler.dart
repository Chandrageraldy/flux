import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHandler().initialize();
  try {
    await dotenv.load(fileName: Env.file);
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await Supabase.initialize(url: dotenv.env[Env.supabaseUrl] ?? '', anonKey: dotenv.env[Env.supabaseAnonKey] ?? '');
}
