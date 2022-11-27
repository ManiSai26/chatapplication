import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions
{
  static String userLoggedInKey = "LoggedINKEY";
  static String userNameKey ="UserNameKey";
  static String userEmailKey ="userEmailKey";

  static Future<bool> saveLoggedInStatus(bool isLoggedIn) async
  {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setBool(userLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async
  {
    SharedPreferences sf = await  SharedPreferences.getInstance();
    return sf.setString(userNameKey, userName);
  }

  static Future<String?> getUserNameSF() async
  {
    SharedPreferences sf = await  SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<bool> saveUserEmailSF(String email) async
  {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey, email);
  }


  static Future<bool?> getUserLoggedInStatus() async
  {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}