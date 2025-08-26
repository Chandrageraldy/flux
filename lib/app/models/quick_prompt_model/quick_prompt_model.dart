import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class QuickPrompt {
  final String prompt;
  final IconData? icon;
  final String? label;
  final Color? iconColor;

  QuickPrompt({required this.prompt, this.icon, this.label, this.iconColor});
}

final List<QuickPrompt> quickPromptsForChatbotPage = [
  QuickPrompt(prompt: "What's a healthy snack?"),
  QuickPrompt(prompt: 'Give me a high protein breakfast'),
  QuickPrompt(prompt: 'Give me a low-carb dinner'),
];

final List<QuickPrompt> quickPromptsForProgressPage = [
  QuickPrompt(
    prompt: "What's a recommended food to fill my remaining calories?",
    label: 'Recommendation',
    icon: Icons.lightbulb_outline_rounded,
    iconColor: Colors.amberAccent,
  ),
  QuickPrompt(
    prompt: 'Which food should I eat next to balance my macros?',
    label: 'Macro Guidance',
    icon: Icons.energy_savings_leaf_outlined,
    iconColor: Colors.green,
  ),
  QuickPrompt(
    prompt: 'How’s the overall meal today?',
    label: 'Overall',
    icon: Icons.check_box_outlined,
    iconColor: Colors.teal,
  ),
];
