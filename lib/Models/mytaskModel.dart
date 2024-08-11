import 'package:flutter/foundation.dart';

class MyTask {
  final int id;
  final int userId;
  final String location;
  final String title;
  final String description;
  final String before;
  final String after;
  final String baseUrl;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  MyTask({
    required this.id,
    required this.userId,
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

  // Factory constructor to create an instance from JSON data
  factory MyTask.fromJson(Map<String, dynamic> json) {
    return MyTask(
      id: json['id'],
      userId: json['user_id'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      before: json['before'],
      after: json['after'],
      baseUrl: json['base_url'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
