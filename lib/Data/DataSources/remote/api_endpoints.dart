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

  //Workout
  static const groupList = "exercise-groups/list";
  static const groupDetails = "exercise-groups";
  static const groupCreate = "exercise-groups/create";
  static const groupUpdate = "exercise-groups/update";
  static const groupDelete = "exercise-groups/delete";
  static const groupDeleteExercise = "exercise-groups/remove-exercise";
  static const muscleList = "muscle-group";
  static const exerciseListByMuscle = "master-exercise";
  static const workoutLogStart = "exercise-logs/start";
  static const workoutLogEnd = "exercise-logs/end";
  static const workoutLogList = "exercise-logs";

  //Exercise
  static const getExercise = "nutriheaven-exercise";
  static const postExercise = "post-exercise";
  static const postExerciseMuscle = "post-exercise-muscle";

  // Food-Library
  static const foodMenu = "https://api.spoonacular.com/recipes/complexSearch";
  static const foodItemDetails = "https://api.spoonacular.com/recipes/";
}
