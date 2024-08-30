class ShareTaskModel {
  final int id;
  final int sharerId;
  final int userId;
  final int taskId;
  final String status;
  final String createdAt;
  final String updatedAt;
  final User user;
  final Task task;
  final Sharer sharer;
  final ShareTask? shareTask;

  ShareTaskModel({
    required this.id,
    required this.sharerId,
    required this.userId,
    required this.taskId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.task,
    required this.sharer,
    this.shareTask,
  });

  factory ShareTaskModel.fromJson(Map<String, dynamic> json) {
    return ShareTaskModel(
      id: json['id'],
      sharerId: json['sharer_id'],
      userId: json['user_id'],
      taskId: json['task_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      task: Task.fromJson(json['task']),
      sharer: Sharer.fromJson(json['sharer']),
      shareTask: json['sharetask'] != null
          ? ShareTask.fromJson(json['sharetask'])
          : null,
    );
  }
}

class User {
  final int id;
  final String username;
  final String name;
  final String email;
  final String mobile;
  final String? dob;
  final String image;
  final String? bgimage;
  final String baseUrl;
  final String location;
  final int terms;
  final String? socialSignup;
  final int isAdmin;
  final int isActive;
  final String? emailVerifiedAt;
  final String updatedAt;
  final String createdAt;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.mobile,
    this.dob,
    required this.image,
    this.bgimage,
    required this.baseUrl,
    required this.location,
    required this.terms,
    this.socialSignup,
    required this.isAdmin,
    required this.isActive,
    this.emailVerifiedAt,
    required this.updatedAt,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      dob: json['dob'],
      image: json['image'],
      bgimage: json['bgimage'],
      baseUrl: json['base_url'],
      location: json['location'],
      terms: json['terms'],
      socialSignup: json['social_signup'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
      emailVerifiedAt: json['email_verified_at'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}

class Task {
  final int id;
  final int userId;
  final int shareTaskId;
  final String location;
  final String title;
  final String description;
  final String before;
  final String after;
  final String baseUrl;
  final String status;
  final String createdAt;
  final String updatedAt;

  Task({
    required this.id,
    required this.userId,
    required this.shareTaskId,
    required this.location,
    required this.title,
    required this.description,
    required this.before,
    required this.after,
    required this.baseUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['user_id'],
      shareTaskId: json['share_task_id'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      before: json['before'],
      after: json['after'],
      baseUrl: json['base_url'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Sharer {
  final int id;
  final String username;
  final String name;
  final String email;
  final String mobile;
  final String? dob;
  final String image;
  final String? bgimage;
  final String baseUrl;
  final String location;
  final int terms;
  final String? socialSignup;
  final int isAdmin;
  final int isActive;
  final String? emailVerifiedAt;
  final String updatedAt;
  final String createdAt;

  Sharer({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.mobile,
    this.dob,
    required this.image,
    this.bgimage,
    required this.baseUrl,
    required this.location,
    required this.terms,
    this.socialSignup,
    required this.isAdmin,
    required this.isActive,
    this.emailVerifiedAt,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Sharer.fromJson(Map<String, dynamic> json) {
    return Sharer(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      dob: json['dob'],
      image: json['image'],
      bgimage: json['bgimage'],
      baseUrl: json['base_url'],
      location: json['location'],
      terms: json['terms'],
      socialSignup: json['social_signup'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
      emailVerifiedAt: json['email_verified_at'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}

class ShareTask {
  final int id;
  final int userId;
  final int shareTaskId;
  final String location;
  final String title;
  final String description;
  final String before;
  final String after;
  final String baseUrl;
  final String status;
  final String createdAt;
  final String updatedAt;

  ShareTask({
    required this.id,
    required this.userId,
    required this.shareTaskId,
    required this.location,
    required this.title,
    required this.description,
    required this.before,
    required this.after,
    required this.baseUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShareTask.fromJson(Map<String, dynamic> json) {
    return ShareTask(
      id: json['id'],
      userId: json['user_id'],
      shareTaskId: json['share_task_id'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      before: json['before'],
      after: json['after'],
      baseUrl: json['base_url'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
