import 'package:fab_nhl/app/app_constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class to be used for storing/retreiving values from shared preferences or secure storage
/// It will decide if value is to be stored in secure storage or shared preferences.
/// Other classes will only use the store/retreive functions and will be unaware of storage type.
class LocalStorage {
  /// fetch user info from preferences
  static Future<String?> getUserInfo() async {
    // var userInfo = await SharedPreferenceStorage.getString(key_user_info);
    final userInfo = await _SecureStorage.read(key_user_info);
    return userInfo;
  }

  /// store user info (in form of json string)
  static storeUserInfo(String json) async {
    await _SecureStorage.store(key_user_info, json);
    // await SharedPreferenceStorage.storeString(key_user_info, json);
  }

  /// remove user info from local storage
  static removeUserInfo() async {
    // await SharedPreferenceStorage.removeValue(key_user_info);
    await _SecureStorage.removeValue(key_user_info);
  }

  /// store language preference
  static storeLangugePreference(int lang) async {
    await _SharedPreferenceStorage.storeInt(key_language_preference, lang);
  }

  /// get language preference
  static Future<int> getLanguagePreference() async {
    int? lang = await _SharedPreferenceStorage.getInt(key_language_preference);
    return lang ?? 0;
  }
}

/// Static methods for storing and retreiving values from sharedpreferences/userdefaults
class _SharedPreferenceStorage {
  /// Shared Preferences object
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  /// fetch int value from preferences
  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  /// store int value to preferences
  static storeInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  /// fetch double value from preferences
  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble(key);
  }

  /// store double value to preferences
  static storeDouble(String key, double value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  /// fetch string value from preferences
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  /// store string value to preferences
  static storeString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  /// fetch bool value from preferences
  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  /// store double value to preferences
  static storeBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  /// remove a value from preferences
  static Future<bool> removeValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.remove(key);
  }

  /// remove all values from preferences
  static Future<bool> clearPreferences() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }
}

/// Static methods for storing and retreiving values from secure storage
class _SecureStorage {
  /// secure storage object
  static const storage = FlutterSecureStorage();

  /// store value to secure storage
  static store(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  /// read value from secure storage
  static Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  /// remove value from secure storage
  static removeValue(String key) async {
    await storage.delete(key: key);
  }

  /// remove all values from secur storage
  static clear() async {
    await storage.deleteAll();
  }
}
