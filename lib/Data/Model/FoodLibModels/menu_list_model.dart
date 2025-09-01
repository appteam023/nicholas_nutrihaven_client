class FoodMenuModel {
  String? type;
  List<MenuItems>? menuItems;
  int? offset;
  int? number;
  int? totalMenuItems;
  int? processingTimeMs;

  FoodMenuModel({
    this.type,
    this.menuItems,
    this.offset,
    this.number,
    this.totalMenuItems,
    this.processingTimeMs
  });

  FoodMenuModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['menuItems'] != null) {
      menuItems = <MenuItems>[];
      json['menuItems'].forEach((v) {
        menuItems!.add(MenuItems.fromJson(v));
      });
    }
    offset = json['offset'];
    number = json['number'];
    totalMenuItems = json['totalMenuItems'];
    processingTimeMs = json['processingTimeMs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (menuItems != null) {
      data['menuItems'] = menuItems!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    data['number'] = number;
    data['totalMenuItems'] = totalMenuItems;
    data['processingTimeMs'] = processingTimeMs;
    return data;
  }
}

class MenuItems {
  int? id;
  String? title;
  String? image;
  String? imageType;
  String? restaurantChain;
  Servings? servings;

  MenuItems({
    this.id,
    this.title,
    this.image,
    this.imageType,
    this.restaurantChain,
    this.servings
  });

  MenuItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
    restaurantChain = json['restaurantChain'];
    servings = json['servings'] != null
        ? Servings.fromJson(json['servings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['imageType'] = imageType;
    data['restaurantChain'] = restaurantChain;
    if (servings != null) {
      data['servings'] = servings!.toJson();
    }
    return data;
  }
}

class Servings {
  num? number;
  num? size;
  String? unit;

  Servings({this.number, this.size, this.unit});

  Servings.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    size = json['size'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['size'] = size;
    data['unit'] = unit;
    return data;
  }
}
