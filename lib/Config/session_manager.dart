

import '../Data/Model/SignInModel/Signin_model.dart';

class AppSessionManager {
  // Singleton instance
  static final AppSessionManager _instance = AppSessionManager._internal();
  factory AppSessionManager() => _instance;
  AppSessionManager._internal();

  // === Authentication Data ===
  String? _userToken;
  String? _userID;
  String? _authType;

  // === User Data ===
  String? fcmToken;
  String? currentRouteName;
  User? _userData;


  void setUserToken(String? token) {
    if (token != null && token.trim().isNotEmpty) {
      _userToken = token.startsWith('Bearer') ? token : 'Bearer $token';
    }
  }

  String? get userToken {
    if (_userToken != null && _userToken!.trim().isNotEmpty) {
      return _userToken!.startsWith('Bearer') ? _userToken : 'Bearer $_userToken';
    }
    return null;
  }

  void setUserID(String? id) => _userID = id;
  String? get userID => _userID;

  set setUserData(User? user) {
    _userData = user;
  }
  set updateUserData(User? user) {
    _userData = user;
  }
  User? get getUserData => _userData;

  void setAuthType(String? type) => _authType = type;
  String? get authType => _authType;

  void resetAuth() {
    _userToken = null;
    _userID = null;
    _authType = null;
  }

  void resetAll() {
    resetAuth();
    fcmToken = null;
    currentRouteName = null;
    _userData = null;
  }
}
