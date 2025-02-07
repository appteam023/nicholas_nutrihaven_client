import 'dart:convert';

class ExcersicePlaceModel {
  final bool success;
  final String message;
  final List<ExercisePlace> data;

  ExcersicePlaceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExcersicePlaceModel.fromJson(String str) =>
      ExcersicePlaceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExcersicePlaceModel.fromMap(Map<String, dynamic> json) =>
      ExcersicePlaceModel(
        success: json["success"],
        message: json["message"],
        data: List<ExercisePlace>.from(
            json["data"].map((x) => ExercisePlace.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class ExercisePlace {
  final String id;
  final String name;
  final String description;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isSelected;

  ExercisePlace({
    required this.id,
    required this.name,
    required this.description,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSelected,
  });

  factory ExercisePlace.fromJson(String str) =>
      ExercisePlace.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExercisePlace.fromMap(Map<String, dynamic> json) => ExercisePlace(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "description": description,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isSelected": isSelected,
      };
}
