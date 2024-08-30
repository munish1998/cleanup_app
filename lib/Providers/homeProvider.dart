import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/FriendslistScreen/taskfreindliat.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Models/NotificationModel.dart';
import 'package:cleanup_mobile/Models/RequestSendModel.dart';
import 'package:cleanup_mobile/Models/comingtaskModel.dart';
import 'package:cleanup_mobile/Models/completetaskModel.dart';
import 'package:cleanup_mobile/Models/detailtaskModel.dart';
import 'package:cleanup_mobile/Models/myfriendsModel.dart';
import 'package:cleanup_mobile/Models/mytaskModel.dart';
import 'package:cleanup_mobile/Models/newtaskModel.dart';
import 'package:cleanup_mobile/Models/pendingRequest.dart';
import 'package:cleanup_mobile/Models/pendingtaskModel.dart';
import 'package:cleanup_mobile/Models/sharetaskModel.dart';
import 'package:cleanup_mobile/Models/userModel.dart';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:cleanup_mobile/apiServices/apiServices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authProvider.dart';
import 'package:http/http.dart' as http;

class TaskProviders with ChangeNotifier {
  bool _isLoading = false; // Add this field
  bool isloading = false;
  bool get isLoading => _isLoading;
  // MyTaskModel? myTaskModel; // Getter for the loading state
  List<MyTask> _mytasklist = [];
  List<MyTask> get mytasklist => _mytasklist;
  List<ShareTaskModel> _sharetasklist = [];
  List<ShareTaskModel> get sharetasklist => _sharetasklist;
  List<MyTaskModel> _mytask = [];
  List<MyTaskModel> get mytask => _mytask;
  List<Taskk> _tasks = [];
  List<PendingRequestModel> _pending = [];
  List<PendingRequestModel> get pending => _pending;
  List<Taskk> get tasks => _tasks;
  List<AllUserModel> _allUser = [];
  List<AllUserModel> get allUser => _allUser;
  List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;
  List<RequestSendModel> _requestsendlist = [];
  List<RequestSendModel> get requestsendlist => _requestsendlist;
  List<MyFriendsModel> _myfreinds = [];
  List<MyFriendsModel> get myfriends => _myfreinds;
  List<CompleteTaskModel> _mycompletes = [];
  List<CompleteTaskModel> get mycompletes => _mycompletes;
  List<ComingTaskModel> _comingTask = [];
  List<ComingTaskModel> get comingTask => _comingTask;
  List<PendingTaskModel> _pendingTask = [];
  List<PendingTaskModel> get pendingTask => _pendingTask;

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
  MyTaskModel? _myTaskModel;
  String _token = '';

  String get token => _token;

  MyTaskModel? get myTaskModel => _myTaskModel;
  bool get isExercise => _isExercise;

  int _taskCount = 0;
  int get taskCount => _taskCount;

  Future<void> getsharetaskList({
    required BuildContext context,
    required String taskId,
  }) async {
    final url = Uri.parse('${ApiServices.getsharetaskList}?task_id=$taskId');

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      log('Response of share task: ${response.body}');
      log('Access token: $accessToken');

      if (response.statusCode == 200) {
        final List<dynamic> taskList = jsonDecode(response.body);

        _sharetasklist = taskList
            .map((taskData) => ShareTaskModel.fromJson(taskData))
            .toList();
        notifyListeners(); // Notify listeners if using Provider
      } else {
        _sharetasklist = [];
        customToast(
            context: context,
            msg: 'Server error: ${response.statusCode}',
            type: 0);
      }
    } catch (e) {
      log('Error: $e');
      _sharetasklist = [];
      customToast(context: context, msg: 'An error occurred: $e', type: 0);
    }
  }

  Future<void> fetchCompleteTasks(String status) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        ApiServices.incomingTask); // Update with your actual endpoint if needed
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(accessTokenKey) ?? '';
    final userId = prefs.getString(userIdKey) ?? '';

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'status': status,
          'user_id': userId,
        },
      );

      log('Response of complete task: ${response.body}');

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') ==
            true) {
          List<dynamic> jsonList = jsonDecode(response.body);
          _mycompletes =
              jsonList.map((json) => CompleteTaskModel.fromJson(json)).toList();
          log('Parsed complete tasks: $_mycompletes');
        } else {
          log('Unexpected content type: ${response.headers['content-type']}');
          throw Exception(
              'Unexpected content type: ${response.headers['content-type']}');
        }
      } else {
        log('Failed to load tasks with status code: ${response.statusCode}');
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      log('Error occurred: $e');
      _mycompletes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> shareTask(
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

      log('Response share task: ${response.body}');
      log('Response of accessToken: $accessToken');
      log('Response of taskId: $taskId');
      log('Response of IDs: $friendIds');

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          // Return true to indicate success
          return true;
        } else {
          // Handle the case where the task has already been shared with the friend
          if (responseBody['error'] != null &&
              responseBody['error'].contains('already shared this task')) {
            customToast(context: context, msg: responseBody['error'], type: 0);
          } else {
            customToast(
                context: context, msg: responseBody['message'], type: 0);
          }
          // Return false to indicate failure
          return false;
        }
      } else {
        customToast(
            context: context,
            msg: 'Server error: ${response.statusCode}',
            type: 0);
        // Return false to indicate failure
        return false;
      }
    } catch (e) {
      log('Error: $e');
      customToast(context: context, msg: 'An error occurred', type: 0);
      // Return false to indicate failure
      return false;
    }
  }

  Future<void> fetchNotifications(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiServices.getNotification);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final notificationModel = NotificationModel.fromJson(responseBody);
        _notifications = notificationModel.notifications ?? [];
        log('Fetched notifications: $responseBody');
      } else {
        log('Error: Server returned status ${response.statusCode}');
        _notifications = [];
      }
    } catch (e) {
      log('Error: $e');
      _notifications = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeFriend(String userId) {
    myfriends.removeWhere((friend) => friend.id.toString() == userId);
    notifyListeners(); // Notify listeners to update the UI
  }

  Future<void> fetchTaskCount(String taskId) async {
    final String url =
        '${ApiServices.baseUrl}/api/auth/task/shared-count/$taskId';

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    if (accessToken == null) {
      throw Exception('Authorization token is missing.');
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _taskCount = responseData['count'];
        log('task count response ===>>>$_taskCount'); // Extract the count from the response
        notifyListeners(); // Notify listeners to update the UI
      } else {
        throw Exception('Failed to fetch task count.');
      }
    } catch (e) {
      print('Error fetching task count: $e');
      throw Exception('An error occurred while fetching the task count.');
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

  void getToken() async {
    _token = (await FirebaseMessaging.instance.getToken())!;
    log('device token response ===>>>>$_token');
  }

  Future<void> fetchTaskDetails(
      BuildContext context, String shareId, String status) async {
    final String url =
        '${ApiServices.baseUrl}/api/auth/task/accept?shareid=$shareId&status=$status';

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    log('Share ID: $shareId, Status: $status');

    // Check if the access token is missing
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
        final taskDetails = json.decode(response.body);
        log('Response from accept task: $taskDetails');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task accepted successfully!')),
        );

        // Update the state or notify listeners if needed
        // For example, you might want to refresh the task list or update the UI
        // notifyListeners(); // If using a provider
      } else {
        // Handle non-200 status codes
        log('Failed to update task. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to update task. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Log the error and show a user-friendly message
      log('Error updating task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> declinetaskRequest(
      BuildContext context, String shareId, String status) async {
    final String url =
        '${ApiServices.baseUrl}/api/auth/task/accept?shareid=$shareId&status=$status';

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    log('Share ID: $shareId, Status: $status');

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
        final taskDetails = json.decode(response.body);
        log('Response from accept task: $taskDetails');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Decline Task!')),
        );

        // You may want to update the state or notify listeners here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to update task. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      log('Error updating task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> getrequestsendList({
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiServices.getrequestsendList);

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

        _requestsendlist = userList
            .map((userData) => RequestSendModel.fromJson(userData))
            .toList();
        log('requestsendlist response ====>>>>$_requestsendlist');
        notifyListeners(); // Notify listeners if using Provider
      } else {
        // Handle server error
        _requestsendlist = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      _requestsendlist = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
    }
  }

  Future<void> fetchTasks({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiServices.getmytaskList);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    }; // Replace with your API URL

    try {
      final response = await http.get(url, headers: headers);

      //log('Response status: ${response.statusCode}');
      log('my task response : ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        _myTaskModel = MyTaskModel.fromJson(result);
        log('fetch task response ====>>>>$_myTaskModel');
      } else {
        // _mytasklist = [];
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      //  _mytasklist = [];
      customToast(context: context, msg: 'An error occurred', type: 0);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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
      log('Error occurredddd: $e');
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
      // log('Response headers: ${response.headers}');
      log('Response of pending task: ${response.body}');

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
      log('Error occurreddddddd: $e');
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
      // log('Response status: ${response.statusCode}');
      log('request pending list response ===>>>: ${response.body}');

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

      //  log('Response status: ${response.statusCode}');
      log('Response of myfreindlist: ${response.body}');
      log('accesstoken=====>>>${pref.getString(accessTokenKey).toString()}');
      if (response.statusCode == 200) {
        // Parse the response body as a list of user objects
        List<dynamic> userList = jsonDecode(response.body);

        _myfreinds = userList
            .map((userData) => MyFriendsModel.fromJson(userData))
            .toList();
        log('userlist response ====>>>>$_myfreinds');
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
}
