// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
// import 'package:cleanup_mobile/Models/mytaskModel.dart';
// import 'package:cleanup_mobile/Providers/authProvider.dart';
// import 'package:cleanup_mobile/Utils/Constant.dart';
// import 'package:cleanup_mobile/Utils/commonMethod.dart';
// import 'package:cleanup_mobile/Utils/customLoader.dart';
// import 'package:cleanup_mobile/apiServices/apiConstant.dart';
// import 'package:cleanup_mobile/apiServices/apiServices.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class TaskBlock with ChangeNotifier {
//   List<MyTaskModel> _mytasklist = [];
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _locationController = TextEditingController();
//   TextEditingController _descriptionController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _countryController = TextEditingController();
//   TextEditingController _cityController = TextEditingController();
//   TextEditingController _areaController = TextEditingController();

//   List<MyTaskModel> get mytasklist => _mytasklist;
//   TextEditingController get nameController => _nameController;
//   TextEditingController get locationController => _locationController;
//   TextEditingController get discriptionController => _descriptionController;
//   TextEditingController get emailController => _emailController;
//   TextEditingController get phoneController => _phoneController;
//   TextEditingController get countryController => _countryController;
//   TextEditingController get cityController => _cityController;
//   TextEditingController get areaController => _areaController;

//   Future<void> getMyTaskList({
//     required BuildContext context,
//     required Map<String, String> data,
//   }) async {
//     var url = Uri.parse(ApiServices.getmytaskList);

//     try {
//       final response = await ApiClient().postDataByToken(
//         context: context,
//         url: url,
//         body: data,
//       );

//       // Log the raw response for debugging
//       log('Response body: ${response.body}');

//       // Check for HTML response or invalid JSON
//       if (response.headers['content-type']?.contains('application/json') ==
//           true) {
//         var result = jsonDecode(response.body);

//         if (response.statusCode == 200) {
//           if (result['code'] == 200) {
//             log('MyTaskList response: $result');
//             var list = result['tasks'] as List;
//             _mytasklist = list.map((e) => MyTaskModel.fromJson(e)).toList();
//             notifyListeners();
//           } else if (result['code'] == 401) {
//             Provider.of<AuthProvider>(context, listen: false).logout(context);
//           } else if (result['code'] == 201) {
//             notifyListeners();
//           } else {
//             log('Error code from server: ${result['code']}');
//             notifyListeners();
//           }
//         } else {
//           log('Error: Status code ${response.statusCode}');
//           notifyListeners();
//         }
//       } else {
//         log('Unexpected content-type: ${response.headers['content-type']}');
//         // Handle unexpected response format
//         notifyListeners();
//       }
//     } catch (e) {
//       log('Exception occurred: $e');
//       notifyListeners();
//     }
//   }

//   // Future<void> createTask2(
//   //     {required BuildContext context, required Map data}) async {
//   //   var url = Uri.parse(ApiServices.createTask);
//   //   showLoaderDialog(context, 'Please wait...');
//   //   final response = await ApiClient()
//   //       .postDataByToken(context: context, url: url, body: data);
//   //   var result = jsonDecode(response.body);
//   //   navPop(context: context);

//   //   if (response.statusCode == 200) {
//   //     if (result['code'] == 200) {
//   //       notifyListeners();
//   //       commonToast(msg: result['message'], color: Colors.green);
//   //     } else if (result['code'] == 401) {
//   //       navPushRemove(context: context, action: LoginScreen());
//   //     } else {
//   //       commonToast(msg: result['message'], color: Colors.green);
//   //       notifyListeners();
//   //     }
//   //   } else {
//   //     notifyListeners();
//   //   }
//   // }

//   Future<dynamic> uploadcompanydriver({
//     required File licencefile,
//     required File addressfile,
//     required File insurancwfile,
//     required File gitfile,
//     required File liabilityfile,
//     required File vehilefile,
//     required File dvlafile,
//     required File vehiclecertificate,
//     required File nationalitycerti,
//     required String userid,
//     required File licencebackfile,
//     required String username,
//     required String usertype,
//     required String accesstoken,
//     required String email,
//     required String drivertype,
//     required String mobile,
//     required String password,
//   }) async {
//     String url =
//         "https://webpristine.com/work/clickandsend/api/auth/company/add-driver/$userid";
//     final request = http.MultipartRequest('POST', Uri.parse(url));

//     // Create a multipart file from the file path

//     var licnece =
//         await http.MultipartFile.fromPath('licence_front', licencefile.path);
//     var licenceback =
//         await http.MultipartFile.fromPath('licence_back', licencebackfile.path);
//     var address =
//         await http.MultipartFile.fromPath('address_proof', addressfile.path);
//     var insurance =
//         await http.MultipartFile.fromPath('insurance_cert', insurancwfile.path);
//     var transit =
//         await http.MultipartFile.fromPath('transit_cert', gitfile.path);
//     var liability =
//         await http.MultipartFile.fromPath('liability_cert', liabilityfile.path);
//     var vehicecerti = await http.MultipartFile.fromPath(
//         'vehicle_cert', vehiclecertificate.path);
//     var vimage = await http.MultipartFile.fromPath('V5c_cert', vehilefile.path);
//     var dvla = await http.MultipartFile.fromPath('dvia_cert', dvlafile.path);
//     var ncerti = await http.MultipartFile.fromPath(
//         'nationality_cert', nationalitycerti.path);

//     request.files.add(licnece);
//     request.fields["user_name"] = username;
//     request.fields["user_type"] = usertype;
//     request.fields["email"] = email;
//     request.fields["mobile"] = mobile;
//     request.fields["driver_type"] = drivertype;
//     request.fields["password"] = password;
//     request.fields["password_confirmation"] = password;
//     request.files.add(licenceback);

//     request.files.add(address);
//     request.files.add(insurance);
//     request.files.add(transit);
//     request.files.add(liability);
//     request.files.add(vehicecerti);
//     request.files.add(vimage);
//     request.files.add(dvla);
//     request.files.add(ncerti);

//     // Add the file to the request

//     request.headers["Authorization"] = "Bearer $accesstoken";
//     var response = await request.send();
//     var responseBody = await response.stream.bytesToString();

//     log(responseBody);

//     if (response.statusCode == 200) {
//       return jsonDecode(responseBody);
//     } else {
//       throw UnimplementedError();
//     }
//   }

//   Future<dynamic> uploadcompanydrive9r({
//     required File beforeImage,
//     required File afterImage,
//     required String userid,
//     required String location,
//     required String description,
//     required String title,
//   }) async {
//     final request =
//         http.MultipartRequest('POST', Uri.parse(ApiServices.createTask));
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     // Create a multipart file from the file path

//     var before = await http.MultipartFile.fromPath('before', beforeImage.path);
//     var after = await http.MultipartFile.fromPath('after', afterImage.path);

//     request.files.add(before);
//     request.fields["location"] = location;
//     request.fields["title"] = title;
//     request.fields["description"] = description;

//     request.files.add(after);

//     // Add the file to the request

//     request.headers["Authorization"] = "Bearer $accessTokenKey";
//     var response = await request.send();
//     var responseBody = await response.stream.bytesToString();

//     log(responseBody);

//     if (response.statusCode == 200) {
//       return jsonDecode(responseBody);
//     } else {
//       throw UnimplementedError();
//     }
//   }

//   Future<void> createTask({
//     required BuildContext context,
//     required String title,
//     required String location,
//     required String description,
//     File? beforeImage,
//     File? afterImage,
//   }) async {
//     var url = Uri.parse(ApiServices.createTask);
//     showLoaderDialog(context, 'Please wait...');

//     var request = http.MultipartRequest('POST', url);

//     // Add text fields
//     request.fields['title'] = title;
//     request.fields['location'] = location;
//     request.fields['description'] = description;

//     // Add image files
//     if (beforeImage != null) {
//       var beforeFile =
//           await http.MultipartFile.fromPath('before', beforeImage.path);
//       request.files.add(beforeFile);
//     }

//     if (afterImage != null) {
//       var afterFile =
//           await http.MultipartFile.fromPath('after', afterImage.path);
//       request.files.add(afterFile);
//     }

//     // Add headers
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     request.headers['access_token'] = pref.getString(accessTokenKey) ?? '';
//     request.headers['Content-Type'] = 'application/x-www-form-urlencoded';

//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       var result = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         if (result['code'] == 200) {
//           notifyListeners();
//           commonToast(msg: result['message'], color: Colors.green);
//         } else if (result['code'] == 401) {
//           navPushRemove(context: context, action: LoginScreen());
//         } else {
//           commonToast(msg: result['message'], color: Colors.red);
//           notifyListeners();
//         }
//       } else {
//         commonToast(msg: result['message'], color: Colors.red);
//         notifyListeners();
//       }
//     } catch (e) {
//       log(e.toString());
//       commonToast(msg: 'An error occurred', color: Colors.red);
//     } finally {
//       navPop(context: context);
//     }
//   }
// }
