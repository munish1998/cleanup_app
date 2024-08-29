import 'package:cleanup_mobile/Models/sharetaskModel.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class CompleteSharTaskDetails extends StatefulWidget {
  final ShareTaskModel task;
  final String taskid;

  CompleteSharTaskDetails({Key? key, required this.task, required this.taskid})
      : super(key: key);

  @override
  _CompleteSharTaskDetailsState createState() =>
      _CompleteSharTaskDetailsState();
}

class _CompleteSharTaskDetailsState extends State<CompleteSharTaskDetails> {
  @override
  Widget build(BuildContext context) {
    final taskDetails = widget.task.task;
    final sharerDetails = widget.task.sharer;

    // Logging the task and sharer details
    debugPrint('Task Details: ${taskDetails.toString()}');
    debugPrint('Sharer Details: ${sharerDetails.toString()}');

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
                  taskDetails?.title ?? 'No Title',
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
                      sharerDetails?.baseUrl != null &&
                              sharerDetails?.image != null
                          ? '${sharerDetails?.baseUrl}${sharerDetails?.image}'
                          : 'https://via.placeholder.com/150',
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    sharerDetails?.name ?? 'Username',
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
                      sharerDetails?.location ?? 'No Location',
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
                      taskDetails?.description ?? 'No Description',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
