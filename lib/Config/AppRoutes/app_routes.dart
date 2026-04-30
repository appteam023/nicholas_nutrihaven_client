part of 'routes_imports.dart';

class AppRoutes {
  static String selectYourPlan = "/selectYourPlan";
  static String paymentInformation = "/paymentInformation";
  static String drawer = "/drawer";
  static String mealTracker = "/mealTracker";
  static String breakfast = "/breakfast";
  static String workoutPlan = "/workoutPlan";
  static String splash = "/splash";
  static String termsCondition = '/termsCondition';
  static String introScreen = '/introScreen';
  static String introScreen2 = '/introScreen2';
  static String signIn = '/signIn';
  static String genderInfo = '/genderInfo';
  static String ageFinder = '/ageFinder';
  static String weightInfo = '/weightInfo';
  static String heightPicker = '/heightPicker';
  static String goals = '/goals';
  static String physicalActivity = '/physicalActivity';
  static String excersicePlace = '/excersicePlace';

  static String excersiceEquipment = '/excersiceEquipment';
  static String bottomBar = '/bottomBar';
  static String workoutVideos = '/workoutVideos';
  static String videoCategory = '/videoCategory';
  static String signupInfo = '/signupInfo';
  static String chestWorkoutVideos = '/chestWorkoutVideos';
  static String chestAndTriceps = '/chestAndTriceps';
  static String foodLibrary = '/foodLibrary';
  static String dietCuisineSelectionView = '/dietCuisineSelectionView';
  static String dietList = '/dietList';
  static String dietDetail = '/dietDetail';
  static String dietNutrientsDetail = '/dietNutrientsDetail';
  static String addNewMuscle = '/addNewMuscle';
  static String addRepSet = '/addRepSet';
  static String repWeightsSetting = '/repWeightsSettingView';
  static String instructionVideo = '/instructionVideo';
  static String notification = '/notification';
  static String addNewExercise = '/addNewExercise';
  static String addTag = '/addTag';
  static String selectMuscle = "/selectMuscle";
  static String selectExercise = "/selectExercise";
  static String groupDetail = "/workoutGroupDetails";
  static String workoutLogs = "/workoutLogs";

  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: drawer,
      page: () => const DrawerScreen(),
    ),
    GetPage(
      name: selectYourPlan,
      page: () => const SelectYourPlan(),
    ),
    GetPage(
      name: paymentInformation,
      page: () => const PaymentInformation(),
    ),
    GetPage(
      name: mealTracker,
      page: () => MealTracker(),
    ),
    GetPage(
      name: breakfast,
      page: () => const BreakfastMeals(),
    ),
    GetPage(
      name: workoutPlan,
      page: () => const WorkoutPlan(),
    ),
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: termsCondition,
      page: () => const TermsConditionScreen(),
    ),
    GetPage(
      name: introScreen,
      page: () => const IntroScreen(),
    ),
    GetPage(name: introScreen2, page: () => const IntroScreen2()),
    GetPage(
      name: signIn,
      page: () => const Signin(),
    ),
    GetPage(
      name: genderInfo,
      page: () => GenderInfo(),
    ),
    GetPage(
      name: weightInfo,
      page: () => WeightInfo(),
    ),
    GetPage(
      name: heightPicker,
      page: () => HeightPickerScreen(),
    ),
    GetPage(
      name: goals,
      page: () => GoalScreen(),
    ),
    GetPage(
      name: physicalActivity,
      page: () => PhysicalActivity(),
    ),
    GetPage(
      name: bottomBar,
      page: () => CustomBottomNavigationBar(),
    ),
    GetPage(
      name: workoutVideos,
      page: () => WorkOutVideosScreen(),
    ),
    GetPage(
      name: videoCategory,
      page: () => VideoCategoryScreen(),
    ),
    GetPage(
      name: signupInfo,
      page: () => const SignupInformationPageView(),
    ),
    GetPage(
      name: chestWorkoutVideos,
      page: () => ChestWorkoutVideos(),
    ),
    GetPage(
      name: chestAndTriceps,
      page: () => const ChestTriceps(),
    ),
    GetPage(
      name: foodLibrary,
      page: () => const FoodLibrary(),
    ),
    GetPage(
      name: dietCuisineSelectionView,
      page: () => const DietCuisineSelectionView(),
    ),
    GetPage(
      name: dietList,
      page: () => const DietListScreen(),
    ),
    GetPage(
      name: dietDetail,
      page: () => const RecipeDetailedView()
    ),
    GetPage(
      name: dietNutrientsDetail,
      page: () => const NutrientListView()
    ),
    GetPage(
      name: addNewMuscle,
      page: () => const AddNewMuscleScreen(),
    ),
    GetPage(
      name: addRepSet,
      page: () => const AddRepSetsScreen(),
    ),
    GetPage(
      name: repWeightsSetting,
      page: () => const RepWeightsSettingView(),
    ),
    GetPage(
      name: instructionVideo,
      page: () => const InstructionVideoScreen(),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: ageFinder,
      page: () => const AgeSelectorWidget(),
    ),
    GetPage(
      name: weightInfo,
      page: () => WeightInfo(),
    ),
    GetPage(
      name: heightPicker,
      page: () => HeightPickerScreen(),
    ),
    GetPage(
      name: excersicePlace,
      page: () => const ExercisePlace(),
    ),
    GetPage(
      name: excersiceEquipment,
      page: () => ExerciseEquipments(),
    ),
    GetPage(
      name: addNewExercise,
      page: () => AddNewExerciseScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: addTag,
      page: () => TagVideoScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: selectMuscle,
      page: () => const SelectMuscleView(),
    ),
    GetPage(
      name: selectExercise,
      page: () {
        final args = Get.arguments as Map<String,dynamic>?;
        return SelectExerciseView(
          isEditing: args?["isEditing"] ?? false,
        );
      }
    ),
    GetPage(
      name: groupDetail,
      page: () => const GroupDetailsView(),
    ),
    GetPage(
      name: workoutLogs,
      page: () => const WorkoutLogsView(),
    ),
  ];
}
