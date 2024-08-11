import 'dart:developer';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingTaskkScreen extends StatefulWidget {
  final String taskid; // Task ID passed to this screen

  PendingTaskkScreen({Key? key, required this.taskid}) : super(key: key);

  @override
  State<PendingTaskkScreen> createState() => _PendingTaskkScreenState();
}

class _PendingTaskkScreenState extends State<PendingTaskkScreen> {
  String _status = 'pending'; // Default status

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .fetchPendingTasks(_status);
    });
  }

  Future<void> _acceptTaskAndNavigate(String taskId) async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    // Accept the task
    await taskProvider.fetchTaskDetails(context, taskId);

    // Navigate to details screen after task acceptance
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailTaskScreen(taskId: int.tryParse(taskId) ?? 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('pending Task'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.pendingTask.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: taskProvider.pendingTask.length,
            itemBuilder: (context, index) {
              final task = taskProvider.pendingTask[index];

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
                      _acceptTaskAndNavigate(task.id
                          .toString()); // Ensure task.id is the correct type
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
