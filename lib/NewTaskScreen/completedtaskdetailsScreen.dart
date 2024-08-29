import 'package:cleanup_mobile/Models/completetaskModel.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteTaskDetail extends StatefulWidget {
  @override
  _CompleteTaskDetailState createState() => _CompleteTaskDetailState();
}

class _CompleteTaskDetailState extends State<CompleteTaskDetail> {
  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  Future<void> _fetchTaskDetails() async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);
    await taskProvider
        .fetchCompleteTasks('completed'); // Ensure correct status is used
    setState(() {}); // Trigger a rebuild to reflect changes
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProviders>(context);

    // Check if there are tasks available
    final task = taskProvider.mycompletes.isNotEmpty
        ? taskProvider.mycompletes.first
        : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('Task Details'),
      ),
      body: taskProvider.mycompletes.isEmpty
          ? Center(child: Text('No tasks available.'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (task != null) ...[
                    Container(
                      color: AppColor.rank1Color,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Center(
                        child: Text(
                          task.task!.title.toString(),
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
                              '${task.user!.baseUrl}${task.user!.image}',
                            ),
                            backgroundColor: Colors.grey[300],
                            onBackgroundImageError: (error, stackTrace) {
                              setState(() {
                                // Fallback to a default image if the network image fails to load
                                task.user!.image =
                                    'assets/images/default_image.png';
                              });
                            },
                            child: task.user!.image == null
                                ? Icon(Icons.person, size: 50)
                                : null,
                          ),
                          SizedBox(height: 16.0),
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
                              task.sharetask!.title.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
                              task.task!.description.toString(),
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
                                  child: task.sharetask!.before != null
                                      ? Image.network(
                                          '${task.task!.baseUrl}${task.task!.before}',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                  child: task.sharetask!.after != null
                                      ? Image.network(
                                          '${task.task!.baseUrl}${task.task!.after}',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                        ],
                      ),
                    ),
                  ] else ...[
                    Center(child: Text('No task details available.')),
                  ],
                ],
              ),
            ),
    );
  }
}
