import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_message_model.dart';
import '../models/chat_session_model.dart';
import 'chat_bot_repo.dart';
import 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(const ChatBotInitial()) {
    _loadSessions();
  }

  static const String _storageKey = 'etmaen_chatbot_sessions';

  // ── Load Sessions from Storage ──────────────────────────────────────────
  Future<void> _loadSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_storageKey);

      if (jsonStr != null && jsonStr.isNotEmpty) {
        final decoded = jsonDecode(jsonStr) as List;
        final sessions = decoded
            .map((s) => ChatSession.fromJson(s as Map<String, dynamic>))
            .toList();

        if (sessions.isNotEmpty) {
          // Sort by creation date descending to keep newest at top in drawer
          sessions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          emit(ChatBotInitial(
            sessions: sessions,
            activeSessionId: sessions.first.id,
          ));
          return;
        }
      }
    } catch (_) {
      // Fallback on decode/load errors
    }

    // Default: start fresh
    _createNewDefaultSession();
  }

  // ── Save Sessions to Storage ────────────────────────────────────────────
  Future<void> _saveSessions(List<ChatSession> sessions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = sessions.map((s) => s.toJson()).toList();
      await prefs.setString(_storageKey, jsonEncode(encoded));
    } catch (_) {}
  }

  // ── Create New Default Session ──────────────────────────────────────────
  void _createNewDefaultSession() {
    final welcome = ChatMessage.bot(
      'مرحباً! أنا مراد، مساعدك الشخصي. كيف يمكنني مساعدتك اليوم؟ 😊',
    );
    final newSession = ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'دردشة جديدة',
      messages: [welcome],
      createdAt: DateTime.now(),
    );

    final updatedSessions = [newSession, ...state.sessions];
    emit(ChatBotInitial(
      sessions: updatedSessions,
      activeSessionId: newSession.id,
    ));
    _saveSessions(updatedSessions);
  }

  // ── Switch Active Session ───────────────────────────────────────────────
  void selectSession(String sessionId) {
    if (state.activeSessionId == sessionId) return;
    emit(ChatBotInitial(
      sessions: state.sessions,
      activeSessionId: sessionId,
    ));
  }

  // ── Clear / Start New Chat ──────────────────────────────────────────────
  void startNewChat() {
    _createNewDefaultSession();
  }

  // ── Delete a Session ────────────────────────────────────────────────────
  Future<void> deleteSession(String sessionId) async {
    final updatedSessions =
        state.sessions.where((s) => s.id != sessionId).toList();

    String? newActiveId = state.activeSessionId;
    if (state.activeSessionId == sessionId) {
      newActiveId = updatedSessions.isNotEmpty ? updatedSessions.first.id : null;
    }

    emit(ChatBotInitial(
      sessions: updatedSessions,
      activeSessionId: newActiveId,
    ));

    await _saveSessions(updatedSessions);

    if (updatedSessions.isEmpty) {
      _createNewDefaultSession();
    }
  }

  // ── Send Message & Call Gemini API ──────────────────────────────────────
  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final activeId = state.activeSessionId;
    if (activeId == null) return;

    final sessionIndex = state.sessions.indexWhere((s) => s.id == activeId);
    if (sessionIndex == -1) return;

    final activeSession = state.sessions[sessionIndex];

    // 1. Add user message to session
    final userMsg = ChatMessage.user(trimmed);
    final currentMsgs = List<ChatMessage>.from(activeSession.messages)
      ..add(userMsg);

    // If this is the first user message, update title based on user message
    final firstUserMsg = activeSession.messages.where((m) => m.isUser).isEmpty;
    final newTitle = firstUserMsg
        ? (trimmed.length > 25 ? '${trimmed.substring(0, 22)}...' : trimmed)
        : activeSession.title;

    final updatedSession = activeSession.copyWith(
      messages: currentMsgs,
      title: newTitle,
    );

    final updatedSessions = List<ChatSession>.from(state.sessions)
      ..[sessionIndex] = updatedSession;

    emit(ChatBotLoading(
      sessions: updatedSessions,
      activeSessionId: activeId,
    ));

    // 2. Call API with history context
    try {
      final reply = await ChatBotRepo.sendMessage(
        message: trimmed,
        history: activeSession.messages, // Context history
      );

      final botMsg = ChatMessage.bot(reply);
      final finalMsgs = List<ChatMessage>.from(currentMsgs)..add(botMsg);

      final finalSession = updatedSession.copyWith(messages: finalMsgs);
      final finalSessions = List<ChatSession>.from(state.sessions)
        ..[sessionIndex] = finalSession;

      emit(ChatBotLoaded(
        sessions: finalSessions,
        activeSessionId: activeId,
      ));
      _saveSessions(finalSessions);
    } catch (e) {
      // Add fallback bubble
      final fallbackReply = ChatBotRepo.getGracefulFallback(trimmed);
      final botMsg = ChatMessage.bot(fallbackReply);
      final finalMsgs = List<ChatMessage>.from(currentMsgs)..add(botMsg);

      final finalSession = updatedSession.copyWith(messages: finalMsgs);
      final finalSessions = List<ChatSession>.from(state.sessions)
        ..[sessionIndex] = finalSession;

      emit(ChatBotError(
        sessions: finalSessions,
        activeSessionId: activeId,
        error: e.toString(),
      ));
      _saveSessions(finalSessions);
    }
  }
}
