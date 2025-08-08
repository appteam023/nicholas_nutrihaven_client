class ApiEndPointUrls {
  ApiEndPointUrls._();

  /// AUTH
  static const signUp = "register";
  static const signIn = "login";
  static const categories = "category";
  static const videos = "videos";
  static const postTag = "post-tag";
  static const userWorkout = "user-workout";
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

  //Muscle
  static const muscle = "muscle";

  //Exercise
  static const getExercise = "nutriheaven-exercise";
  static const postExercise = "post-exercise";
  static const postExerciseMuscle = "post-exercise-muscle";
}
