class RecipeModel {
  List<Recipe>? recipes;
  int? offset;
  int? number;
  int? totalResults;

  RecipeModel({this.recipes, this.offset, this.number, this.totalResults});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      recipes = <Recipe>[];
      json['results'].forEach((v) {
        recipes!.add(Recipe.fromJson(v));
      });
    }
    offset = json['offset'];
    number = json['number'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recipes != null) {
      data['results'] = recipes!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    data['number'] = number;
    data['totalResults'] = totalResults;
    return data;
  }
}

class Recipe {
  int? id;
  String? title;
  String? image;
  String? imageType;

  Recipe({this.id, this.title, this.image, this.imageType});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['imageType'] = imageType;
    return data;
  }
}
