
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Config/AppRoutes/routes_imports.dart';
import '../../../Data/Model/ExcerciseModel/get_exercise_model.dart';
import '../../../Data/Model/ExerciseGroup/group_details_model.dart';
import '../../../Data/Model/WorkOutLogs/workout_logs_model.dart';
import '../../../Data/Model/muscleModel/get_muscle_model.dart';
import '../../../Data/Repository/workout_repository.dart';
import '../../../Data/Response/api_response.dart';
import '../../../Data/Model/ExerciseGroup/group_model.dart';
import '../../../Utils/Const/color_const.dart';
import '../../../Widgets/custom_TextField.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_dialog.dart';
import '../../../Widgets/custom_snackbar.dart';
import '../../../Widgets/loader_widget.dart';

class WorkoutPlanController extends GetxController {

  var isLoading = false.obs;

  final WorkOutRepository workOutRepository = WorkOutRepository();
  final Rx<ApiResponse<MuscleModel>> getMuscleResponse =
      ApiResponse<MuscleModel>.initial().obs;

  Rxn<GroupData> groupData = Rxn<GroupData>(null);
  Rxn<MuscleData> musclesData = Rxn<MuscleData>(null);
  Rxn<ExerciseData> exerciseData = Rxn<ExerciseData>(null);
  Rxn<Muscle> selectedMuscle = Rxn<Muscle>(null);
  Rxn<GroupDetails> groupDetails = Rxn<GroupDetails>(null);
  Rxn<WorkOutData> workoutLogData = Rxn<WorkOutData>(null);
  RxList<int> selectedExercises = <int>[].obs;

  TextEditingController editGroupNameTFCtrl = TextEditingController();
  var isStartTimer = false.obs;
  GroupExercises? workoutExercise;



  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchGroups();
    });
  }


  Future<void> fetchGroups({bool forceReload = false}) async {
    if (forceReload) {
      groupData.value = null;
    }
    try {
      if(groupData.value != null && groupData.value?.currentPage == groupData.value?.lastPage) {
        return;
      }
      showLoader(true);
      var res = await workOutRepository.getGroup(
        pageNo: groupData.value?.currentPage != null
            ? ((groupData.value?.currentPage ?? 0) + 1) : 1
      );
      if (res != null && res.data?.groups != null) {
        if(groupData.value == null) {
          groupData.value = res.data;
        }
        else if (groupData.value != null && groupData.value?.groups != null && groupData.value!.groups!.isNotEmpty) {
          groupData.value?.currentPage = res.data?.currentPage;
          groupData.value?.lastPage = res.data?.lastPage;
          groupData.value?.groups?.addAll(res.data?.groups ?? []);
        }
      }
    } catch (_) {

    } finally {
      showLoader(false);
    }
  }

  Future<void> fetchMuscles({bool forceReload = false}) async {
    if (forceReload) {
      selectedMuscle.value = null;
      musclesData.value = null;
    }
    try {
      if(musclesData.value != null && musclesData.value?.currentPage == musclesData.value?.lastPage) {
        return;
      }
      isLoading(true);
      var res = await workOutRepository.getMuscle(
        pageNo: musclesData.value?.currentPage != null
          ? ((musclesData.value?.currentPage ?? 0) + 1) : 1
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
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchExercises({bool forceReload = false, required int? muscleId}) async {
    if (forceReload) {
      selectedExercises.clear();
      exerciseData.value = null;
    }
    if (exerciseData.value != null && exerciseData.value!.exercises != null && exerciseData.value!.exercises!.isNotEmpty &&
        exerciseData.value!.exercises!.first.muscleGroupId != muscleId) {
      selectedExercises.clear();
      exerciseData.value = null;
    }
    try {
      if(exerciseData.value != null && exerciseData.value?.currentPage == exerciseData.value?.lastPage) {
        return;
      }
      isLoading(true);
      var res = await workOutRepository.getExercise(
        muscleId: muscleId,
        pageNo: exerciseData.value?.currentPage != null
          ? ((exerciseData.value?.currentPage ?? 0) + 1) : 1
      );
      if (res != null && res.data?.exercises != null) {
        if (selectedMuscle.value?.name == null && (res.data?.exercises?.isNotEmpty ?? false)) {
          selectedMuscle.value?.name = res.data?.exercises?.first.muscleGroup?.name;
        }
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

  Future<void> getGroupName(BuildContext context, {String? groupName, bool isEditing = false}) async {
    editGroupNameTFCtrl.text = isEditing ? groupName ?? "" : "";
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          padding: const EdgeInsets.fromLTRB(12,22,12,12),
          heading: isEditing ? "Edit Workout Group" : "Create Workout Group",
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
                    hintText: "Enter Group Name",
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


  Future<void> getGroupDetails({int? groupID,}) async {
    try {
      isLoading(true);
      var res = await workOutRepository.groupDetails(
        groupID: groupID,
      );
      if (res != null) {
        groupDetails.value = res.data;
        Get.toNamed(AppRoutes.groupDetail);
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> createGroup(BuildContext context, {List<int>? selectedExercises,}) async {
    await getGroupName(context, isEditing: false);
    if (editGroupNameTFCtrl.text.trim().isEmpty || (selectedExercises?.isEmpty ?? false)) return;

    try {
      isLoading(true);
      var res = await workOutRepository.createGroup(
        groupName: editGroupNameTFCtrl.text.trim(),
        exerciseIDs: selectedExercises!,
      );
      if (res != null) {
        await fetchGroups(forceReload: true);
        selectedExercises.clear();
        editGroupNameTFCtrl.clear();
        selectedMuscle.value = null;
        Get.close(2);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: "Success 👏, Group Created successfully",
          ),
        );
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateExercisesInGroup(BuildContext context, {
    int? groupID, String? groupName, int? muscleID, String? muscleName,
    List<int>? selectedExercises
  }) async {
    selectedMuscle.value = Muscle(id: muscleID, name: muscleName);
    this.selectedExercises.value = selectedExercises ?? [];
    Get.toNamed(AppRoutes.selectExercise, arguments: {
      "isEditing": true,
    });
  }

  Future<void> editGroup(BuildContext context, {
    required int? groupID, required String? groupName, List<int>? selectedExercises,
    VoidCallback? onSuccess,
  }) async {
    await getGroupName(context, isEditing: true, groupName: groupName);
    if (editGroupNameTFCtrl.text.trim().isEmpty) return;

    try {
      isLoading(true);
      var res = await workOutRepository.updateGroup(
        groupID: groupID,
        groupName: editGroupNameTFCtrl.text.trim(),
        exerciseIDs: selectedExercises!,
      );
      if (res != null) {
        for (Group e in groupData.value?.groups ?? []) {
          if (e.id == groupID) {
            e.title = res.data?.title;
            e.groupExercisesCount = res.data?.groupExercises?.length;
            break;
          }
        }
        this.selectedExercises.clear();
        groupDetails.value = res.data;
        editGroupNameTFCtrl.clear();
        if (onSuccess != null) {
          onSuccess();
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: "Success 👏, Group updated successfully",
            ),
          );
        }
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteGroup(BuildContext context, {required int? groupID,}) async {
    try {
      isLoading(true);
      var res = await workOutRepository.deleteGroup(
        groupID: groupID,
      );
      // res => {status: true, message: Exercise group deleted successfully}
      if (res != null) {
        groupData.value?.groups?.removeWhere((element) => element.id == groupID);
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
        for (Group group in groupData.value?.groups ?? []){
          if (group.id == groupID) {
            group.groupExercisesCount = (group.groupExercisesCount ?? 1) - 1;
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


  Future<bool> logEndWorkoutTime(BuildContext context, DateTime? workoutTime) async {
    try {
      var res = await workOutRepository.logWorkoutTime(
        data: {
          "group_exercise_id": Get.find<WorkoutPlanController>().workoutExercise?.id,
          "end_time": DateFormat("HH:mm:ss").format(workoutTime?.toUtc() ?? DateTime.now().toUtc()),
        },
        start: false
      );
      if(res != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: "Success 👏, Workout Time saved",
          ),
        );
        workoutExercise = null;
        return true;
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    } finally {
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
