import 'dart:convert';

class GetMuscleModel {
  String? status;
  List<Datum>? data;

  GetMuscleModel({
    this.status,
    this.data,
  });

  factory GetMuscleModel.fromRawJson(String str) =>
      GetMuscleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMuscleModel.fromJson(Map<String, dynamic> json) => GetMuscleModel(
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
  int? muscleId;
  String? muscleName;
  String? muscleImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.muscleId,
    this.muscleName,
    this.muscleImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        muscleId: json["muscle_id"],
        muscleName: json["muscle_name"],
        muscleImage: json["muscle_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "muscle_id": muscleId,
        "muscle_name": muscleName,
        "muscle_image": muscleImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
