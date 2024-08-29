import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/NewTaskScreen/completesharetaskdetails.dart';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/sharetaskdetailScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'https://webpristine.com/cleanup/public/';

class CompleteTaskScreen extends StatefulWidget {
  // final String taskid; // Task ID passed to this screen

  CompleteTaskScreen({Key? key}) : super(key: key);

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
          .fetchCompleteTasks(_status);
    });
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
        backgroundColor: AppColor.rank1Color,
        title: Text('Complete Task'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.mycompletes.isEmpty) {
            return Center(child: Text('No complete task'));
          }

          return ListView.builder(
            itemCount: taskProvider.mycompletes.length,
            itemBuilder: (context, index) {
              final task = taskProvider.mycompletes[index];

              final profileImageUrl =
                  '${task.user!.baseUrl}${task.sharer!.image}';
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
                  title: Text(task.sharer?.name ?? 'No Title'),
                  subtitle: Text(task.sharer?.email ?? 'No Description'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      log('task response ===>>>$task');
                      log('taskId response ===>>>${task.id.toString()}');
                      navPush(
                          context: context,
                          action: CompleteSharTaskDetail(
                            task: task,
                            taskid: task.id.toString(),
                          ));
                      //  _fetchTaskDetails();
                      // navPush(
                      //     context: context,
                      //     action: DetailTaskScreen(taskId: widget.taskId));
                      // _acceptTaskAndNavigate(taskProvider.comingTask.first.sharerId.toString()
                      // ); // Ensure task.id is the correct type
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
