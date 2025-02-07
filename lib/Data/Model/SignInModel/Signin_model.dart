class SigninModel {
  bool? success;
  String? message;
  Data? data;

  SigninModel({this.success, this.message, this.data});

  SigninModel.fromJson(var json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String? sId;
  String? fullname;
  String? email;
  String? profile;
  double? longitude;
  double? latitude;
  List<dynamic>? addToFavorite;
  bool? isDeleted;
  String? fcmToken;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  Agency? agency;
  int? iV;

  User(
      {this.sId,
      this.fullname,
      this.email,
      this.profile,
      this.longitude,
      this.latitude,
      this.addToFavorite,
      this.isDeleted,
      this.fcmToken,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.agency});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    profile = json['profile'];
    longitude =
        (json['longitude'] != null) ? json['longitude'].toDouble() : null;
    latitude = (json['latitude'] != null) ? json['latitude'].toDouble() : null;
    addToFavorite = json['addToFavorite'] != null
        ? List<dynamic>.from(json['addToFavorite'])
        : null;
    isDeleted = json['isDeleted'];
    fcmToken = json['fcmToken'];
    verified = json['verified'];
    agency = json['agency'] != null ? Agency.fromJson(json['agency']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullname'] = fullname;
    data['email'] = email;
    data['profile'] = profile;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    if (addToFavorite != null) {
      data['addToFavorite'] = addToFavorite;
    }
    data['isDeleted'] = isDeleted;
    data['fcmToken'] = fcmToken;
    data['verified'] = verified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Agency {
  String? agencyName;
  String? realtorId;

  Agency.fromJson(Map<String, dynamic> json) {
    agencyName = json['agencyName'];
    realtorId = json['realtorId'];
  }
}
