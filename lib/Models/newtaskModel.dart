class MyTaskModel {
  bool? success;
  List<Tasks>? tasks;

  MyTaskModel({this.success, this.tasks});

  MyTaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  int? userId;
  int? shareTaskId;
  String? location;
  String? title;
  String? description;
  String? before;
  String? after;
  String? baseUrl;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  Tasks(
      {this.id,
      this.userId,
      this.shareTaskId,
      this.location,
      this.title,
      this.description,
      this.before,
      this.after,
      this.baseUrl,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shareTaskId = json['share_task_id'];
    location = json['location'];
    title = json['title'];
    description = json['description'];
    before = json['before'];
    after = json['after'];
    baseUrl = json['base_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['share_task_id'] = this.shareTaskId;
    data['location'] = this.location;
    data['title'] = this.title;
    data['description'] = this.description;
    data['before'] = this.before;
    data['after'] = this.after;
    data['base_url'] = this.baseUrl;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? name;
  String? email;
  String? mobile;
  String? dob;
  String? image;
  String? bgimage;
  String? baseUrl;
  String? location;
  int? terms;
  Null? socialSignup;
  int? isAdmin;
  int? isActive;
  Null? emailVerifiedAt;
  String? updatedAt;
  String? createdAt;

  User(
      {this.id,
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
      this.updatedAt,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
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
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
