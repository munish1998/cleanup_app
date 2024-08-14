import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/shareTask.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:cleanup_mobile/Models/comingtaskModel.dart';
import 'package:provider/provider.dart'; // Adjust the import as needed

class SharTaskDetail extends StatefulWidget {
  final ComingTaskModel task;
  final String taskid;

  SharTaskDetail({Key? key, required this.task, required this.taskid})
      : super(key: key);

  @override
  _SharTaskDetailState createState() => _SharTaskDetailState();
}

class _SharTaskDetailState extends State<SharTaskDetail> {
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

  @override
  Widget build(BuildContext context) {
    final Task? taskDetails = widget.task.task; // Task details
    final ComingTaskModel? sharerDetails = widget.task; // Sharer details

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color, // Adjust the color as needed
        title: Text('Task Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Blue container at the top
            Container(
              color: AppColor.rank1Color,
              width: double.infinity,
              height: MediaQuery.of(context).size.height /
                  6, // Adjust height as needed
              child: Center(
                child: Text(
                  'My Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Container for CircleAvatar, username, and rank
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // CircleAvatar at the top center
                  CircleAvatar(
                    radius: 50, // Adjust size as needed
                    backgroundImage: NetworkImage(
                      '${sharerDetails!.sharer!.baseUrl}${sharerDetails.sharer!.image}' ??
                          'https://via.placeholder.com/150', // Use a placeholder URL if the profile image is not available
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0),
                  // Username and rank
                  Text(
                    sharerDetails?.sharer!.name ??
                        'Username', // Replace with actual username
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   sharerDetails?.id.toString() ??
                  //       'Rank', // Replace with actual rank
                  //   style: TextStyle(fontSize: 16, color: Colors.grey),
                  // ),
                ],
              ),
            ),
            // Container for title, description, and images
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      taskDetails?.title ??
                          'Title', // Replace with actual title
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Description
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      taskDetails?.description ??
                          'Description', // Replace with actual description
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Row for before and after images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 100, // Fixed height for square shape
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: taskDetails?.before != null
                              ? Image.network(
                                  '${taskDetails?.baseUrl}${taskDetails?.before}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Return a default asset image in case of error
                                    return Image.asset(
                                      'assets/images/default_image.png', // Replace with your default asset image
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text('Before',
                                      textAlign: TextAlign.center)),
                        ),
                      ),
                      SizedBox(width: 16.0), // Space between images
                      Expanded(
                        child: Container(
                          height: 100, // Fixed height for square shape
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: taskDetails?.after != null
                              ? Image.network(
                                  '${taskDetails?.baseUrl}${taskDetails?.after}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Return a default asset image in case of error
                                    return Image.asset(
                                      'assets/images/default_image.png', // Replace with your default asset image
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
                  // Accept Task Button
                  InkWell(
                    onTap: () {
                      _acceptTaskAndNavigate(widget.taskid);
                    },
                    child: Container(
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.rank1Color),
                      child: const Center(
                        child: Text(
                          'Aceept task',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.backgroundcontainerColor,
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
