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
  String? difficulty;
  int? muscleGroupId;
  String? primaryMuscles;
  String? secondaryMuscles;
  List<String>? goals;
  int? durationMinutes;
  List<DefaultSets>? defaultSets;
  int? workoutVideoId;
  int? equipmentRequiredId;
  int? auxEquipmentId;
  String? exerciseImage;
  String? createdAt;
  String? updatedAt;
  MuscleGroup? muscleGroup;
  EquipmentRequired? equipmentRequired;
  AuxEquipment? auxEquipment;
  WorkoutVideo? workoutVideo;

  Exercise({
    this.id,
    this.name,
    this.difficulty,
    this.muscleGroupId,
    this.primaryMuscles,
    this.secondaryMuscles,
    this.goals,
    this.durationMinutes,
    this.defaultSets,
    this.workoutVideoId,
    this.equipmentRequiredId,
    this.auxEquipmentId,
    this.exerciseImage,
    this.createdAt,
    this.updatedAt,
    this.muscleGroup,
    this.equipmentRequired,
    this.auxEquipment,
    this.workoutVideo,
  });

  Exercise copyWith({
    int? id,
    String? name,
    String? difficulty,
    int? muscleGroupId,
    String? primaryMuscles,
    String? secondaryMuscles,
    List<String>? goals,
    int? durationMinutes,
    List<DefaultSets>? defaultSets,
    int? workoutVideoId,
    int? equipmentRequiredId,
    int? auxEquipmentId,
    String? exerciseImage,
    String? createdAt,
    String? updatedAt,
    MuscleGroup? muscleGroup,
    EquipmentRequired? equipmentRequired,
    AuxEquipment? auxEquipment,
    WorkoutVideo? workoutVideo,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      goals: goals != null ? List.from(goals) :  this.goals,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      defaultSets: defaultSets != null ? defaultSets.map((e) => e.copyWith()).toList()
          : this.defaultSets?.map((e) => e.copyWith()).toList(),
      workoutVideoId: workoutVideoId ?? this.workoutVideoId,
      equipmentRequiredId: equipmentRequiredId ?? this.equipmentRequiredId,
      auxEquipmentId: auxEquipmentId ?? this.auxEquipmentId,
      exerciseImage: exerciseImage ?? this.exerciseImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      equipmentRequired: equipmentRequired ?? this.equipmentRequired,
      auxEquipment: auxEquipment ?? this.auxEquipment,
      workoutVideo: workoutVideo ?? this.workoutVideo,
    );
  }

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    difficulty = json['difficulty'];
    muscleGroupId = json['muscle_group_id'];
    primaryMuscles = json['primary_muscles'];
    secondaryMuscles = json['secondary_muscles'];
    goals = json['goals'].cast<String>();
    durationMinutes = json['duration_minutes'];
    if (json['default_sets'] != null) {
      defaultSets = <DefaultSets>[];
      json['default_sets'].forEach((v) {
        defaultSets!.add(DefaultSets.fromJson(v));
      });
    }
    workoutVideoId = json['workout_video_id'];
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
    workoutVideo = json['workout_video'] != null
        ? WorkoutVideo.fromJson(json['workout_video'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['difficulty'] = difficulty;
    data['muscle_group_id'] = muscleGroupId;
    data['primary_muscles'] = primaryMuscles;
    data['secondary_muscles'] = secondaryMuscles;
    data['goals'] = goals;
    data['duration_minutes'] = durationMinutes;
    if (defaultSets != null) {
      data['default_sets'] = defaultSets!.map((v) => v.toJson()).toList();
    }
    data['workout_video_id'] = workoutVideoId;
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
    if (auxEquipment != null) {
      data['aux_equipment'] = auxEquipment!.toJson();
    }
    if (workoutVideo != null) {
      data['workout_video'] = workoutVideo!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
      other.id == id &&
      other.name == name &&
      other.difficulty == difficulty &&
      other.muscleGroupId == muscleGroupId &&
      other.primaryMuscles == primaryMuscles &&
      other.secondaryMuscles == secondaryMuscles &&
      _listEquals(other.goals, goals) &&
      other.durationMinutes == durationMinutes &&
      _listEquals(other.defaultSets, defaultSets) &&
      other.workoutVideoId == workoutVideoId &&
      other.equipmentRequiredId == equipmentRequiredId &&
      other.auxEquipmentId == auxEquipmentId &&
      other.exerciseImage == exerciseImage &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.muscleGroup == muscleGroup &&
      other.equipmentRequired == equipmentRequired &&
      other.auxEquipment == auxEquipment &&
      other.workoutVideo == workoutVideo;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      difficulty,
      muscleGroupId,
      primaryMuscles,
      secondaryMuscles,
      Object.hashAll(goals ?? []),
      durationMinutes,
      Object.hashAll(defaultSets ?? []),
      workoutVideoId,
      equipmentRequiredId,
      auxEquipmentId,
      exerciseImage,
      createdAt,
      updatedAt,
      muscleGroup,
      equipmentRequired,
      auxEquipment,
      workoutVideo,
    );
  }

// Helper for list comparison
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

class DefaultSets {
  int? set;
  int? reps;
  int? weight;
  bool? isCompleted;

  DefaultSets({this.set, this.reps, this.weight, this.isCompleted = false});

  DefaultSets copyWith({
    int? set,
    int? reps,
    int? weight,
    bool? isCompleted,
  }) {
    return DefaultSets(
      set: set ?? this.set,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  DefaultSets.fromJson(Map<String, dynamic> json) {
    set = json['set'];
    reps = json['reps'];
    weight = json['weight'];
    isCompleted = json['is_completed'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['set'] = set;
    data['reps'] = reps;
    data['weight'] = weight;
    data['is_completed'] = isCompleted;
    return data;
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DefaultSets &&
      other.set == set &&
      other.reps == reps &&
      other.weight == weight &&
      other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return Object.hash(
      set,
      reps,
      weight,
      isCompleted,
    );
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

class WorkoutVideo {
  int? workoutVideosId;
  String? workoutVideosDescription;
  String? workoutVideosTitle;
  String? workoutVideosCdnUrl;
  int? workoutVideosCategoryId;
  String? createdAt;
  String? updatedAt;

  WorkoutVideo({
    this.workoutVideosId,
    this.workoutVideosDescription,
    this.workoutVideosTitle,
    this.workoutVideosCdnUrl,
    this.workoutVideosCategoryId,
    this.createdAt,
    this.updatedAt,
  });

  WorkoutVideo.fromJson(Map<String, dynamic> json) {
    workoutVideosId = json['workout_videos_id'];
    workoutVideosDescription = json['workout_videos_description'];
    workoutVideosTitle = json['workout_videos_title'];
    workoutVideosCdnUrl = json['workout_videos_cdn_url'];
    workoutVideosCategoryId = json['workout_videos_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}