class ExerciseModel {
  bool? status;
  String? message;
  ExerciseData? data;

  ExerciseModel({this.status, this.message, this.data});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ExerciseData.fromJson(json['data']) : null;
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

class ExerciseData {
  int? currentPage;
  List<Exercise>? exercises;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  ExerciseData({
    this.currentPage,
    this.exercises,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  ExerciseData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      exercises = <Exercise>[];
      json['data'].forEach((v) {
        exercises!.add(Exercise.fromJson(v));
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
    if (exercises != null) {
      data['data'] = exercises!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Exercise {
  int? id;
  String? name;
  int? muscleGroupId;
  int? equipmentRequiredId;
  int? auxEquipmentId;
  String? exerciseImage;
  String? createdAt;
  String? updatedAt;
  MuscleGroup? muscleGroup;
  EquipmentRequired? equipmentRequired;
  AuxEquipment? auxEquipment;

  Exercise({
    this.id,
    this.name,
    this.muscleGroupId,
    this.equipmentRequiredId,
    this.auxEquipmentId,
    this.exerciseImage,
    this.createdAt,
    this.updatedAt,
    this.muscleGroup,
    this.equipmentRequired,
    this.auxEquipment,
  });

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    muscleGroupId = json['muscle_group_id'];
    equipmentRequiredId = json['equipment_required_id'];
    auxEquipmentId = json['aux_equipment_id'];
    exerciseImage = json['exercise_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    muscleGroup = json['muscle_group'] != null
        ? MuscleGroup.fromJson(json['muscle_group'])
        : null;
    equipmentRequired = json['equipment_required'] != null
        ? EquipmentRequired.fromJson(json['equipment_required'])
        : null;
    auxEquipment = json['aux_equipment'] != null
        ? AuxEquipment.fromJson(json['aux_equipment'])
        : null;
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
    if (muscleGroup != null) {
      data['muscle_group'] = muscleGroup!.toJson();
    }
    if (equipmentRequired != null) {
      data['equipment_required'] = equipmentRequired!.toJson();
    }
    data['aux_equipment'] = auxEquipment;
    return data;
  }
}

class MuscleGroup {
  int? id;
  String? name;
  String? muscleImage;
  String? createdAt;
  String? updatedAt;

  MuscleGroup(
      {this.id, this.name, this.muscleImage, this.createdAt, this.updatedAt});

  MuscleGroup.fromJson(Map<String, dynamic> json) {
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
}

class EquipmentRequired {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  EquipmentRequired({this.id, this.name, this.createdAt, this.updatedAt});

  EquipmentRequired.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AuxEquipment {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  AuxEquipment({this.id, this.name, this.createdAt, this.updatedAt});

  AuxEquipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}