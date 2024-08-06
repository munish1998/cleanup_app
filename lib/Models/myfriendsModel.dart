class MyFriendsModel {
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
  Pivot? pivot;

  MyFriendsModel(
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
      this.createdAt,
      this.pivot});

  MyFriendsModel.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? friendId;

  Pivot({this.userId, this.friendId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    friendId = json['friend_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['friend_id'] = this.friendId;
    return data;
  }
}
