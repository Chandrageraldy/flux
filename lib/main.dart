import 'package:flutter/material.dart';
import 'package:flux/app/views/app_entry_page/app.dart';
import 'package:flux/app/utils/handler/starter_handler.dart';

void main() async {
  await init();
  runApp(const App());
}
