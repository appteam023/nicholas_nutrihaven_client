class CategoryModel {
  String? status;
  List<Category>? categories;

  CategoryModel({this.status, this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      categories = <Category>[];
      json['data'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (categories != null) {
      data['category'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  String? categoryDescription;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.categoryId,
        this.categoryName,
        this.categoryImage,
        this.categoryDescription,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryDescription = json['category_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['category_description'] = categoryDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
