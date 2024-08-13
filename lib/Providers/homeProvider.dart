import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/FriendslistScreen/taskfreindliat.dart';
import 'package:cleanup_mobile/Models/comingtaskModel.dart';
import 'package:cleanup_mobile/Models/completetaskModel.dart';
import 'package:cleanup_mobile/Models/detailtaskModel.dart';
import 'package:cleanup_mobile/Models/myfriendsModel.dart';
import 'package:cleanup_mobile/Models/mytaskModel.dart';
import 'package:cleanup_mobile/Models/newtaskModel.dart';
import 'package:cleanup_mobile/Models/pendingRequest.dart';
import 'package:cleanup_mobile/Models/pendingtaskModel.dart';
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
  bool _isLoading = false; // Add this field

  bool get isLoading => _isLoading; // Getter for the loading state
  List<MyTask> _mytasklist = [];
  List<MyTask> get mytasklist => _mytasklist;
  List<MyTaskModel> _mytask = [];
  List<MyTaskModel> get mytask => _mytask;
  List<Taskk> _tasks = [];
  List<PendingRequestModel> _pending = [];
  List<PendingRequestModel> get pending => _pending;
  List<Taskk> get tasks => _tasks;
  List<AllUserModel> _allUser = [];
  List<AllUserModel> get allUser => _allUser;
  List<MyFriendsModel> _myfreinds = [];
  List<MyFriendsModel> get myfriends => _myfreinds;
  List<CompleteTaskModel> _mycompletes = [];
  List<CompleteTaskModel> get mycompletes => _mycompletes;
  List<ComingTaskModel> _comingTask = [];
  List<PendingTaskModel> _pendingTask = [];
  List<PendingTaskModel> get pendingTask => _pendingTask;
  List<ComingTaskModel> get comingTask => _comingTask;
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

  Future<void> getMyTaskList({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiServices.getmytaskList);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      //log('Response status: ${response.statusCode}');
      log('my task response : ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        if (result['success'] == true) {
          // Assuming 'tasks' is a list of task data
          _mytasklist = (result['tasks'] as List)
              .map((taskData) => MyTask.fromJson(taskData))
              .toList();
        } else {
          _mytasklist = [];
          customToast(context: context, msg: result['message'], type: 0);
        }
      } else {
        _mytasklist = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      _mytasklist = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> acceptTask(BuildContext context, String shareId) async {
    final String url = ApiServices.acceptTask(shareId);
    final String token = 'yourAccessToken'; // Replace with your actual token
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Successfully accepted the task
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task accepted successfully!')),
        );
      } else {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to accept task.')),
        );
      }
    } catch (e) {
      // Handle any errors
      print('Error accepting task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred.')),
      );
    }
  }

  Future<void> fetchIncomingTasks(String status) async {
    final url = 'https://your-api-url.com/api/auth/task/incoming-tasks';
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(accessTokenKey) ?? '';
    String userid = prefs.getString(userIdKey) ?? '';

    try {
      final response = await http.post(
        Uri.parse(ApiServices.incomingTask),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'status': status,
          'user_id': userid,
        },
      );

      // Log the full response for debugging
      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers}');
      log('incoming task response: ${response.body}');

      // Check if the response content type is JSON
      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        // Decode the JSON response
        List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

        // Convert the list of JSON objects to a list of ComingTaskModel
        _comingTask =
            jsonList.map((json) => ComingTaskModel.fromJson(json)).toList();

        log('Parsed coming tasks: $_comingTask');
      } else {
        log('Unexpected content type: ${response.headers['content-type']}');
        throw Exception(
            'Unexpected content type: ${response.headers['content-type']}');
      }
    } catch (e) {
      log('Error occurred: $e');
      _comingTask = [];
      // customToast(context: context, msg: 'An error occurred', type: 0);
    }

    notifyListeners();
  }

  Future<void> fetchPendingTasks(String status) async {
    final url = 'https://your-api-url.com/api/auth/task/incoming-tasks';
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(accessTokenKey) ?? '';
    String userid = prefs.getString(userIdKey) ?? '';

    try {
      final response = await http.post(
        Uri.parse(ApiServices.incomingTask),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'status': status,
          'user_id': userid,
        },
      );

      // Log the full response for debugging
      ////  log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers}');
      log('Response of pending/user/completed task: ${response.body}');

      // Check if the response content type is JSON
      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        // Decode the JSON response
        List<dynamic> jsonList = jsonDecode(response.body);

        // Convert the list of JSON objects to a list of ComingTaskModel
        _pendingTask =
            jsonList.map((json) => PendingTaskModel.fromJson(json)).toList();

        log('Parsed coming tasks: $_comingTask');
      } else {
        log('Unexpected content type: ${response.headers['content-type']}');
        throw Exception(
            'Unexpected content type: ${response.headers['content-type']}');
      }
    } catch (e) {
      log('Error occurred: $e');
      _comingTask = [];
      // customToast(context: context, msg: 'An error occurred', type: 0);
    }

    notifyListeners();
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
      log('AccessToken: ${accessToken ?? 'No Token'}');

      if (response.statusCode == 200) {
        // Parse the response body as a list of user objects
        List<dynamic> userList = jsonDecode(response.body);

        _allUser = userList
            .map((userData) => AllUserModel.fromJson(userData))
            .toList();
        log('User list response: $_allUser');
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

  Future<bool> createTask({
    required BuildContext context,
    required String title,
    required String userid,
    required String location,
    required String description,
    required String share_task_id,
    required String status,
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
    request.fields['share_task_id'] = share_task_id;
    request.fields['status'] = status;

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
    request.headers['access_token'] = accessToken ?? '';
    request.headers['Content-Type'] = 'multipart/form-data';
    log('accesstoken=====>>>${accessToken ?? ''}');

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('create task response ===>>>>: ${response.body}');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          // Extract task ID from the response
          final taskId = result['task']['id'];

          notifyListeners();
          commonToast(msg: result['message'], color: Colors.blue);
          void _showShareOptionsBottomSheet(
            BuildContext context,
          ) {
            final taskProviders =
                Provider.of<TaskProviders>(context, listen: false);
          }

          // Navigate to FriendListScreen with the task ID
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    FriendTaskScreen(taskid: taskId.toString()),
              ),
            );
          });

          return true; // Task created successfully
        } else {
          commonToast(msg: result['message'], color: Colors.red);
          return false; // Task creation failed
        }
      } else {
        print('Failed to create task. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        commonToast(msg: 'Failed to create task', color: Colors.red);
        return false; // Task creation failed
      }
    } catch (e) {
      print('Error: $e');
      commonToast(msg: 'An error occurred', color: Colors.red);
      return false; // Task creation failed
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

  Future<void> shareTask(
    List<String> selectedFriends, {
    required BuildContext context,
    required String taskId,
    required List<String> friendIds,
  }) async {
    var url = Uri.parse(
        'https://webpristine.com/cleanup/public/api/auth/task/share/$taskId');

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    // Prepare the request body
    Map<String, dynamic> body = {
      'ids': friendIds,
    };

    try {
      // Make the POST request with headers and body
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      // Log the response status and body
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      log('rsponse of accesstoken===>>>$accessToken');
      log('response of taskid==>>>$taskId');
      log('response of IDs==>>>$friendIds');
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          customToast(context: context, msg: responseBody['message'], type: 1);
          // You may want to update the UI or state after successful sharing
        } else {
          customToast(context: context, msg: responseBody['message'], type: 0);
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

  Future<bool> sharecreateTask({
    required BuildContext context,
    required String title,
    required String userid,
    required String location,
    required String description,
    required String sharetaskID,
    required String status,
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
    request.fields['share_task_id'] = sharetaskID;
    request.fields['status'] = status;

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
    request.headers['access_token'] = accessToken ?? '';
    request.headers['Content-Type'] = 'multipart/form-data';
    log('accesstoken=====>>>${accessToken ?? ''}');
    log('response of sharetaskid====>>>>$sharetaskID');

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Log the raw response
      log('Response status: ${response.statusCode}');
      log('share task response : ${response.body}');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          notifyListeners();
          commonToast(msg: result['message'], color: Colors.blue);
          return true; // Task created successfully
        } else {
          commonToast(msg: result['message'], color: Colors.red);
          return false; // Task creation failed
        }
      } else {
        print('Failed to create task. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        commonToast(msg: 'Failed to create task', color: Colors.red);
        return false; // Task creation failed
      }
    } catch (e) {
      print('Error: $e');
      commonToast(msg: 'An error occurred', color: Colors.red);
      return false; // Task creation failed
    } finally {
      navPop(context: context);
    }
  }

  Future<void> fetchTaskDetails(BuildContext context, String taskId) async {
    final String url = '${ApiServices.baseUrl}/api/auth/task/accept/$taskId';

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);
    log('task id response ===>>>$taskId');
    if (accessToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authorization token is missing.')),
      );
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Process the response if needed and fetch task details
        final taskDetails = json.decode(response.body);
        log('response of accept task===>>>$taskDetails'); // Adjust according to your response structure
        // Use this data as needed or notify listeners
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task accepted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to accept task. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error accepting task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred.')),
      );
    }
  }
}
