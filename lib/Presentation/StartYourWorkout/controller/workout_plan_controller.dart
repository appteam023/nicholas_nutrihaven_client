
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Data/Model/ExcerciseModel/get_exercise_model.dart';
import '../../../Data/Model/ExerciseGroup/group_details_model.dart';
import '../../../Data/Model/WorkOutLogs/workout_logs_model.dart';
import '../../../Data/Model/WorkoutPlan/custom_workout_plan_model.dart';
import '../../../Data/Model/muscleModel/get_muscle_model.dart';
import '../../../Data/Repository/workout_repository.dart';
import '../../../Data/Model/ExerciseGroup/saved_workout_model.dart';
import '../../../Helpers/get_storare_helper.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_TextField.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_dialog.dart';
import '../../../Widgets/custom_snackbar.dart';
import '../../../Widgets/loader_widget.dart';
import '../WorkoutPlanScreen/start_workout_view.dart';

class WorkoutPlanController extends GetxController {

  var isLoading = false.obs;

  List<String> filterDuration = [
    "15 Min",
    "30 Min",
    "45 Min",
    "60 Min",
    "75 Min",
    "90 Min",
    "105 Min",
    "120 Min",
  ];
  // List<String> filterMuscleGroup = ["Fresh Muscle", "Trained Muscle"];
  List<String> filterLevel = ["Beginner", "Intermediate", "Advanced"];
  List<Map<int,String>> filterMuscle = [
    {1: "MUSCLES"},
    {2: "CHEST"},
    {3: "ARMS"},
    {4: "SHOULDERS"},
    {5: "LEGS"},
    {6: "BACK"},
    {7: "CORE"},
    {8: "CARDIO"},
    {9: "FRESH MUSCLES"},
  ];

  List<Map<int,String>> filterExerciseByMuscle = [
    {1: "ABS & CORE"},
    {2: "BACK"},
    {3: "BICEPS"},
    {4: "CARDIO"},
    {5: "CHEST"},
    {6: "FOREARMS"},
    {7: "LEGS & GLUTES"},
    {8: "RESISTANCE BAND"},
    {9: "SHOULDERS"},
    {10: "STRETCHES"},
    {11: "TRICEPS"},
  ];

  List<String> filterGoal = [
    "Bodybuilding",
    "Weight Maintenance",
    "Weight Loss",
    "Flexibility",
    "Cardio",
    "Improve Mobility",
    "Stress Relief",
    "Injury prevention",
    "Rehab",
    "Increase energy levels",
    "Improve posture",
  ];

  Rx<WorkoutFilter> selectedFilter = WorkoutFilter(
    duration: "15 Min",
    level: "Beginner",
    muscle: {1: "MUSCLES"},
    goal: null,
    muscleList: [],
  ).obs;
  WorkoutFilter? lastFilter;

  RxString searchQuery = "".obs;
  Worker? searchWorker;
  TextEditingController searchTFCtrl = TextEditingController();
  var searchFieldVisibility = false.obs;
  Map<int, String> filterExerciseMuscle = {};

  final WorkOutRepository workOutRepository = WorkOutRepository();

  Rxn<WorkoutData> workoutData = Rxn<WorkoutData>(null);
  CustomWorkout? selectedSavedWorkout;
  Rxn<MuscleData> musclesData = Rxn<MuscleData>(null);
  Rxn<ExerciseData> exerciseData = Rxn<ExerciseData>(null);
  Rxn<ExerciseData> addNewExerciseData = Rxn<ExerciseData>(null);
  Rxn<Exercise> selectedExercise = Rxn<Exercise>(null);
  RxList<Muscle> selectedMuscle = <Muscle>[].obs;
  Rxn<GroupDetails> groupDetails = Rxn<GroupDetails>(null);
  Rxn<WorkOutData> workoutLogData = Rxn<WorkOutData>(null);
  RxList<Exercise> selectedExercises = <Exercise>[].obs;

  TextEditingController editGroupNameTFCtrl = TextEditingController();
  var isStartTimer = false.obs;
  Rxn<CustomWorkout> workoutPlan = Rxn<CustomWorkout>(null);
  GroupExercises? workoutExercise;

  bool isSavedWorkOutSelected = false;

  var globalReps = 0.obs;
  var globalWeight = 0.obs;



  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      lastFilter = selectedFilter.value;
      await fetchMuscles(mainMuscle: selectedFilter.value.muscle.values.first);
      fetchExercises(filter: selectedFilter.value);
      setGlobalRepsWeight();
    });
  }

  @override
  void onReady() {
    super.onReady();
    searchWorker = debounce(searchQuery, (callBack) {
      fetchAllExercises(forceReload: true, searchQuery: callBack);
    }, time: 1000.milliseconds);
    debounce(selectedFilter, (WorkoutFilter newFilter) {
      if (lastFilter != newFilter) {
        lastFilter = newFilter;
        isSavedWorkOutSelected = false;
        fetchExercises(filter: newFilter, onFilterChange: true);
      }
    }, time: Duration(milliseconds: 600));
  }

  @override
  void onClose() {
    super.onClose();
    editGroupNameTFCtrl.dispose();
    searchWorker?.dispose();
    searchTFCtrl.dispose();
  }

  void updateFilter({
    String? duration,
    String? muscleGroup,
    String? level,
    Map<int, String>? muscle,
    String? goal,
    List<Muscle>? muscleList,
  }) {
    final current = selectedFilter.value;
    selectedFilter.value = WorkoutFilter(
      duration: duration ?? current.duration,
      level: level ?? current.level,
      muscle: muscle ?? current.muscle,
      goal: goal ?? current.goal,
      muscleList: muscleList ?? current.muscleList,
    );
  }

  void reset() {
    selectedFilter.value = WorkoutFilter(
      duration: "15 Min",
      level: "Beginner",
      muscle: {1: "MUSCLES"},
      goal: null,
      muscleList: [],
    );
    lastFilter = selectedFilter.value;
    selectedMuscle.value = [];
    selectedExercises.value = [];
    exerciseData.value?.exercises = [];
    exerciseData.value = null;
    update();
  }
  void toggleVisibility () {
    searchFieldVisibility.value = !searchFieldVisibility.value;
  }

  setGlobalRepsWeight () {
    globalReps.value = getReps() ?? 10;
    globalWeight.value = getWeights() ?? 10;
  }


  Future<void> fetchWorkoutPlanList({bool forceReload = false}) async {
    if (forceReload) {
      workoutData.value = null;
    }
    try {
      if(workoutData.value != null && workoutData.value?.currentPage == workoutData.value?.lastPage) {
        return;
      }
      showLoader(true);
      var res = await workOutRepository.getWorkoutPlan(
        pageNo: workoutData.value?.currentPage != null
            ? ((workoutData.value?.currentPage ?? 0) + 1) : 1
      );
      if (res != null && res.data?.workouts != null) {
        if(workoutData.value == null) {
          workoutData.value = res.data;
        }
        else if (workoutData.value != null && workoutData.value?.workouts != null && workoutData.value!.workouts!.isNotEmpty) {
          workoutData.value?.currentPage = res.data?.currentPage;
          workoutData.value?.lastPage = res.data?.lastPage;
          workoutData.value?.workouts?.addAll(res.data?.workouts ?? []);
        }
      }
    } catch (_) {

    } finally {
      showLoader(false);
    }
  }

  Future<void> fetchMuscles({bool forceReload = false, String? mainMuscle}) async {
    if (forceReload) {
      selectedMuscle.value = [];
      musclesData.value = null;
    }
    try {
      if(musclesData.value != null && musclesData.value?.currentPage == musclesData.value?.lastPage) {
        return;
      }
      isLoading(true);
      var res = await workOutRepository.getMuscle(
        pageNo: musclesData.value?.currentPage != null
          ? ((musclesData.value?.currentPage ?? 0) + 1) : 1,
        mainMuscle: mainMuscle,
      );
      if (res != null && res.data?.muscles != null) {
        if(musclesData.value == null) {
          musclesData.value = res.data;
        }
        else if (musclesData.value != null && musclesData.value?.muscles != null && musclesData.value!.muscles!.isNotEmpty) {
          musclesData.value?.currentPage = res.data?.currentPage;
          musclesData.value?.lastPage = res.data?.lastPage;
          musclesData.value?.muscles?.addAll(res.data?.muscles ?? []);
        }
        if (mainMuscle != null) {
          selectedMuscle.addAll(musclesData.value?.muscles ?? []);
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchExercises({bool forceReload = false, WorkoutFilter? filter, bool onFilterChange = false}) async {
    if (forceReload || onFilterChange) {
      exerciseData.value = null;
    }
    try {
      if(!onFilterChange && exerciseData.value != null && exerciseData.value?.currentPage == exerciseData.value?.lastPage) {
        return;
      }
      isLoading(true);
      var res = await workOutRepository.getExercise(
        queryParameter: {
          "duration_minutes": filter?.duration.split(" ").first,
          "difficulty": filter?.level,
          if (filter?.goal != null) "goal": filter?.goal,
          "muscle_group_id": selectedMuscle.map((e) => e.id).join(","),
          "page": exerciseData.value?.currentPage != null
              ? ((exerciseData.value?.currentPage ?? 0) + 1) : 1, //23,
          "per_page": 20,
        },
      );
      if (res != null && res.data?.exercises != null) {
        if(exerciseData.value == null) {
          exerciseData.value = res.data;
        }
        else if (exerciseData.value != null && exerciseData.value?.exercises != null && exerciseData.value!.exercises!.isNotEmpty) {
          exerciseData.value?.currentPage = res.data?.currentPage;
          exerciseData.value?.lastPage = res.data?.lastPage;
          exerciseData.value?.exercises?.addAll(res.data?.exercises ?? []);
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllExercises({bool forceReload = false, String? searchQuery,}) async {
    if (forceReload) {
      addNewExerciseData.value = null;
    }
    try {
      if(addNewExerciseData.value != null && addNewExerciseData.value?.currentPage == addNewExerciseData.value?.lastPage) {
        return;
      }
      isLoading(true);
      var res = await workOutRepository.getExercise(
        queryParameter: {
          "page": addNewExerciseData.value?.currentPage != null
              ? ((addNewExerciseData.value?.currentPage ?? 0) + 1) : 1,
          "per_page": 20,
          if (searchQuery != null) "search": searchQuery,
          if (filterExerciseMuscle.isNotEmpty) "muscle_group_id": filterExerciseMuscle.keys.first
        }
      );
      if (res != null && res.data?.exercises != null) {
        if(addNewExerciseData.value == null) {
          addNewExerciseData.value = res.data;
        }
        else if (addNewExerciseData.value != null && addNewExerciseData.value?.exercises != null
            && addNewExerciseData.value!.exercises!.isNotEmpty) {
          addNewExerciseData.value?.currentPage = res.data?.currentPage;
          addNewExerciseData.value?.lastPage = res.data?.lastPage;
          addNewExerciseData.value?.exercises?.addAll(res.data?.exercises ?? []);
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> getGroupName(BuildContext context, {String? groupName, bool isEditing = false}) async {
    editGroupNameTFCtrl.text = isEditing ? groupName ?? "" : "";
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          padding: const EdgeInsets.fromLTRB(12,22,12,12),
          heading: isEditing ? "Edit Workout Plan" : "Create Workout Plan",
          onClose: () {
            Navigator.of(context).pop();
            editGroupNameTFCtrl.clear();
          },
          bottomChild: CustomButton(
            onTap: () {
              if (editGroupNameTFCtrl.text.trim().isEmpty) return;
              Navigator.of(context).pop();
            },
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            title: isEditing ? "Edit" : "Create",
          ),
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: CustomTextField(
                    controller: editGroupNameTFCtrl,
                    hintText: "Enter Workout Name",
                    maxLines: 3,
                    prefix: const Icon(Icons.edit_note, color: grey,),
                    borderColor: themeColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      Future.microtask(() {
        FocusManager.instance.primaryFocus?.unfocus();
      });
    });
  }


  Future<void> getGroupDetails({CustomWorkout? workout}) async {
    try {
      isLoading(true);
      // var res = await workOutRepository.groupDetails(
      //   groupID: groupID,
      // );
      selectedSavedWorkout = CustomWorkout(
        id: workout?.id,
        memberID: workout?.memberID,
        name: workout?.name,
        exerciseData: CustomExerciseData(
          filters: workout?.exerciseData?.filters,
          exercises: workout?.exerciseData?.exercises?.map((e) => e.copyWith()).toList(),
          // [...workout?.exerciseData?.exercises ?? <Exercise>[]],
          total: workout?.exerciseData?.total,
        ),
        isActive: workout?.isActive,
        createdAt: workout?.createdAt,
        updatedAt: workout?.updatedAt,
      );
      if (workout != null) {
        selectedFilter.value = WorkoutFilter(
          duration: "${workout.exerciseData?.filters?.durationMinutes} Min",
          level: "${workout.exerciseData?.filters?.difficulty}",
          muscle: workout.exerciseData?.filters?.muscleGroupFilter?.data ?? {1: "MUSCLES"},
          goal: workout.exerciseData?.filters?.goal != null ? "${workout.exerciseData?.filters?.goal}" : null,
          muscleList: workout.exerciseData?.filters?.muscleGroupList != null ?
              [...workout.exerciseData?.filters?.muscleGroupList! ?? []] : []
        );
        lastFilter = selectedFilter.value;
        selectedMuscle.value = [...workout.exerciseData?.filters?.muscleGroupList! ?? []];
        exerciseData.value = ExerciseData(
          currentPage: 1,
          exercises: workout.exerciseData?.exercises?.map((e) => e.copyWith()).toList(),
          // [...workout.exerciseData?.exercises ?? []],
          from: 1,
          lastPage: 1,
          perPage: 20,
          to: 1,
          total: workout.exerciseData?.total,
        );
        isSavedWorkOutSelected = true;
        Get.back();
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> createWorkoutPlan(BuildContext context, {required List<Exercise> listOfExercises, bool saveWorkout = false}) async {
    if (saveWorkout) {
      await getGroupName(context, isEditing: false);
    }
    if (saveWorkout && editGroupNameTFCtrl.text.trim().isEmpty) return;
    if (listOfExercises.isEmpty) return;
    try {
      isLoading(true);
      final Map<String, dynamic> filter = {
        "duration_minutes": selectedFilter.value.duration.split(" ").first,
        "difficulty": selectedFilter.value.level,
        "goal": selectedFilter.value.goal,
        "muscle_group_filter": selectedFilter.value.muscle.map(
          (key, value) => MapEntry(key.toString(), value),
        ),
        "muscle_group_list": [...selectedMuscle.map(
          (e) => e.toJson().map((key, value) => MapEntry(key.toString(), value),)
        )],
      };

      final List<Map<String, dynamic>> exercises = listOfExercises.map((e) => e.toJson().map(
        (key, value) => MapEntry(key.toString(), value),)
      ).toList();

      final Map<String, dynamic> data = {
        if (editGroupNameTFCtrl.text.isNotEmpty) "name": editGroupNameTFCtrl.text.trim(),
        "exercises_data": {
          "filters": filter,
          "exercises": exercises,
          "total": exercises.length,
        }
      };

      // log(jsonEncode(data));
      //
      // print(CustomWorkout.fromJson(data).exerciseData?.filters?.toJson());

      // return;

      var res = await workOutRepository.createGroup(
        data: data
      );
      if (res.isNotEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(message: "Success 👏, Workout Plan Created successfully",),
          );
        }
        // reset();
        navigateToStartWorkout(CustomWorkout.fromJson(res["data"]));
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }
  void navigateToStartWorkout(CustomWorkout? res) {
    workoutPlan.value = res;
    // print(CustomWorkout.fromJson(res["data"]).exerciseData?.filters?.toJson());
    Get.to(() => StartWorkoutView());
  }

  Future<void> updateExercisesInGroup(BuildContext context, {
    int? groupID, String? groupName, int? muscleID, String? muscleName,
    List<int>? selectedExercises
  }) async {
    selectedMuscle.value = [Muscle(id: muscleID, name: muscleName)];
    this.selectedExercises.value = [];// selectedExercises ?? [];
    Get.toNamed(AppRoutes.selectExercise, arguments: {
      "isEditing": true,
    });
  }

  Future<void> editGroup(BuildContext context, {
    required int? workoutID, required String? workoutName,
    VoidCallback? onSuccess,
  }) async {
    await getGroupName(context, isEditing: true, groupName: workoutName);
    if (editGroupNameTFCtrl.text.trim().isEmpty) return;
    try {
      isLoading(true);
      var res = await workOutRepository.updateGroup(
        workoutID: workoutID,
        workoutName: editGroupNameTFCtrl.text.trim(),
      );
      if (res.isNotEmpty) {
        for (CustomWorkout e in workoutData.value?.workouts ?? []) {
          if (e.id == workoutID) {
            e.name = res["data"]["name"] ?? workoutName;
            update(["saved-workout-list"]);
            break;
          }
        }
        selectedExercises.clear();
        editGroupNameTFCtrl.clear();
        if (onSuccess != null) {
          onSuccess();
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: "Success 👏, Workout updated successfully",
            ),
          );
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteGroup(BuildContext context, {required int? workoutID,}) async {
    try {
      isLoading(true);
      var res = await workOutRepository.deleteGroup(
        workoutID: workoutID,
      );
      // res => {status: true, message: Exercise group deleted successfully}
      if (res != null) {
        workoutData.value?.workouts?.removeWhere((element) => element.id == workoutID);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: "Success 👏, Group deleted successfully",
            ),
          );
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteGroupExercise(BuildContext context, {required int? exerciseID, int? groupID}) async {
    try {
      isLoading(true);
      var res = await workOutRepository.deleteGroupExercise(
        groupExerciseID: exerciseID,
      );
      // res => {status: true, message: Exercise group deleted successfully}
      if (res != null) {
        for (CustomWorkout workout in workoutData.value?.workouts ?? []){
          if (workout.id == groupID) {
            workout.exerciseData?.total = (workout.exerciseData?.total ?? 1) - 1;
          }
          groupDetails.value?.groupExercises?.removeWhere((e) => e.id == exerciseID);
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: "Success 👏, Group exercise deleted successfully",
            ),
          );
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }


  Future<bool> logEndWorkoutTime(
      BuildContext context, DateTime? workoutStartTime, DateTime? workoutEndTime, ) async {
    try {
      isLoading(true);
      final Map<String, dynamic> filter = {
        "duration_minutes": workoutPlan.value?.exerciseData?.filters?.durationMinutes?.split(" ").first,
        "difficulty": workoutPlan.value?.exerciseData?.filters?.difficulty,
        "goal": workoutPlan.value?.exerciseData?.filters?.goal,
        "muscle_group_filter": workoutPlan.value?.exerciseData?.filters?.muscleGroupFilter?.data?.map(
          (key, value) => MapEntry(key.toString(), value),
        ),
        "muscle_group_list": [...workoutPlan.value?.exerciseData?.filters?.muscleGroupList?.map(
          (e) => e.toJson().map((key, value) => MapEntry(key.toString(), value),)) ?? []
        ],
      };

      final List<Map<String, dynamic>> exercises = workoutPlan.value?.exerciseData?.exercises?.map((e) => e.toJson().map(
        (key, value) => MapEntry(key.toString(), value),)
      ).toList() ?? [];

      final Map<String, dynamic> data = {
        "filters": filter,
        "exercises": exercises,
        "total": exercises.length,
      };
      var res = await workOutRepository.logWorkoutTime(
        data: {
          "workout_plan_id": workoutPlan.value?.id,
          "start_time": DateFormat("HH:mm:ss").format(workoutStartTime?.toUtc() ?? DateTime.now().toUtc()),
          "end_time": DateFormat("HH:mm:ss").format(workoutEndTime?.toUtc() ?? DateTime.now().toUtc()),
          "log_date": DateFormat("yyyy/MM/dd").format(workoutEndTime?.toUtc() ?? DateTime.now()),
          "log_data": data,
        },
        start: false
      );
      if(res != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: "Success 👏, Workout Time saved",
          ),
        );
        return true;
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future<void> fetchWorkOutLogs({bool forceReload = false}) async {
    if (forceReload) {
      workoutLogData.value = null;
    }
    try {
      if(workoutLogData.value != null && workoutLogData.value?.currentPage == workoutLogData.value?.lastPage) {
        return;
      }
      isLoading(true);
      var res = await workOutRepository.getWorkoutTimeLogs(
        pageNo: workoutLogData.value?.currentPage != null
          ? ((workoutLogData.value?.currentPage ?? 0) + 1) : 1
      );
      if (res != null && res.data?.workoutLogs != null) {
        if(workoutLogData.value == null) {
          workoutLogData.value = res.data;
        }
        else if (workoutLogData.value != null && workoutLogData.value?.workoutLogs != null &&
            workoutLogData.value!.workoutLogs!.isNotEmpty) {
          workoutLogData.value?.currentPage = res.data?.currentPage;
          workoutLogData.value?.lastPage = res.data?.lastPage;
          workoutLogData.value?.workoutLogs?.addAll(res.data?.workoutLogs ?? []);
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  String? formatTZDateString(String? tzString, {String format = 'dd-MM-yyyy'}) {
    if (tzString == null || tzString.trim().isEmpty) {
      return null;
    }
    try {
      final dateTime = DateTime.tryParse(tzString)?.toLocal(); // Converts UTC to local
      return DateFormat(format).format(dateTime!);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return null;
    }
  }
}


class WorkoutFilter {
  final String duration;
  // final String muscleGroup;
  final String level;
  final Map<int, String> muscle;
  final String? goal;
  final List<Muscle> muscleList;

  WorkoutFilter({
    required this.duration,
    // required this.muscleGroup,
    required this.level,
    required this.muscle,
    required this.goal,
    required this.muscleList,
  });


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkoutFilter &&
        other.duration == duration &&
        // other.muscleGroup == muscleGroup &&
        other.level == level &&
        mapEquals(other.muscle, muscle) &&
        other.goal == goal &&
        listEquals(other.muscleList, muscleList);
  }

  @override
  int get hashCode =>
      duration.hashCode ^
      // muscleGroup.hashCode ^
      level.hashCode ^
      muscle.hashCode ^
      goal.hashCode ^
      muscleList.hashCode;
}