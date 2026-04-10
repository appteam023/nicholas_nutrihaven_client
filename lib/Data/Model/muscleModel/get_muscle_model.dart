class MuscleModel {
  bool? status;
  String? message;
  MuscleData? data;

  MuscleModel({this.status, this.message, this.data});

  MuscleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? MuscleData.fromJson(json['data']) : null;
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

class MuscleData {
  int? currentPage;
  List<Muscle>? muscles;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  MuscleData({
    this.currentPage,
    this.muscles,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  MuscleData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      muscles = <Muscle>[];
      json['data'].forEach((v) {
        muscles!.add(Muscle.fromJson(v));
      });
    }
    from = json['from'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (muscles != null) {
      data['data'] = muscles!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Muscle {
  int? id;
  String? name;
  String? muscleImage;
  String? createdAt;
  String? updatedAt;

  Muscle({this.id, this.name, this.muscleImage, this.createdAt, this.updatedAt});

  Muscle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    muscleImage = json['muscle_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['muscle_image'] = muscleImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Muscle &&
        other.id == id &&
        other.name == name &&
        other.muscleImage == muscleImage &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      muscleImage.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
