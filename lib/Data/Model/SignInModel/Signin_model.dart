class SignInModel {
  String? message;
  String? token;
  User? user;

  SignInModel({this.message, this.token, this.user});

  SignInModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? memberId;
  String? memberFullName;
  String? memberEmail;
  String? memberProfile;
  String? memberGender;
  int? memberAge;
  num? memberWeight;
  String? memberWeightUnit;
  num? memberHeightFt;
  num? memberHeightIn;
  String? memberGoal;
  String? memberExp;
  String? memberExercisePlace;
  String? memberToken;
  String? memberStatus;
  String? createdAt;
  String? updatedAt;

  User(
      {this.memberId,
        this.memberFullName,
        this.memberEmail,
        this.memberProfile,
        this.memberGender,
        this.memberAge,
        this.memberWeight,
        this.memberWeightUnit,
        this.memberHeightFt,
        this.memberHeightIn,
        this.memberGoal,
        this.memberExp,
        this.memberExercisePlace,
        this.memberToken,
        this.memberStatus,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberFullName = json['member_full_name'];
    memberEmail = json['member_email'];
    memberProfile = json['member_profile'];
    memberGender = json['member_gender'];
    memberAge = json['member_age'];
    memberWeight = json['member_weight'];
    memberWeightUnit = json['member_weight_unit'];
    memberHeightFt = json['member_height_ft'];
    memberHeightIn = json['member_height_in'];
    memberGoal = json['member_goal'];
    memberExp = json['member_exp'];
    memberExercisePlace = json['member_excerise_place'];
    memberToken = json['member_token'];
    memberStatus = json['member_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_id'] = memberId;
    data['member_full_name'] = memberFullName;
    data['member_email'] = memberEmail;
    data['member_profile'] = memberProfile;
    data['member_gender'] = memberGender;
    data['member_age'] = memberAge;
    data['member_weight'] = memberWeight;
    data['member_weight_unit'] = memberWeightUnit;
    data['member_height_ft'] = memberHeightFt;
    data['member_height_in'] = memberHeightIn;
    data['member_goal'] = memberGoal;
    data['member_exp'] = memberExp;
    data['member_excerise_place'] = memberExercisePlace;
    data['member_token'] = memberToken;
    data['member_status'] = memberStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
