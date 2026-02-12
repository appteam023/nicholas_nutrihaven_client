class GroupDetailsModel {
  bool? status;
  String? message;
  GroupDetails? data;

  GroupDetailsModel({this.status, this.message, this.data});

  GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GroupDetails.fromJson(json['data']) : null;
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

class GroupDetails {
  int? id;
  int? memberId;
  String? title;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  List<GroupExercises>? groupExercises;

  GroupDetails({
    this.id,
    this.memberId,
    this.title,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.groupExercises,
  });

  GroupDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    title = json['title'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['group_exercises'] != null) {
      groupExercises = <GroupExercises>[];
      json['group_exercises'].forEach((v) {
        groupExercises!.add(GroupExercises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['title'] = title;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (groupExercises != null) {
      data['group_exercises'] =
          groupExercises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupExercises {
  int? id;
  int? groupId;
  int? masterExerciseId;
  String? createdAt;
  String? updatedAt;
  MasterExercise? masterExercise;

  GroupExercises({
    this.id,
    this.groupId,
    this.masterExerciseId,
    this.createdAt,
    this.updatedAt,
    this.masterExercise,
  });

  GroupExercises.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    masterExerciseId = json['master_exercise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    masterExercise = json['master_exercise'] != null
        ? MasterExercise.fromJson(json['master_exercise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_id'] = groupId;
    data['master_exercise_id'] = masterExerciseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (masterExercise != null) {
      data['master_exercise'] = masterExercise!.toJson();
    }
    return data;
  }
}

class MasterExercise {
  int? id;
  String? name;
  int? muscleGroupId;
  int? equipmentRequiredId;
  int? auxEquipmentId;
  String? exerciseImage;
  String? createdAt;
  String? updatedAt;

  MasterExercise({
    this.id,
    this.name,
    this.muscleGroupId,
    this.equipmentRequiredId,
    this.auxEquipmentId,
    this.exerciseImage,
    this.createdAt,
    this.updatedAt,
  });

  MasterExercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    muscleGroupId = json['muscle_group_id'];
    equipmentRequiredId = json['equipment_required_id'];
    auxEquipmentId = json['aux_equipment_id'];
    exerciseImage = json['exercise_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['muscle_group_id'] = muscleGroupId;
    data['equipment_required_id'] = equipmentRequiredId;
    data['aux_equipment_id'] = auxEquipmentId;
    data['exercise_image'] = exerciseImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
