// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String? name;
  String? email;
  String? phone;
  String? token;

  Data({
    this.name,
    this.email,
    this.phone,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "token": token,
      };
}
