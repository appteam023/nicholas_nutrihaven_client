import '../../Data/DataSources/remote/api_constant.dart';
import '../Data/Model/SignInModel/Signin_model.dart';

const String Local_User_Key = 'user';
const String Local_token_key = 'token';
const String Local_Welcome_Key = 'welcomeKey';
const String Local_FcmToken_Key = 'fcmTokenKey';

/// GetStorage For Save User
Future<bool> saveUser({required User user}) async {
  final storage = ApiConstants.storage;
  storage.write(Local_User_Key, user);
  print("saved user ==> $user");
  return true;
}

/// GetStorage For Read user
// String? getUser() {
//   final storage = ApiConstants.storage;
//   final user = storage.read(Local_User_Key);
//   print("user ==> $user");
//   if (user.runtimeType == String) {
//     return user;
//   } else {
//     return user;
//   }
// }

User? getUser() {
  final storage = ApiConstants.storage;
  final userData = storage.read(Local_User_Key);
  print("user ==> $userData");
  if (userData is Map<String, dynamic>) {
    return User.fromJson(userData);
  }
  return null;
}

/// GetStorage For Save User
Future<bool> saveToken({required String token}) async {
  final storage = ApiConstants.storage;
  storage.write(Local_token_key, token);
  print("saved token ==> $token");
  return true;
}

/// GetStorage For Read user
String? getToken() {
  final storage = ApiConstants.storage;
  final token = storage.read(Local_token_key);
  print("token ==> $token");
  if (token.runtimeType == String) {
    return token;
  } else {
    return token;
  }
}

/// GetStorage Delete All Storage
Future<bool> clearAllStorage() async {
  final storage = ApiConstants.storage;
  storage.erase();
  return true;
}

/// GetStorage For Save remember
Future<bool> setRememberMe({required isRemember}) async {
  final storage = ApiConstants.storage;
  storage.write('remember', isRemember);
  return true;
}

/// GetStorage For Read remember
Future<bool> getRemember() async {
  final storage = ApiConstants.storage;
  bool remember = storage.read('remember') ?? false;
  return remember;
}

/// GetStorage For Remove user
// Future<bool> removeUser() async {
//   final storage = await ApiConstants.storage;
//   ApiConstants.userData = null;
//   storage.remove(Local_User_Key);
//   return true;
// }
/// GetStorage For Remove user
Future<bool> removeToken() async {
  final storage = ApiConstants.storage;
  storage.remove(Local_token_key);
  return true;
}

/// GetStorage For Save Welcome
Future<bool?> saveWelcome({required isWelcome}) async {
  final storage = ApiConstants.storage;
  storage.write(Local_Welcome_Key, isWelcome);
  return true;
}

/// GetStorage For Read Welcome
Future<bool?> getWelcome() async {
  final storage = ApiConstants.storage;
  final welcomeKey = storage.read(Local_Welcome_Key) ?? false;
  return welcomeKey;
}
