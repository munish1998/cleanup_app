import 'dart:convert';

class ProfileModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String mobile;
  final String? dob;
  final String? image;
  final String? bgimage;
  final String base_url;
  final String location;
  final int terms;
  final int is_admin;
  final int is_active;
  final String? email_verified_at;
  final String updated_at;
  final String created_at;

  ProfileModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.mobile,
    this.dob,
    this.image,
    this.bgimage,
    required this.base_url,
    required this.location,
    required this.terms,
    required this.is_admin,
    required this.is_active,
    this.email_verified_at,
    required this.updated_at,
    required this.created_at,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      dob: json['dob'] as String?,
      image: json['image'] as String?,
      bgimage: json['bgimage'] as String?,
      base_url: json['base_url'] ?? '',
      location: json['location'] ?? '',
      terms: json['terms'] ?? 0,
      is_admin: json['is_admin'] ?? 0,
      is_active: json['is_active'] ?? 0,
      email_verified_at: json['email_verified_at'] as String?,
      updated_at: json['updated_at'] ?? '',
      created_at: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'image': image,
      'bgimage': bgimage,
      'base_url': base_url,
      'location': location,
      'terms': terms,
      'is_admin': is_admin,
      'is_active': is_active,
      'email_verified_at': email_verified_at,
      'updated_at': updated_at,
      'created_at': created_at,
    };
  }
}
