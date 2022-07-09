import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedPreferencesUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferencesUserNameKey = "USERNAMEKEY";
  static String sharedPreferencesUserEmailKey = "USEREMAILKEY";

  //saving data to SharedPreferences

  static Future<bool> saveUserLoggedInSharedPreferences(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // dynamic pref =  await prefs.setBool(sharedPreferencesUserLoggedInKey, isUserLoggedIn);
    return await prefs.setBool(
        sharedPreferencesUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreferences(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreferences(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserEmailKey, userEmail);
  }

  static Future<bool> getUserLoggedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic pref = prefs.getBool(sharedPreferencesUserLoggedInKey);
    return await pref;
  }

  static Future<String> getUserNameSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic pref = prefs.getString(sharedPreferencesUserNameKey);
    return await pref;
  }

  static Future<String> getUserEmailSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic pref = prefs.getString(sharedPreferencesUserEmailKey);
    return await pref;
  }
}
