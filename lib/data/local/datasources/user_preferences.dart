import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../domain/entities/current_user.dart';

class UserPreferences {
  static const String _userKey = 'currentUser';

  static Future<void> saveUser(CurrentUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  static Future<CurrentUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return CurrentUser.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}