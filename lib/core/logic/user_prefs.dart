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
}
