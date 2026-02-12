import 'package:flutter/foundation.dart';

import '../../Data/DataSources/remote/api_constant.dart';
import '../Data/Model/SignInModel/Signin_model.dart';

const String localUserKey = 'user';
const String localTokenKey = 'token';
const String localRememberKey = 'remember';
const String localWelcomeKey = 'welcomeKey';
const String localFcmTokenKey = 'fcmTokenKey';

/// GetStorage For Save User
Future<bool> saveUser({required User user}) async {
  final storage = ApiConstants.storage;
  storage.write(localUserKey, user);
  debugPrint("saved user ==> ${user.memberId}");
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
  final userData = storage.read(localUserKey);
  debugPrint("user ==> $userData");
  if (userData is Map<String, dynamic>) {
    return User.fromJson(userData);
  }
  return null;
}

/// GetStorage For Save User
Future<bool> saveToken({required String token}) async {
  final storage = ApiConstants.storage;
  storage.write(localTokenKey, token);
  debugPrint("saved token ==> $token");
  return true;
}

/// GetStorage For Read user
String? getToken() {
  final storage = ApiConstants.storage;
  final token = storage.read(localTokenKey);
  debugPrint("token ==> $token");
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
  storage.write(localRememberKey, isRemember);
  return true;
}

/// GetStorage For Read remember
Future<bool> getRemember() async {
  final storage = ApiConstants.storage;
  bool remember = storage.read(localRememberKey) ?? false;
  return remember;
}

/// GetStorage For Remove user
Future<bool> removeUser() async {
  final storage = ApiConstants.storage;
  await storage.remove(localUserKey);
  await storage.remove(localTokenKey);
  await storage.remove(localRememberKey);
  return true;
}

/// GetStorage For Remove token
Future<bool> removeToken() async {
  final storage = ApiConstants.storage;
  storage.remove(localTokenKey);
  return true;
}

/// GetStorage For Save Welcome
Future<bool?> saveWelcome({required isWelcome}) async {
  final storage = ApiConstants.storage;
  storage.write(localWelcomeKey, isWelcome);
  return true;
}

/// GetStorage For Read Welcome
Future<bool?> getWelcome() async {
  final storage = ApiConstants.storage;
  final welcomeKey = storage.read(localWelcomeKey) ?? false;
  return welcomeKey;
}
