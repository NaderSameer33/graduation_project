import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────
//  UserPrefs – SharedPreferences wrapper
//  Persists user profile data locally.
//  Designed to be token-ready for future API integration.
// ─────────────────────────────────────────────

class UserPrefs {
  UserPrefs._();

  // ── Keys ────────────────────────────────────
  static const String _keyName        = 'user_name';
  static const String _keyEmail       = 'user_email';
  static const String _keyAvatarB64   = 'user_avatar_b64';
  static const String _keyToken       = 'user_token';
  static const String _keyUserId      = 'user_id';

  // ── Defaults ────────────────────────────────
  static const String defaultName  = 'محمد الامام';
  static const String defaultEmail = 'habibaemam@gmail.com';

  // ────────────────────────────────────────────
  //  Name
  // ────────────────────────────────────────────
  static Future<void> saveName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, value.trim());
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName) ?? defaultName;
  }

  // ────────────────────────────────────────────
  //  Email
  // ────────────────────────────────────────────
  static Future<void> saveEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, value.trim());
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? defaultEmail;
  }

  // ────────────────────────────────────────────
  //  Avatar image (stored as base64 string)
  // ────────────────────────────────────────────
  static Future<void> saveAvatarBytes(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final b64 = base64Encode(bytes);
    await prefs.setString(_keyAvatarB64, b64);
  }

  static Future<Uint8List?> getAvatarBytes() async {
    final prefs = await SharedPreferences.getInstance();
    final b64 = prefs.getString(_keyAvatarB64);
    if (b64 == null || b64.isEmpty) return null;
    try {
      return base64Decode(b64);
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAvatarB64);
  }

  // ────────────────────────────────────────────
  //  Auth Token (for future API integration)
  // ────────────────────────────────────────────
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getString(_keyToken);
    return t != null && t.isNotEmpty;
  }

  // ────────────────────────────────────────────
  //  User ID (for future API integration)
  // ────────────────────────────────────────────
  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, id);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // ────────────────────────────────────────────
  //  Clear all (logout)
  // ────────────────────────────────────────────
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ────────────────────────────────────────────
  //  Load all profile data at once (convenience)
  // ────────────────────────────────────────────
  static Future<Map<String, dynamic>> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final b64 = prefs.getString(_keyAvatarB64);
    Uint8List? avatarBytes;
    if (b64 != null && b64.isNotEmpty) {
      try {
        avatarBytes = base64Decode(b64);
      } catch (_) {}
    }
    return {
      'name':        prefs.getString(_keyName)  ?? defaultName,
      'email':       prefs.getString(_keyEmail) ?? defaultEmail,
      'avatarBytes': avatarBytes,
    };
  }

  static const String _keyPoints         = 'user_points';
  static const String _keyCompletedTasks = 'user_completed_tasks';
  static const String _keyMoodsMap       = 'user_moods_map';
  static const String _keyChallengeDone  = 'challenge_last_done';

  // Points
  static Future<void> savePoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPoints, points);
  }

  static Future<int> getPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyPoints) ?? 120;
  }

  // Completed Tasks list
  static Future<void> saveCompletedTasks(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyCompletedTasks, list);
  }

  static Future<List<String>> getCompletedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyCompletedTasks) ?? <String>[];
  }

  // Mood Tracker map (date key: yyyy-MM-dd -> JSON string representation of Mood)
  static Future<void> saveMoodForDay(DateTime day, String emoji, String title, String colorHex) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    final moods = await getMoodsMap();
    moods[key] = {
      'emoji': emoji,
      'title': title,
      'color': colorHex,
    };
    await prefs.setString(_keyMoodsMap, jsonEncode(moods));
  }

  static Future<Map<String, Map<String, String>>> getMoodsMap() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyMoodsMap);
    if (data == null || data.isEmpty) return {};
    try {
      final decoded = jsonDecode(data) as Map<String, dynamic>;
      final result = <String, Map<String, String>>{};
      decoded.forEach((key, value) {
        if (value is Map) {
          result[key] = value.map((k, v) => MapEntry(k.toString(), v.toString()));
        }
      });
      return result;
    } catch (_) {
      return {};
    }
  }

  // ────────────────────────────────────────────
  //  Challenge completion tracking
  // ────────────────────────────────────────────

  /// Returns today's key as yyyy-MM-dd
  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Marks today's challenge as completed.
  static Future<void> saveChallengeDoneToday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyChallengeDone, _todayKey());
  }

  /// Returns true if the user already completed the challenge today.
  static Future<bool> isChallengeDoneToday() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_keyChallengeDone);
    return stored == _todayKey();
  }

  /// Clears the daily challenge flag (e.g. for testing / new day).
  static Future<void> clearChallengeDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyChallengeDone);
  }
}
