import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/Models/detailtaskModel.dart';
import 'package:cleanup_mobile/Models/myfriendsModel.dart';
import 'package:cleanup_mobile/Models/mytaskModel.dart';
import 'package:cleanup_mobile/Models/pendingRequest.dart';
import 'package:cleanup_mobile/Models/userModel.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:cleanup_mobile/apiServices/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authProvider.dart';
import 'package:http/http.dart' as http;

class TaskProviders with ChangeNotifier {
  List<Task> _mytasklist = [];
  List<Task> get mytasklist => _mytasklist;
  List<Taskk> _tasks = [];
  List<PendingRequestModel> _pending = [];
  List<PendingRequestModel> get pending => _pending;
  List<Taskk> get tasks => _tasks;
  List<AllUserModel> _allUser = [];
  List<AllUserModel> get allUser => _allUser;
  List<MyFriendsModel> _myfreinds = [];
  List<MyFriendsModel> get myfriends => _myfreinds;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController get nameController => _nameController;
  TextEditingController get locationController => _locationController;
  TextEditingController get discriptionController => _descriptionController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get countryController => _countryController;
  TextEditingController get cityController => _cityController;
  TextEditingController get areaController => _areaController;
  bool _isExercise = false;

  bool get isExercise => _isExercise;

  Future<void> getMyTaskList({
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiServices.getmytaskList);

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      // Make the GET request with headers
      final response = await http.get(url, headers: headers);

      var result = jsonDecode(response.body);
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (result['success'] == true) {
          // Map the tasks from the response to your list
          _mytasklist = (result['tasks'] as List)
              .map((taskData) => Task.fromJson(taskData))
              .toList();
        } else {
          // Handle error from the response
          _mytasklist = [];
          customToast(context: context, msg: result['message'], type: 0);
        }
      } else {
        // Handle server error
        _mytasklist = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      _mytasklist = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
      notifyListeners();
    }
  }

  Future<void> getallUsers({
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiServices.getallUser);

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      // Make the GET request with headers
      final response = await http.get(url, headers: headers);

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      log('accesstoken=====>>>${pref.getString(accessTokenKey).toString()}');
      if (response.statusCode == 200) {
        // Parse the response body as a list of user objects
        List<dynamic> userList = jsonDecode(response.body);

        _allUser = userList
            .map((userData) => AllUserModel.fromJson(userData))
            .toList();
        log('userlist response ====>>>>$_allUser');
        notifyListeners(); // Notify listeners if using Provider
      } else {
        // Handle server error
        _allUser = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      _allUser = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }

  Future<void> createTask({
    required BuildContext context,
    required String title,
    required String userid,
    required String location,
    required String description,
    File? beforeImage,
    File? afterImage,
  }) async {
    var url = Uri.parse(ApiServices.createTask);
    showLoaderDialog(context, 'Please wait...');

    var request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields['title'] = title;
    request.fields['location'] = location;
    request.fields['description'] = description;
    request.fields['user_id'] = userid;

    // Add image files
    if (beforeImage != null) {
      var beforeFile =
          await http.MultipartFile.fromPath('before', beforeImage.path);
      request.files.add(beforeFile);
    }

    if (afterImage != null) {
      var afterFile =
          await http.MultipartFile.fromPath('after', afterImage.path);
      request.files.add(afterFile);
    }

    // Add headers
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);
    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['access_token'] =
        ' ${pref.getString(accessTokenKey) ?? ''}';
    request.headers['Content-Type'] = 'multipart/form-data';
    log('accesstoken=====>>>${pref.getString(accessTokenKey).toString()}');
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Log the raw response
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          notifyListeners();
          commonToast(msg: result['message'], color: Colors.blue);
        } else {
          commonToast(msg: result['message'], color: Colors.red);
        }
      } else {
        print('Failed to create task. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        commonToast(msg: 'Failed to create task', color: Colors.red);
      }
    } catch (e) {
      print('Error: $e');
      commonToast(msg: 'An error occurred', color: Colors.red);
    } finally {
      navPop(context: context);
    }
  }

  Future<void> sendFriendRequest({
    required BuildContext context,
    required int receiverId,
  }) async {
    var url = Uri.parse(
        'https://webpristine.com/cleanup/public/api/auth/friend-request');

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken =
        pref.getString(accessTokenKey); // Ensure the key matches

    // Log the access token and receiverId
    log('Access Token: $accessToken');
    log('Receiver ID: $receiverId');

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    // Prepare the form data
    Map<String, String> body = {
      'receiver_id': receiverId.toString(),
    };

    try {
      // Log the body data
      log('Request Body: ${body.toString()}');

      // Make the POST request with headers and body
      final response = await http.post(url, headers: headers, body: body);

      // Log the response status and body
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          // Handle successful friend request
          customToast(context: context, msg: responseBody['message'], type: 1);
        } else {
          // Handle failed friend request
          customToast(
              context: context, msg: 'Failed to send friend request', type: 0);
        }
      } else {
        // Handle server error
        customToast(
            context: context,
            msg: 'Server error: ${response.statusCode}',
            type: 0);
      }
    } catch (e) {
      // Log and show error message
      log('Error: $e');
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }

  void customToast(
      {required BuildContext context, required String msg, required int type}) {
    // Your custom toast implementation
  }

  Future<void> getpendingRequest({
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiServices.pendingRequest);

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      // Make the GET request with headers
      final response = await http.get(url, headers: headers);

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      log('accesstoken=====>>>${pref.getString(accessTokenKey).toString()}');
      if (response.statusCode == 200) {
        // Parse the response body as a list of user objects
        List<dynamic> userList = jsonDecode(response.body);

        _pending = userList
            .map((userData) => PendingRequestModel.fromJson(userData))
            .toList();
        log('userpendinglist response ====>>>>$_allUser');
        notifyListeners(); // Notify listeners if using Provider
      } else {
        // Handle server error
        _pending = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      _pending = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }

  Future<void> acceptFriendRequest({
    required BuildContext context,
    required int requestId,
  }) async {
    var url = Uri.parse(
        'https://webpristine.com/cleanup/public/api/auth/friend-request/$requestId/accept');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          customToast(context: context, msg: responseBody['message'], type: 1);
          await getpendingRequest(context: context); // Refresh pending requests
        } else {
          customToast(
              context: context,
              msg: 'Failed to accept friend request',
              type: 0);
        }
      } else {
        customToast(
            context: context,
            msg: 'Server error: ${response.statusCode}',
            type: 0);
      }
    } catch (e) {
      log('Error: $e');
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }

  Future<void> declineFriendRequest({
    required BuildContext context,
    required int requestId,
  }) async {
    var url = Uri.parse(
        'https://webpristine.com/cleanup/public/api/auth/friend-request/$requestId/decline');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          customToast(context: context, msg: responseBody['message'], type: 1);
          await getpendingRequest(context: context); // Refresh pending requests
        } else {
          customToast(
              context: context,
              msg: 'Failed to decline friend request',
              type: 0);
        }
      } else {
        customToast(
            context: context,
            msg: 'Server error: ${response.statusCode}',
            type: 0);
      }
    } catch (e) {
      log('Error: $e');
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }

  Future<void> getmyfreindsList({
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiServices.myFreinds);

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      // Make the GET request with headers
      final response = await http.get(url, headers: headers);

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      log('accesstoken=====>>>${pref.getString(accessTokenKey).toString()}');
      if (response.statusCode == 200) {
        // Parse the response body as a list of user objects
        List<dynamic> userList = jsonDecode(response.body);

        _myfreinds = userList
            .map((userData) => MyFriendsModel.fromJson(userData))
            .toList();
        log('userlist response ====>>>>$_allUser');
        notifyListeners(); // Notify listeners if using Provider
      } else {
        // Handle server error
        _allUser = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      _allUser = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }
}
