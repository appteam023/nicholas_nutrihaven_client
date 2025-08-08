class WorkoutVideosModel {
  String? status;
  List<Video>? videos;

  WorkoutVideosModel({this.status, this.videos});

  WorkoutVideosModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      videos = <Video>[];
      json['data'].forEach((v) {
        videos!.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int? workoutVideosId;
  String? workoutVideosDescription;
  String? workoutVideosTitle;
  String? workoutVideosCdnUrl;
  int? workoutVideosCategoryId;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  String? categoryDescription;

  Video(
      {this.workoutVideosId,
        this.workoutVideosDescription,
        this.workoutVideosTitle,
        this.workoutVideosCdnUrl,
        this.workoutVideosCategoryId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.categoryName,
        this.categoryImage,
        this.categoryDescription});

  Video.fromJson(Map<String, dynamic> json) {
    workoutVideosId = json['workout_videos_id'];
    workoutVideosDescription = json['workout_videos_description'];
    workoutVideosTitle = json['workout_videos_title'];
    workoutVideosCdnUrl = json['workout_videos_cdn_url'];
    workoutVideosCategoryId = json['workout_videos_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryDescription = json['category_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['workout_videos_id'] = workoutVideosId;
    data['workout_videos_description'] = workoutVideosDescription;
    data['workout_videos_title'] = workoutVideosTitle;
    data['workout_videos_cdn_url'] = workoutVideosCdnUrl;
    data['workout_videos_category_id'] = workoutVideosCategoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['category_description'] = categoryDescription;
    return data;
  }
}
