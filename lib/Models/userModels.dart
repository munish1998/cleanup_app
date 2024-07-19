class userModel {
  late String id;
  late String fullname;
  late String email;
  userModel({required this.email, required this.fullname, required this.id});
  // json to object
  userModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.fullname = map['fullname'];
  }
// object to json

  Map<String, dynamic> tomap() {
    return {
      "id": this.id,
      "email": this.email,
      "fullname": this.fullname,
    };
  }
}
