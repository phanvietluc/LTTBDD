import 'package:shared_preferences/shared_preferences.dart';
class SharedReference{
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userPasswordKey = "USERPASSWORDKEY";
  Future<bool> saveUserId(String getID) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userIdKey, getID);
  }

  Future<bool> saveUserName(String getName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userNameKey, getName);
  }

  Future<bool> saveUserEmail(String getEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userEmailKey, getEmail);
  }

  Future<bool> saveUserPassword(String getPassword) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userPasswordKey, getPassword);
  }

  Future<String?> getUserID() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userIdKey);
  }
  Future<String?> getUserName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }
  Future<String?> getUserEmail() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }
  Future<String?> getUserPassword() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPasswordKey);
  }
}