class GroupModel {
  bool? status;
  String? message;
  GroupData? data;

  GroupModel({this.status, this.message, this.data});

  GroupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GroupData.fromJson(json['data']) : null;
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

class GroupData {
  int? currentPage;
  List<Group>? groups;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  GroupData({
    this.currentPage,
    this.groups,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  GroupData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      groups = <Group>[];
      json['data'].forEach((v) {
        groups!.add(Group.fromJson(v));
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
    if (groups != null) {
      data['data'] = groups!.map((v) => v.toJson()).toList();
    }
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Group {
  int? id;
  int? memberId;
  String? title;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? groupExercisesCount;

  Group({
    this.id,
    this.memberId,
    this.title,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.groupExercisesCount,
  });

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    title = json['title'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groupExercisesCount = json['group_exercises_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_id'] = memberId;
    data['title'] = title;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['group_exercises_count'] = groupExercisesCount;
    return data;
  }
}
