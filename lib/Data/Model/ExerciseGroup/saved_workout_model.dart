import '../WorkoutPlan/custom_workout_plan_model.dart';

class WorkoutModel {
  bool? status;
  String? message;
  WorkoutData? data;

  WorkoutModel({this.status, this.message, this.data});

  WorkoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WorkoutData.fromJson(json['data']) : null;
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

class WorkoutData {
  int? currentPage;
  List<CustomWorkout>? workouts;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  WorkoutData({
    this.currentPage,
    this.workouts,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  WorkoutData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      workouts = <CustomWorkout>[];
      json['data'].forEach((v) {
        workouts!.add(CustomWorkout.fromJson(v));
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
    if (workouts != null) {
      data['data'] = workouts!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

