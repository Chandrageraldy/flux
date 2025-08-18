class ChatMessageModel {
  final String text;
  final bool isUser;
  bool isTypedComplete;
  final DateTime timestamp;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    this.isTypedComplete = true,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
