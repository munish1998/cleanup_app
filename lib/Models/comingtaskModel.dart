import 'package:flutter/foundation.dart';

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

  ComingTaskModel({
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

  ComingTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    sharerId = json['sharer_id'] as int?;
    userId = json['user_id'] as int?;
    taskId = json['task_id'] as int?;
    status = json['status'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    user = json['user'] != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    task = json['task'] != null
        ? Task.fromJson(json['task'] as Map<String, dynamic>)
        : null;
    sharer = json['sharer'] != null
        ? User.fromJson(json['sharer'] as Map<String, dynamic>)
        : null;
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

  String? location;
  int? terms;
  int? isAdmin;
  int? isActive;
  String? updatedAt;
  String? createdAt;

  User({
    this.id,
    this.username,
    this.name,
    this.email,
    this.mobile,
    this.location,
    this.terms,
    this.isAdmin,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    username = json['username'] as String?;
    name = json['name'] as String?;
    email = json['email'] as String?;
    mobile = json['mobile'] as String?;
    location = json['location'] as String?;
    terms = json['terms'] as int?;
    isAdmin = json['is_admin'] as int?;
    isActive = json['is_active'] as int?;
    updatedAt = json['updated_at'] as String?;
    createdAt = json['created_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['location'] = location;
    data['terms'] = terms;
    data['is_admin'] = isAdmin;
    data['is_active'] = isActive;
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
    id = json['id'] as int?;
    userId = json['user_id'] as int?;
    shareTaskId = json['share_task_id'] as int?;
    location = json['location'] as String?;
    title = json['title'] as String?;
    description = json['description'] as String?;
    before = json['before'] as String?;
    after = json['after'] as String?;
    baseUrl = json['base_url'] as String?;
    status = json['status'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
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
