import 'dart:convert';

class PostExerciseModel {
  String? status;
  String? message;
  Data? data;

  PostExerciseModel({
    this.status,
    this.message,
    this.data,
  });

  factory PostExerciseModel.fromRawJson(String str) =>
      PostExerciseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostExerciseModel.fromJson(Map<String, dynamic> json) =>
      PostExerciseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? exerciseNutrihavenExerciseId;
  String? exerciseWorkoutExerciseId;
  String? exerciseRepetitions;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? exerciseId;

  Data({
    this.exerciseNutrihavenExerciseId,
    this.exerciseWorkoutExerciseId,
    this.exerciseRepetitions,
    this.updatedAt,
    this.createdAt,
    this.exerciseId,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exerciseNutrihavenExerciseId: json["exercise_nutrihaven_exercise_id"],
        exerciseWorkoutExerciseId: json["exercise_workout_exercise_id"],
        exerciseRepetitions: json["exercise_repetitions"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        exerciseId: json["exercise_id"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_nutrihaven_exercise_id": exerciseNutrihavenExerciseId,
        "exercise_workout_exercise_id": exerciseWorkoutExerciseId,
        "exercise_repetitions": exerciseRepetitions,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "exercise_id": exerciseId,
      };
}
