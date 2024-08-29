class NotificationModel {
  bool? success;
  List<Notifications>? notifications;

  NotificationModel({this.success, this.notifications});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'],
      notifications: json['notifications'] != null
          ? (json['notifications'] as List)
              .map((i) => Notifications.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  int? userId;
  int? eventId;
  String? title;
  String? body;
  String? type;
  int? isRead;
  int? isDeleted;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Notifications({
    this.id,
    this.userId,
    this.eventId,
    this.title,
    this.body,
    this.type,
    this.isRead,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      isRead: json['is_read'],
      isDeleted: json['is_deleted'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['is_read'] = this.isRead;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
