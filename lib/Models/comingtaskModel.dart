class ComingTaskModel {
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

  ComingTaskModel(
      {this.id,
      this.sharerId,
      this.userId,
      this.taskId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.task,
      this.sharer});

  ComingTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sharerId = json['sharer_id'];
    userId = json['user_id'];
    taskId = json['task_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
    sharer = json['sharer'] != null ? new User.fromJson(json['sharer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sharer_id'] = this.sharerId;
    data['user_id'] = this.userId;
    data['task_id'] = this.taskId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.task != null) {
      data['task'] = this.task!.toJson();
    }
    if (this.sharer != null) {
      data['sharer'] = this.sharer!.toJson();
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
  String? location;
  int? terms;
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
      this.location,
      this.terms,
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
    location = json['location'];
    terms = json['terms'];
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
    data['location'] = this.location;
    data['terms'] = this.terms;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
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

  Task(
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
      this.updatedAt});

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
    return data;
  }
}
