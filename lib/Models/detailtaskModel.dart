// Define a model for the user
class User {
  final int id;
  final String username;
  final String name;
  final String email;
  final String mobile;
  final String location;
  final int terms;
  final int isAdmin;
  final int isActive;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.mobile,
    required this.location,
    required this.terms,
    required this.isAdmin,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      location: json['location'],
      terms: json['terms'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
    );
  }
}

// Define a model for the task
class Taskk {
  final int id;
  final int userId;
  final String location;
  final String title;
  final String description;
  final String beforeImageUrl;
  final String afterImageUrl;
  final String baseUrl;
  final String status;
  final String createdAt;
  final String updatedAt;
  final User user;

  Taskk({
    required this.id,
    required this.userId,
    required this.location,
    required this.title,
    required this.description,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.baseUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Taskk.fromJson(Map<String, dynamic> json) {
    return Taskk(
      id: json['id'],
      userId: json['user_id'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      beforeImageUrl: '${json['base_url']}${json['before']}',
      afterImageUrl: '${json['base_url']}${json['after']}',
      baseUrl: json['base_url'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}
