class AllUserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String mobile;
  final String? dob;
  final String? image;
  final String? bgimage;
  final String? baseUrl;
  final String? location;
  final int terms;
  final String? socialSignup;
  final int isAdmin;
  final int isActive;
  final String? emailVerifiedAt;
  final String updatedAt;
  final String createdAt;

  AllUserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.mobile,
    this.dob,
    this.image,
    this.bgimage,
    this.baseUrl,
    this.location,
    required this.terms,
    this.socialSignup,
    required this.isAdmin,
    required this.isActive,
    this.emailVerifiedAt,
    required this.updatedAt,
    required this.createdAt,
  });

  factory AllUserModel.fromJson(Map<String, dynamic> json) {
    return AllUserModel(
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
