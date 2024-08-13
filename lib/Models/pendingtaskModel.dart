class PendingTaskModel {
  int? id;
  int? sharerId;
  int? userId;
  int? taskId;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Task? task;
  User? sharer;

  PendingTaskModel({
    this.id,
    this.sharerId,
    this.userId,
    this.taskId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.task,
    this.sharer,
  });

  PendingTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sharerId = json['sharer_id'];
    userId = json['user_id'];
    taskId = json['task_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    sharer = json['sharer'] != null ? User.fromJson(json['sharer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sharer_id'] = sharerId;
    data['user_id'] = userId;
    data['task_id'] = taskId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (task != null) {
      data['task'] = task!.toJson();
    }
    if (sharer != null) {
      data['sharer'] = sharer!.toJson();
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

  User({
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
    this.updatedAt,
    this.createdAt,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dob'] = dob;
    data['image'] = image;
    data['bgimage'] = bgimage;
    data['base_url'] = baseUrl;
    data['location'] = location;
    data['terms'] = terms;
    data['social_signup'] = socialSignup;
    data['is_admin'] = isAdmin;
    data['is_active'] = isActive;
    data['email_verified_at'] = emailVerifiedAt;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

class Task {
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

  Task({
    this.id,
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
  });

  Task.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['share_task_id'] = shareTaskId;
    data['location'] = location;
    data['title'] = title;
    data['description'] = description;
    data['before'] = before;
    data['after'] = after;
    data['base_url'] = baseUrl;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
