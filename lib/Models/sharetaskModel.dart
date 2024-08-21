class ShareTaskModel {
  int? taskId;
  int? userId;
  int? taskCount;
  User? user;

  ShareTaskModel({this.taskId, this.userId, this.taskCount, this.user});

  ShareTaskModel.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    userId = json['user_id'];
    taskCount = json['task_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['user_id'] = this.userId;
    data['task_count'] = this.taskCount;
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
  String? socialSignup;
  int? isAdmin;
  int? isActive;
  String? emailVerifiedAt;
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
