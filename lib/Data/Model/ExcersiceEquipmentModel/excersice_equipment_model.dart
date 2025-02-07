import 'dart:convert';

class ExerciseEquipmentModel {
  final bool success;
  final String message;
  final List<Category> data;

  ExerciseEquipmentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExerciseEquipmentModel.fromJson(String str) =>
      ExerciseEquipmentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExerciseEquipmentModel.fromMap(Map<String, dynamic> json) =>
      ExerciseEquipmentModel(
        success: json["success"],
        message: json["message"],
        data: List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Category {
  final String category;
  final List<SubCategory> subCategories;

  Category({
    required this.category,
    required this.subCategories,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        category: json["category"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toMap())),
      };
}

class SubCategory {
  final String subCategory;
  final List<ExerciseItem> items;

  SubCategory({
    required this.subCategory,
    required this.items,
  });

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        subCategory: json["subCategory"],
        items: List<ExerciseItem>.from(
            json["items"].map((x) => ExerciseItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "subCategory": subCategory,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class ExerciseItem {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final String image;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  bool isSelected;

  ExerciseItem({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSelected,
  });

  factory ExerciseItem.fromMap(Map<String, dynamic> json) => ExerciseItem(
        id: json["_id"],
        name: json["name"],
        category: json["category"],
        subCategory: json["subCategory"],
        image: json["image"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "category": category,
        "subCategory": subCategory,
        "image": image,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isSelected": isSelected,
      };
}
