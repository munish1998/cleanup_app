import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Models/sharetaskModel.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'dart:developer';

class SharTaskDetaill extends StatefulWidget {
  final ShareTaskModel task;
  final String taskid;

  SharTaskDetaill({Key? key, required this.task, required this.taskid})
      : super(key: key);

  @override
  _SharTaskDetaillState createState() => _SharTaskDetaillState();
}

class _SharTaskDetaillState extends State<SharTaskDetaill> {
  @override
  Widget build(BuildContext context) {
    final ShareTask? taskDetails = widget.task.shareTask;
    final ShareTaskModel? sharerDetails = widget.task;
    final taskProvider = Provider.of<TaskProviders>(context);

    // Log task id for debugging
    log('Task ID: ${widget.taskid}');

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
                  taskDetails?.title ?? 'Title',
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
                      sharerDetails?.sharer?.image != null
                          ? '${sharerDetails!.sharer!.baseUrl}${sharerDetails.sharer!.image}'
                          : 'https://via.placeholder.com/150',
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    sharerDetails?.sharer?.name ?? 'Username',
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
                  // Add Accept and Decline Buttons here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
