import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';

class NewTsk extends StatefulWidget {
  @override
  _NewTskState createState() => _NewTskState();
}

class _NewTskState extends State<NewTsk> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false).fetchTasks(
          context: context); // Adjust method name and parameters as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskProviders>(context);

    if (taskData.myTaskModel == null || taskData.myTaskModel!.tasks == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.rank1Color,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context); // This will navigate back when tapped
            },
            child: Container(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'New Task',
            style: TextStyle(
              color: AppColor.leaderboardtextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final tasks = taskData.myTaskModel!.tasks!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context); // This will navigate back when tapped
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'New Task',
          style: TextStyle(
            color: AppColor.leaderboardtextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return InkWell(
              onTap: () {
                // Navigate to the detail screen when the card is tapped
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DetailTaskScreen(taskId: task.),
                //   ),
                // );
              },
              child: Card(
                color: AppColor.backgroundcontainerColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('${task.user?.image ?? ''}'),
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(
                    '${task.user?.name ?? 'No Title'}',
                    style: TextStyle(
                      color: AppColor.usernamehomeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    task.user?.email ?? 'No Email',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateTask()),
            );
          },
          backgroundColor: Colors.blue.shade200,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
