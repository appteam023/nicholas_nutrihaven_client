import '../WorkoutPlan/custom_workout_plan_model.dart';

class WorkoutLogsModel {
  bool? status;
  String? message;
  WorkOutData? data;

  WorkoutLogsModel({this.status, this.message, this.data});

  WorkoutLogsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WorkOutData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class WorkOutData {
  int? currentPage;
  List<WorkoutLogData>? workoutLogs;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  WorkOutData({
    this.currentPage,
    this.workoutLogs,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  WorkOutData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      workoutLogs = <WorkoutLogData>[];
      json['data'].forEach((v) {
        workoutLogs!.add(WorkoutLogData.fromJson(v));
      });
    }
    from = json['from'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (workoutLogs != null) {
      data['data'] = workoutLogs!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class WorkoutLogData {
  int? id;
  int? memberId;
  int? workoutPlanId;
  String? startTime;
  String? endTime;
  String? logDate;
  CustomExerciseData? logData;

  WorkoutLogData({
    this.id,
    this.memberId,
    this.workoutPlanId,
    this.startTime,
    this.endTime,
    this.logDate,
    this.logData,
  });

  WorkoutLogData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    workoutPlanId = json['workout_plan_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    logDate = json['log_date'];
    logData = json['log_data'] != null
        ? CustomExerciseData.fromJson(json['log_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['workout_plan_id'] = workoutPlanId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['log_date'] = logDate;
    if (logData != null) {
      data['log_data'] = logData!.toJson();
    }
    return data;
  }
}

class LogData {
  int? defaultSets;

  LogData({this.defaultSets});

  LogData.fromJson(Map<String, dynamic> json) {
    defaultSets = json['default_sets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['default_sets'] = defaultSets;
    return data;
  }
}


class MasterExercise {
  int? id;
  String? name;
  int? muscleGroupId;
  int? equipmentRequiredId;
  int? auxEquipmentId;
  String? exerciseImage;
  String? createdAt;
  String? updatedAt;

  MasterExercise({
    this.id,
    this.name,
    this.muscleGroupId,
    this.equipmentRequiredId,
    this.auxEquipmentId,
    this.exerciseImage,
    this.createdAt,
    this.updatedAt,
  });

  MasterExercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    muscleGroupId = json['muscle_group_id'];
    equipmentRequiredId = json['equipment_required_id'];
    auxEquipmentId = json['aux_equipment_id'];
    exerciseImage = json['exercise_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['muscle_group_id'] = muscleGroupId;
    data['equipment_required_id'] = equipmentRequiredId;
    data['aux_equipment_id'] = auxEquipmentId;
    data['exercise_image'] = exerciseImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
