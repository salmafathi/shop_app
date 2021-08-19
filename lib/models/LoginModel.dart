import 'dart:core';

class LoginModel {
   bool? status ;
  String? message ;
  UserModel? data ;

  LoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
}

class UserModel {
 int? id ;
  String? name ;
 String? email ;
 String?  phone;
  String? image ;
 String?  token;
 int? points ;
 int? credit ;

 UserModel.fromJson(Map<String,dynamic> json){
   id = json['id'];
   name = json['name'];
   email = json['email'];
   phone = json['phone'];
   image = json['image'];
   token = json['token'];
   points = json['points'];
   credit = json['credit'];
 }
}