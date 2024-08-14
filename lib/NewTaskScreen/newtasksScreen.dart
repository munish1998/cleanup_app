import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/Models/comingtaskModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// Import your models
import 'package:cleanup_mobile/NewTaskScreen/sharetaskdetailScreen.dart'; // Import the detail screen
import 'package:cleanup_mobile/Providers/homeProvider.dart'; // Import your provider
import 'package:cleanup_mobile/Utils/AppConstant.dart'; // Import your constants

const String baseUrl = 'https://webpristine.com/cleanup/public/';

class UpcomingTaskScreen extends StatefulWidget {
  final int taskId; // Task ID passed to this screen

  UpcomingTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  State<UpcomingTaskScreen> createState() => _UpcomingTaskScreenState();
}

class _UpcomingTaskScreenState extends State<UpcomingTaskScreen> {
  String _status = 'new'; // Default status
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .fetchIncomingTasks(_status);
    });
  }

  Future<void> _acceptTaskAndNavigate(ComingTaskModel task) async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    // Accept the task
    await taskProvider.fetchTaskDetails(context, task.sharerId.toString());

    // Navigate to details screen after task acceptance
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharTaskDetail(
          task: task,
          taskid: task.id.toString(),
        ), // Pass the selected task
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color, // Your theme color
        title: Text('New Tasks'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.comingTask.isEmpty) {
            return Center(child: Text('No new tasks'));
          }

          return ListView.builder(
            itemCount: taskProvider.comingTask.length,
            itemBuilder: (context, index) {
              final task = taskProvider.comingTask[index];

              final profileImageUrl = task.user?.id;
              final imageProvider = (profileImageUrl == null)
                  ? AssetImage('assets/images/image27.png') as ImageProvider
                  : NetworkImage('${task.sharer!.baseUrl}${task.sharer!.image}')
                      as ImageProvider;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.grey[300],
                  ),
                  title: Text(task.sharer?.username ?? 'No Title'),
                  subtitle: Text(task.sharer?.email ?? 'No Description'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SharTaskDetail(
                            taskid: task.id.toString(),
                            task: task,
                          ), // Pass the selected task
                        ),
                      );
                      //  _acceptTaskAndNavigate(task); // Pass the task object
                    },
                    child: Text('View'),
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
