class TagModel {
  String? status;
  String? message;
  TagData? data;

  TagModel({this.status, this.message, this.data});

  TagModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TagData.fromJson(json['data']) : null;
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

class TagData {
  String? tagNutriHeavenExerciseId;
  String? tagName;
  String? tagDescription;
  String? updatedAt;
  String? createdAt;
  int? tagId;

  TagData(
      {this.tagNutriHeavenExerciseId,
        this.tagName,
        this.tagDescription,
        this.updatedAt,
        this.createdAt,
        this.tagId});

  TagData.fromJson(Map<String, dynamic> json) {
    tagNutriHeavenExerciseId = json['tag_nutriheaven_excerise_id'];
    tagName = json['tag_name'];
    tagDescription = json['tag_description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag_nutriheaven_excerise_id'] = tagNutriHeavenExerciseId;
    data['tag_name'] = tagName;
    data['tag_description'] = tagDescription;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['tag_id'] = tagId;
    return data;
  }
}
