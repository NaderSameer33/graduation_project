import 'package:dio/dio.dart';
import '../models/chat_message_model.dart';

class ChatBotRepo {
  ChatBotRepo._();

  // REPLACE THIS WITH YOUR GEMINI API KEY
  // You can get it from https://aistudio.google.com/
  static const String _geminiApiKey = '';

  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// Sends the current message and the chat history to the Gemini API.
  /// If the API key is not configured or fails, it throws to trigger local fallback.
  static Future<String> sendMessage({
    required String message,
    required List<ChatMessage> history,
  }) async {
    if (_geminiApiKey.isEmpty) {
      throw 'API key is not configured';
    }

    try {
      final contents = <Map<String, dynamic>>[];

      // Build context from history
      for (final msg in history) {
        if (msg == history.first && msg.isBot) continue;

        contents.add({
          'role': msg.isUser ? 'user' : 'model',
          'parts': [
            {'text': msg.text}
          ]
        });
      }

      // Add the new message
      contents.add({
        'role': 'user',
        'parts': [
          {'text': message}
        ]
      });

      final response = await _dio.post(
        '/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey',
        data: {
          'contents': contents,
          'systemInstruction': {
            'parts': [
              {
                'text': 'أنت مساعد شخصي ودعم نفسي ذكي وودود جداً اسمك "مراد" في تطبيق "إطمئن". '
                    'تحدث باللغة العربية بأسلوب دافئ ومريح وداعم ومبسط. '
                    'ساعد المستخدم في المشاعر السلبية مثل القلق والحزن والتوتر ووجهه بطرق عملية للاسترخاء والتفكير الإيجابي.'
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          if (content != null) {
            final parts = content['parts'] as List?;
            if (parts != null && parts.isNotEmpty) {
              final text = parts[0]['text'] as String?;
              if (text != null && text.isNotEmpty) {
                return text.trim();
              }
            }
          }
        }
      }

      throw 'خطأ في الاستجابة من الذكاء الاصطناعي';
    } catch (e) {
      rethrow;
    }
  }

  static String getGracefulFallback(String userMessage) {
    final lower = userMessage.toLowerCase();
    if (lower.contains('مرحبا') ||
        lower.contains('هلا') ||
        lower.contains('سلام') ||
        lower.contains('مرحب')) {
      return 'أهلاً بك! أنا مراد، مساعدك الشخصي. كيف تشعر اليوم؟ أنا هنا دائماً للاستماع إليك وتقديم الدعم النفسي.';
    } else if (lower.contains('حزين') ||
        lower.contains('اكتئاب') ||
        lower.contains('ضيق') ||
        lower.contains('مكتئب')) {
      return 'يؤسفني جداً أن تشعر بهذا الضيق. تذكر أن مشاعرك صالحة ومن حقك التعبير عنها. هل تود أن تشاركني سبب هذا الشعور أو نتحدث عن شيء يريحك؟';
    } else if (lower.contains('قلق') ||
        lower.contains('توتر') ||
        lower.contains('خوف') ||
        lower.contains('خايف')) {
      return 'خذ نفساً عميقاً... تذكر أنك في مكان آمن الآن. القلق هو مجرد فكرة وليس حقيقة. دعنا نركز على اللحظة الحالية، هل تريد تجربة تمرين بسيط للتنفس؟';
    } else if (lower.contains('طبيب') ||
        lower.contains('دكتور') ||
        lower.contains('علاج')) {
      return 'طلب المساعدة المتخصصة خطوة شجاعة ورائعة. يمكنك دائماً حجز موعد مع أحد الأطباء النفسيين الموثوقين المتاحين لدينا في التطبيق.';
    } else {
      return 'أنا مستمع جيد لك. واصل حديثك وسأفعل كل ما بوسعي لمساعدتك وإرشادك.';
    }
  }
}
