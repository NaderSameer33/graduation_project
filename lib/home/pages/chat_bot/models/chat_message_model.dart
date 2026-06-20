import 'package:equatable/equatable.dart';

enum MessageSender { user, bot }

class ChatMessage extends Equatable {
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  factory ChatMessage.user(String text) => ChatMessage(
        text: text,
        sender: MessageSender.user,
        timestamp: DateTime.now(),
      );

  factory ChatMessage.bot(String text) => ChatMessage(
        text: text,
        sender: MessageSender.bot,
        timestamp: DateTime.now(),
      );

  bool get isUser => sender == MessageSender.user;
  bool get isBot => sender == MessageSender.bot;

  Map<String, dynamic> toJson() => {
        'text': text,
        'sender': sender.name,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        text: json['text'] as String,
        sender: MessageSender.values.byName(json['sender'] as String),
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  @override
  List<Object?> get props => [text, sender, timestamp];
}
