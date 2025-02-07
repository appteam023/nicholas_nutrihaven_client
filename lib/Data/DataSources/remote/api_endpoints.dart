class ApiEndPointUrls {
  ApiEndPointUrls._();

  /// AUTH
  static const signUp = "auth/register";
  static const signIn = "auth/login";
  static const forgetPass = "user/forgetpassword";
  static const verifyCode = "user/verifycode";
  static const resetPass = "user/confirmpassword/";
  static const editProfile = "user/updateprofile";

  ///USER
  static const deleteAccount = "user/deleteuser";
  static const viewUserProfile = "user/viewprofile/";

  /// NOTIFICATION
  static const notifications = "notification/getallnotifications";

  static const addPreference = "user/addpreferences";
}
