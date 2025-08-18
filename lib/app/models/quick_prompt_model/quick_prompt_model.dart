class QuickPrompt {
  final String prompt;

  QuickPrompt({required this.prompt});
}

final List<QuickPrompt> quickPrompts = [
  QuickPrompt(prompt: "What's a healthy snack?"),
  QuickPrompt(prompt: 'Give me a high protein breakfast'),
  QuickPrompt(prompt: 'Give me a low-carb dinner'),
];
