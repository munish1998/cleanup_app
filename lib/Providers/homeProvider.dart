import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/Models/detailtaskModel.dart';
import 'package:cleanup_mobile/Models/mytaskModel.dart';
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

  List<Taskk> get tasks => _tasks;

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

  Future<void> getMyTaskListt({
    required BuildContext context,
    required Map<String, String> data,
  }) async {
    var url = Uri.parse(ApiServices.getmytaskList);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString(accessTokenKey);

      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final response = await http.get(url,
          headers: headers); // Use GET if the endpoint expects it

      log('Response body: ${response.body}');
      log('Response status code: ${response.statusCode}');
      log('Response content-type: ${response.headers['content-type']}');

      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        var result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (result['code'] == 200) {
            log('MyTaskList response: $result');
            var list = result['tasks'] as List;
            _mytasklist = list.map((e) => Task.fromJson(e)).toList();
            notifyListeners();
          } else if (result['code'] == 401) {
            Provider.of<AuthProvider>(context, listen: false).logout(context);
          } else {
            log('Error code from server: ${result['code']}');
            notifyListeners();
          }
        } else {
          log('Error: Status code ${response.statusCode}');
          notifyListeners();
        }
      } else {
        log('Unexpected content-type: ${response.headers['content-type']}');
        notifyListeners();
      }
    } catch (e) {
      log('Exception occurred: $e');
      notifyListeners();
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
          commonToast(msg: result['message'], color: Colors.green);
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

  Future<void> getMyTaskListtt({
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
          _tasks = (result['tasks'] as List)
              .map((taskData) => Taskk.fromJson(taskData))
              .toList();
        } else {
          // Handle error from the response
          _tasks = [];
          customToast(context: context, msg: result['message'], type: 0);
        }
      } else {
        // Handle server error
        _tasks = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      _tasks = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
      notifyListeners();
    }
  }
}
