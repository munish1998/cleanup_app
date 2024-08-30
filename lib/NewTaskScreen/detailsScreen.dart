import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/Models/sharetaskModel.dart';
import 'package:cleanup_mobile/NewTaskScreen/taskCompleted.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/FriendslistScreen/taskfreindliat.dart';

class User {
  int? id;
  String? username;
  String? name;
  String? email;
  String? mobile;
  String? dob;
  String? image;
  String? bgimage;
  String? baseUrl;
  String? location;
  int? terms;
  Null? socialSignup;
  int? isAdmin;
  int? isActive;
  Null? emailVerifiedAt;
  String? updatedAt;
  String? createdAt;

  User(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.mobile,
      this.dob,
      this.image,
      this.bgimage,
      this.baseUrl,
      this.location,
      this.terms,
      this.socialSignup,
      this.isAdmin,
      this.isActive,
      this.emailVerifiedAt,
      this.updatedAt,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    image = json['image'];
    bgimage = json['bgimage'];
    baseUrl = json['base_url'];
    location = json['location'];
    terms = json['terms'];
    socialSignup = json['social_signup'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    emailVerifiedAt = json['email_verified_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['bgimage'] = this.bgimage;
    data['base_url'] = this.baseUrl;
    data['location'] = this.location;
    data['terms'] = this.terms;
    data['social_signup'] = this.socialSignup;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
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
  List<ShareTaskModel> _shareTaskList = [];

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
    _fetchShareTaskList(); // Fetch the shared task list
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

  Future<void> _fetchShareTaskList() async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);
    await taskProvider.getsharetaskList(
      context: context,
      taskId: widget.taskId.toString(),
    );
    setState(() {
      _shareTaskList = taskProvider.sharetasklist;
    });
    log('Shared Task List: ${_shareTaskList.length}');
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProviders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: AppColor.rank1Color,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _task != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Existing task details UI
                      _buildTaskDetails(),

                      // New section for shared users
                      _buildSharedUsersSection(),
                    ],
                  ),
                )
              : Center(child: Text('No task details available')),
    );
  }

  Widget _buildTaskDetails() {
    return Column(
      children: [
        Container(
          color: AppColor.rank1Color,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 6,
          child: Center(
            child: Text(
              _task!.title,
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
                backgroundImage: (_task!.user.image != null &&
                        _task!.user.image!.isNotEmpty)
                    ? NetworkImage(
                        '${_task!.user.baseUrl.toString()}${_task!.user.image.toString()}',
                      )
                    : AssetImage('assets/images/image30.png') as ImageProvider,
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSharedUsersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Shared Users',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _shareTaskList.length,
          itemBuilder: (context, index) {
            final shareTask = _shareTaskList[index];
            final taskProvider =
                Provider.of<TaskProviders>(context, listen: false);

            // Check if user and image details are available
            final imageUrl = shareTask.user?.image;
            final imageToShow = (imageUrl != null && imageUrl.isNotEmpty)
                ? NetworkImage('${shareTask.user?.baseUrl}$imageUrl')
                : AssetImage('assets/images/image30.png') as ImageProvider;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: imageToShow,
              ),
              title: Text(shareTask.user?.email ?? 'No email'),
              subtitle: Text(shareTask.status ?? 'No status'),
              trailing: InkWell(
                onTap: () {
                  switch (shareTask.status?.toLowerCase()) {
                    case 'new':
                      // Handle 'new' status if needed
                      break;
                    case 'pending':
                      // Handle 'pending' status if needed
                      break;
                    case 'completed':
                      // Ensure `widget.taskId` is defined in your widget state
                      log('task response ==>>>${shareTask.taskId.toString()}');
                      log('task response ==>>>${widget.taskId}');
                      navPush(
                          context: context,
                          action: SharTaskDetaill(
                              task: shareTask,
                              taskid: shareTask.taskId.toString()));

                      break;
                    default:
                      _showError('Unknown status');
                  }
                },
                child: getStatusIcon(shareTask.status ?? 'Unknown'),
              ),
            );
          },
        ),

        _buildShareTaskButton(), // Add the Share Task button based on conditions
      ],
    );
  }

  Widget _buildShareTaskButton() {
    // Check if the shared user count is less than 3
    if (_shareTaskList.length < 3) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              navPush(
                  context: context,
                  action: FriendTaskScreen(taskid: widget.taskId.toString()));
            },
            child: Text('Share Task'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.rank1Color, // Button color
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      // If the shared user count is 3 or more, do not show the Share Task button
      return Container();
    }
  }

  Widget _buildImageComparison({
    required String beforeImageUrl,
    required String afterImageUrl,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildImageTile(beforeImageUrl, 'Before'),
        _buildImageTile(afterImageUrl, 'After'),
      ],
    );
  }

  Widget _buildImageTile(String imageUrl, String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
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
          SizedBox(height: 8.0),
          Text(label),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _logImageUrls() {
    log('Before Image URL: ${_task?.beforeImageUrl}');
    log('After Image URL: ${_task?.afterImageUrl}');
  }

  Icon getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Icon(Icons.fiber_new, color: Colors.green);
      case 'pending':
        return Icon(Icons.hourglass_empty, color: Colors.orange);
      case 'completed':
        return Icon(Icons.check_circle, color: Colors.blue);
      default:
        return Icon(Icons.error, color: Colors.red);
    }
  }
}
