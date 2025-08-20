import 'package:http/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  static Future<void> storeToken(String token) async {
    await asyncPrefs.setString('token', token);
  }

  static Future<String> getToken() async {
    final String token = await asyncPrefs.getString('token') ?? "";
    return token;
  }
}
