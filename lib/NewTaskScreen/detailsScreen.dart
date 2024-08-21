import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/FriendslistScreen/taskfreindliat.dart';
import 'package:cleanup_mobile/Models/comingtaskModel.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/shareTask.dart';

class User {
  final int id;
  final String username;
  final String name;
  final String email;
  final String mobile;
  final String location;
  final int terms;
  final int isAdmin;
  final int isActive;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.mobile,
    required this.location,
    required this.terms,
    required this.isAdmin,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      location: json['location'],
      terms: json['terms'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
    );
  }
}

class Taskk {
  final int id;
  final int userId;
  final String location;
  final String title;
  final String description;
  final String beforeImageUrl;
  final String afterImageUrl;
  final String baseUrl;
  final String status;
  final String createdAt;
  final String updatedAt;
  final User user;

  Taskk({
    required this.id,
    required this.userId,
    required this.location,
    required this.title,
    required this.description,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.baseUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Taskk.fromJson(Map<String, dynamic> json) {
    return Taskk(
      id: json['id'],
      userId: json['user_id'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      beforeImageUrl: '${json['base_url']}${json['before']}',
      afterImageUrl: '${json['base_url']}${json['after']}',
      baseUrl: json['base_url'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}

const String baseUrl = 'https://webpristine.com/cleanup/public/';

class DetailTaskScreen extends StatefulWidget {
  final int taskId;

  const DetailTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  Taskk? _task;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  Future<void> _fetchTaskDetails() async {
    final url = Uri.parse('${baseUrl}api/auth/task/view-task/${widget.taskId}');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    if (accessToken == null) {
      _showError('Access token not found. Please log in again.');
      return;
    }

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          setState(() {
            _task = Taskk.fromJson(result['task']);
            _isLoading = false;
            _logImageUrls();
          });
        } else {
          _showError(result['message'] ?? 'Failed to fetch task details');
        }
      } else {
        _showError('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showError('An error occurred');
      log('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _acceptTaskAndNavigate(String taskId) async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    try {
      await taskProvider.fetchTaskDetails(context, taskId, 'pending');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShareTask(
            tasktitle: taskProvider.comingTask.first.task!.title.toString(),
          ),
        ),
      );
    } catch (error) {
      _showError('Failed to accept task');
    }
  }

  Future<void> _declineTaskAndNavigate(String taskId) async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    try {
      await taskProvider.declinetaskRequest(context, taskId, 'cancelled');

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ShareTask(),
      //   ),
      // );
    } catch (error) {
      _showError('Failed to decline task');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _logImageUrls() {
    if (_task != null) {
      log('Before Image URL: ${_task!.beforeImageUrl}');
      log('After Image URL: ${_task!.afterImageUrl}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: AppColor.rank1Color,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _task != null
              ? _buildTaskDetails()
              : Center(child: Text('No task details available')),
    );
  }

  Widget _buildTaskDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: AppColor.rank1Color,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
            child: Center(
              child: Text(
                'My Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    _task?.user.username ?? 'https://via.placeholder.com/150',
                  ),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(height: 16.0),
                Text(
                  _task?.user.name ?? 'Username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _task?.title ?? 'Title',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _task?.description ?? 'Description',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: _task?.beforeImageUrl.isNotEmpty == true
                            ? Image.network(
                                _task!.beforeImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/default_image.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/default_image.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: _task?.afterImageUrl.isNotEmpty == true
                            ? Image.network(
                                _task!.afterImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/default_image.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/default_image.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
