import 'dart:developer';
import 'package:cleanup_mobile/NewTaskScreen/PendingtaskDetails.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingTaskkScreen extends StatefulWidget {
  // final int taskid; // Task ID passed to this screen

  PendingTaskkScreen({
    Key? key,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('Pending Task'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.pendingTask.isEmpty) {
            return Center(child: Text('No pending tasks'));
          }

          return ListView.builder(
            itemCount: taskProvider.pendingTask.length,
            itemBuilder: (context, index) {
              final task = taskProvider.pendingTask[index];

              final profileImageUrl = task.sharer!.image;
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
                  title: Text(task.sharer!.name ?? 'No Title'),
                  subtitle: Text(task.sharer?.email ?? 'No Description'),
                  trailing: InkWell(
                    onTap: () {
                      final selectedTask = taskProvider.pendingTask[index];
                      log('pending task id response ===>>>$task');
                      log('pending taskID ===>>>$task.id.toString()');
                      navPush(
                          context: context,
                          action: PendingTaskDetailScreen(
                            task: task,
                            taskid: task.id.toString(),
                          ));
                      //  navPush(context: context, action: SharTaskDetail( taskid: '', task: selectedTask,));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SharTaskDetail(

                      //              ,),
                      //   ),
                      // );
                      // _acceptTaskAndNavigate(task.id
                      //     .toString()); // Ensure task.id is the correct type
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
