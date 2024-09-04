import 'dart:convert';
import 'dart:developer';

class MyFriendsModel {
  bool? success;
  List<Friends>? friends;
  List<int>? blocked; // Change to List<int> to store IDs

  MyFriendsModel({this.success, this.friends, this.blocked});

  MyFriendsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['friends'] != null) {
      friends = <Friends>[];
      try {
        json['friends'].forEach((v) {
          if (v is Map<String, dynamic>) {
            friends!.add(Friends.fromJson(v));
          } else {
            log('Unexpected type in friends list: ${v.runtimeType}');
          }
        });
      } catch (e) {
        log('Error parsing friends: $e');
      }
    }
    if (json['blocked'] != null) {
      blocked = <int>[]; // Initialize blocked as List<int>
      try {
        json['blocked'].forEach((v) {
          if (v is int) {
            // Expecting int IDs
            blocked!.add(v);
          } else {
            log('Unexpected type in blocked list: ${v.runtimeType}');
          }
        });
      } catch (e) {
        log('Error parsing blocked: $e');
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    if (this.blocked != null) {
      data['blocked'] = this.blocked; // Just return the list of IDs
    }
    return data;
  }
}

class Friends {
  int? id;
  String? username;
  String? name;
  String? email;
  String? mobile;
  String? dob;
  String? image;
  dynamic bgimage;
  String? baseUrl;
  String? location;
  int? terms;
  dynamic socialSignup;
  int? isAdmin;
  int? isActive;
  dynamic emailVerifiedAt;
  String? deviceToken;
  String? updatedAt;
  String? createdAt;

  Friends({
    this.id,
    this.username,
    this.name,
    this.email,
    this.mobile,
    this.dob,
    this.image,
    this.bgimage,
    this.baseUrl,
    this.location,
    this.terms,
    this.socialSignup,
    this.isAdmin,
    this.isActive,
    this.emailVerifiedAt,
    this.deviceToken,
    this.updatedAt,
    this.createdAt,
  });

  Friends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    image = json['image'];
    bgimage = json['bgimage'];
    baseUrl = json['base_url'];
    location = json['location'];
    terms = json['terms'];
    socialSignup = json['social_signup'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    emailVerifiedAt = json['email_verified_at'];
    deviceToken = json['device_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['bgimage'] = this.bgimage;
    data['base_url'] = this.baseUrl;
    data['location'] = this.location;
    data['terms'] = this.terms;
    data['social_signup'] = this.socialSignup;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['device_token'] = this.deviceToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Blocked {
  int? id;
  String? name;

  Blocked({this.id, this.name});

  Blocked.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
