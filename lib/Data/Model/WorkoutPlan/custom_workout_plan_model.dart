import '../ExcerciseModel/get_exercise_model.dart';
import '../muscleModel/get_muscle_model.dart';

class CustomWorkout {
  int? id;
  int? memberID;
  String? name;
  CustomExerciseData? exerciseData;
  bool? isActive;
  String? createdAt;
  String? updatedAt;


  CustomWorkout({
    this.id,
    this.memberID,
    this.name,
    this.exerciseData,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  CustomWorkout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberID = json['member_id'];
    name = json['name'];
    exerciseData = json['exercises_data'] != null
        ? CustomExerciseData.fromJson(json['exercises_data'])
        : null;
    isActive = json["is_active"];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberID;
    data['name'] = name;
    if (exerciseData != null) {
      data['exercises_data'] = exerciseData!.toJson();
    }
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomWorkout &&
      other.id == id &&
      other.memberID == memberID &&
      other.name == name &&
      other.exerciseData == exerciseData &&
      other.isActive == isActive &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      memberID,
      name,
      exerciseData,
      isActive,
      createdAt,
      updatedAt,
    );
  }
}

class CustomExerciseData {
  Filters? filters;
  List<Exercise>? exercises;
  int? total;

  CustomExerciseData({this.filters, this.exercises, this.total});

  CustomExerciseData.fromJson(Map<String, dynamic> json) {
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    if (json['exercises'] != null) {
      exercises = <Exercise>[];
      json['exercises'].forEach((v) {
        exercises!.add(Exercise.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filters != null) {
      data['filters'] = filters!.toJson();
    }
    if (exercises != null) {
      data['exercises_data'] =
          exercises!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}


class Filters {
  String? durationMinutes;
  String? difficulty;
  String? goal;
  MuscleGroupFilter? muscleGroupFilter;
  List<Muscle>? muscleGroupList;

  Filters({
    this.durationMinutes,
    this.difficulty,
    this.goal,
    this.muscleGroupFilter,
    this.muscleGroupList,
  });

  Filters.fromJson(Map<String, dynamic> json) {
    durationMinutes = json['duration_minutes'];
    difficulty = json['difficulty'];
    goal = json['goal'];
    muscleGroupFilter = json['muscle_group_filter'] != null
        ? MuscleGroupFilter.fromJson(json['muscle_group_filter'])
        : null;
    if (json['muscle_group_list'] != null) {
      muscleGroupList = <Muscle>[];
      json['muscle_group_list'].forEach((v) {
        muscleGroupList!.add(Muscle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration_minutes'] = durationMinutes;
    data['difficulty'] = difficulty;
    data['goal'] = goal;
    if (muscleGroupFilter != null) {
      data['muscle_group_filter'] = muscleGroupFilter!.toJson();
    }
    if (muscleGroupList != null) {
      data['muscle_group_list'] =
          muscleGroupList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class MuscleGroupFilter {
//   String? s1;
//
//   MuscleGroupFilter({this.s1});
//
//   MuscleGroupFilter.fromJson(Map<String, dynamic> json) {
//     s1 = json['1'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['1'] = s1;
//     return data;
//   }
// }


class MuscleGroupFilter {
  final Map<int, String>? data;

  MuscleGroupFilter({required this.data});

  factory MuscleGroupFilter.fromJson(Map<String, dynamic> json) {
    if (json.keys.isEmpty) return MuscleGroupFilter(data: null);
    return MuscleGroupFilter(
      data: json.map(
        (key, value) => MapEntry(int.tryParse(key) ?? 1, value.toString()),
      ),
    );
  }

  Map<int, String>? toJson() {
    return data;
  }
}

