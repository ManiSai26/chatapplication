import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions
{
  static String userLoggedInKey = "LoggedINKEY";
  static String userNameKey ="UserNameKey";
  static String userEmailKey ="userEmailKey";
  static Future<bool?> getUserLoggedInStatus() async
  {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}