import 'package:equatable/equatable.dart';
import '../models/chat_message_model.dart';
import '../models/chat_session_model.dart';

abstract class ChatBotState extends Equatable {
  final List<ChatSession> sessions;
  final String? activeSessionId;

  const ChatBotState({
    this.sessions = const [],
    this.activeSessionId,
  });

  ChatSession? get activeSession {
    if (activeSessionId == null || sessions.isEmpty) return null;
    try {
      return sessions.firstWhere((s) => s.id == activeSessionId);
    } catch (_) {
      return null;
    }
  }

  List<ChatMessage> get messages => activeSession?.messages ?? const [];

  @override
  List<Object?> get props => [sessions, activeSessionId];
}

class ChatBotInitial extends ChatBotState {
  const ChatBotInitial({super.sessions, super.activeSessionId});
}

class ChatBotLoading extends ChatBotState {
  const ChatBotLoading(
      {required super.sessions, required super.activeSessionId});
}

class ChatBotLoaded extends ChatBotState {
  const ChatBotLoaded(
      {required super.sessions, required super.activeSessionId});
}

class ChatBotError extends ChatBotState {
  final String error;

  const ChatBotError({
    required super.sessions,
    required super.activeSessionId,
    required this.error,
  });

  @override
  List<Object?> get props => [...super.props, error];
}
