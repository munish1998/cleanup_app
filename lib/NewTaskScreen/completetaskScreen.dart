import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

class CompleteTaskScreen extends StatefulWidget {
  // final String taskid; // Task ID passed to this screen
  final int taskId;
  CompleteTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  String _status = 'completed'; // Default status
  Taskk? _task;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .fetchIncomingTasks(_status);
    });
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

  Future<void> _acceptTaskAndNavigate(String taskId) async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    // Accept the task
    await taskProvider.fetchTaskDetails(
        context, taskProvider.comingTask.first.sharerId.toString());

    // Navigate to details screen after task acceptance
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTaskScreen(
            taskId:
                int.tryParse(taskProvider.mytasklist.first.id.toString()) ?? 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('Complete Task'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.comingTask.isEmpty) {
            return Center(child: Text('No complete task'));
          }

          return ListView.builder(
            itemCount: taskProvider.comingTask.length,
            itemBuilder: (context, index) {
              final task = taskProvider.comingTask[index];

              final profileImageUrl = task.user?.id;
              final imageProvider = (profileImageUrl == null)
                  ? AssetImage('assets/images/image27.png') as ImageProvider
                  : NetworkImage(profileImageUrl.toString()) as ImageProvider;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.grey[300],
                  ),
                  title: Text(task.user?.name ?? 'No Title'),
                  subtitle: Text(task.user?.email ?? 'No Description'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _fetchTaskDetails();
                      // navPush(
                      //     context: context,
                      //     action: DetailTaskScreen(taskId: widget.taskId));
                      // _acceptTaskAndNavigate(taskProvider.comingTask.first.sharerId.toString()
                      // ); // Ensure task.id is the correct type
                    },
                    child: Text('Accept'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
