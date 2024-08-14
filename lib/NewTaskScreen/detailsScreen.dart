import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/FriendslistScreen/taskfreindliat.dart';
import 'package:cleanup_mobile/Models/comingtaskModel.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/shareTask.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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

class DetailTaskScreen extends StatefulWidget {
  final int taskId;

  const DetailTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  Taskk? _task;
  ComingTaskModel? _comingtask;
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

    // Accept the task
    try {
      await taskProvider.fetchTaskDetails(context, taskId);

      // Navigate to ShareTaskScreen after task acceptance
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShareTask(),
        ),
      );
    } catch (error) {
      _showError('Failed to accept task');
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
        backgroundColor: AppColor.appbarColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _task != null
              ? _buildTaskDetails()
              : Center(child: Text('No task details available')),
    );
  }

  Widget _buildTaskDetails() {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              title: 'Task Title',
              content: _task!.title,
            ),
            SizedBox(height: 16),
            _buildDetailCard(
              title: 'Location',
              content: _task!.location,
            ),
            SizedBox(height: 16),
            _buildDetailCard(
              title: 'Description',
              content: _task!.description,
            ),
            SizedBox(height: 16),
            // TextButton(
            //     onPressed: () {
            //       _showShareOptionsBottomSheet(context);
            //     },
            //     child: Text('share task')),
            SizedBox(height: 16),
            _buildImageCard(
              label: 'Before Image',
              imageUrl: _task!.beforeImageUrl,
            ),
            SizedBox(height: 16),
            _buildImageCard(
              label: 'After Image',
              imageUrl: _task!.afterImageUrl,
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                navPush(
                  context: context,
                  action: FriendTaskScreen(taskid: widget.taskId.toString()),
                );
              },
              child: Container(
                height: 54,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: AppColor.rank1Color,
                ),
                child: const Center(
                  child: Text(
                    'Share Task',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({required String title, required String content}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard({required String label, required String imageUrl}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 8),
            imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                : Text(
                    'No image available',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
          ],
        ),
      ),
    );
  }

  void _showShareOptionsBottomSheet(BuildContext context) {
    final taskProviders = Provider.of<TaskProviders>(context, listen: false);
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row with centered clickable images
              Column(
                children: [
                  Text(
                    'Invite freinds',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navPush(
                              context: context,
                              action: FriendTaskScreen(
                                  taskid: widget.taskId.toString()));
                          // Handle first image tap
                          print('Image 1 clicked');
                        },
                        child: Image.asset('assets/images/image16.png'),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          // Handle second image tap
                          print('Image 2 clicked');
                        },
                        child: Image.asset('assets/images/image15.png'),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          // Handle third image tap
                          print('Image 3 clicked');
                        },
                        child: Image.asset('assets/images/image14.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.appbarColor,
      ),
    );
  }
}
