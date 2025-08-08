import 'dart:convert';

class GetExerciseModel {
  String? status;
  List<Datum>? data;

  GetExerciseModel({
    this.status,
    this.data,
  });

  factory GetExerciseModel.fromRawJson(String str) =>
      GetExerciseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetExerciseModel.fromJson(Map<String, dynamic> json) =>
      GetExerciseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? nutrihavenExerciseId;
  String? nutrihavenExerciseName;
  String? nutrihavenExerciseInstructions;
  String? nutrihavenExerciseVideoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.nutrihavenExerciseId,
    this.nutrihavenExerciseName,
    this.nutrihavenExerciseInstructions,
    this.nutrihavenExerciseVideoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nutrihavenExerciseId: json["nutrihaven_exercise_id"],
        nutrihavenExerciseName: json["nutrihaven_exercise_name"],
        nutrihavenExerciseInstructions:
            json["nutrihaven_exercise_instructions"],
        nutrihavenExerciseVideoUrl: json["nutrihaven_exercise_video_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nutrihaven_exercise_id": nutrihavenExerciseId,
        "nutrihaven_exercise_name": nutrihavenExerciseName,
        "nutrihaven_exercise_instructions": nutrihavenExerciseInstructions,
        "nutrihaven_exercise_video_url": nutrihavenExerciseVideoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
