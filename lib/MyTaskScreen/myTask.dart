import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';

class MyTaskList extends StatefulWidget {
  const MyTaskList({Key? key}) : super(key: key);

  @override
  State<MyTaskList> createState() => _MyTaskListState();
}

class _MyTaskListState extends State<MyTaskList> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false).fetchTasks(
        context: context,
        // Pass the necessary data for your API call
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
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
          'My Task',
          style: TextStyle(
            color: AppColor.leaderboardtextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.mytasklist.isEmpty) {
            return Center(
              child: Text('No Task Found'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: taskProvider.mytasklist.length,
              itemBuilder: (context, index) {
                final task = taskProvider.mytasklist[index];
                String statusText = task.status == "1" ? 'Draft' : 'Completed';

                return InkWell(
                  onTap: () {
                    // Navigate to the detail screen when the card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailTaskScreen(taskId: task.id),
                      ),
                    );
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
                        backgroundImage:
                            NetworkImage('${task.baseUrl}${task.after}'),
                        backgroundColor: Colors.grey[
                            300], // Add a background color in case the image fails to load
                      ),
                      title: Text(
                        '${task.title}',
                        style: TextStyle(
                          color: AppColor.usernamehomeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Text(
                        statusText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statusText == 'Draft'
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
