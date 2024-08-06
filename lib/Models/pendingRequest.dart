class PendingRequestModel {
  int? id;
  int? senderId;
  int? receiverId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Sender? sender;

  PendingRequestModel(
      {this.id,
      this.senderId,
      this.receiverId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.sender});

  PendingRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    return data;
  }
}

class Sender {
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

  Sender(
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

  Sender.fromJson(Map<String, dynamic> json) {
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
