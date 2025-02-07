class ForgetPasswordModel {
  bool? success;
  String? message;
  Data? data;

  ForgetPasswordModel({this.success, this.message, this.data});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? code;

  Data({this.userId, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['code'] = this.code;
    return data;
  }
}