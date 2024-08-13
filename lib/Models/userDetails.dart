class Userdetails {
  String? message;
  User? user;
  String? accessToken;
  String? tokenType;

  Userdetails({this.message, this.user, this.accessToken, this.tokenType});

  Userdetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? name;
  String? email;
  String? mobile;
  String? image;
  String? bgimage;
  String? baseUrl;
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
    this.image,
    this.bgimage,
    this.baseUrl,
    this.location,
    this.terms,
    this.isAdmin,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    bgimage = json['bgimage'];
    baseUrl = json['base_url'];
    location = json['location'];
    terms = json['terms'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['image'] = image;
    data['bgimage'] = bgimage;
    data['base_url'] = baseUrl;
    data['location'] = location;
    data['terms'] = terms;
    data['is_admin'] = isAdmin;
    data['is_active'] = isActive;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
