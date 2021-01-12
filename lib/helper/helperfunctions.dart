import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String sharedPreferenceUserLoggedInKey = "LOGGED_IN";
  static String sharePreferenceUserNameKey = "USERNAMEKEY";
  static String sharePreferenceUserEmailKey = "USEREMAILKEY";

  //Saving to Shared Pref

  static Future<void> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameInSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharePreferenceUserNameKey, userName);
  }

  static Future<void> saveUserEmailInSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharePreferenceUserNameKey, userEmail);
  }

  //getting data from pref
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharePreferenceUserNameKey);
  }

  static Future<String> getUserEmailInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharePreferenceUserEmailKey);
  }
}