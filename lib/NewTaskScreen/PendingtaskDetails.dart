import 'package:cleanup_mobile/Models/pendingtaskModel.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/pendingshareTask.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/shareTask.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingTaskDetailScreen extends StatefulWidget {
  final PendingTaskModel task;
  final String taskid;

  PendingTaskDetailScreen({Key? key, required this.task, required this.taskid})
      : super(key: key);

  @override
  _PendingTaskDetailScreenState createState() =>
      _PendingTaskDetailScreenState();
}

class _PendingTaskDetailScreenState extends State<PendingTaskDetailScreen> {
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Task? taskDetails = widget.task.task;
    final PendingTaskModel? sharerDetails = widget.task;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('Task Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColor.rank1Color,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              child: Center(
                child: Text(
                  taskDetails!.title.toString(),
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
                      '${sharerDetails!.sharer!.baseUrl}${sharerDetails.sharer!.image}' ??
                          'https://via.placeholder.com/150',
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    sharerDetails?.sharer!.name ?? 'Username',
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
                      taskDetails?.title ?? 'Title',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      taskDetails?.description ?? 'Description',
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
                          child: taskDetails?.before != null
                              ? Image.network(
                                  '${taskDetails?.baseUrl}${taskDetails?.before}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/default_image.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text('Before',
                                      textAlign: TextAlign.center)),
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
                          child: taskDetails?.after != null
                              ? Image.network(
                                  '${taskDetails?.baseUrl}${taskDetails?.after}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/default_image.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text('After',
                                      textAlign: TextAlign.center)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Row for Accept and Decline Buttons
                  InkWell(
                    onTap: () {
                      navPush(
                          context: context,
                          action: PendingShareTask(
                            tasktitle: taskDetails.title.toString(),
                          ));
                      //   _acceptTaskAndNavigate(widget.taskid);
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.rank1Color),
                      child: const Center(
                        child: Text(
                          'Share Task',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
