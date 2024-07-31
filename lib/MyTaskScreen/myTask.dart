import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Adjust import based on your project structure
import 'package:cleanup_mobile/Utils/AppConstant.dart'; // Adjust import based on your project structure
import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart'; // Adjust import based on your project structure
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart'; // Adjust import based on your project structure

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
      Provider.of<TaskProviders>(context, listen: false).getMyTaskList(
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                // Implement action if needed
              },
              child: Image.asset(
                'assets/images/image28.png',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.mytasklist.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: ListView.builder(
              itemCount: taskProvider.mytasklist.length,
              itemBuilder: (context, index) {
                final task = taskProvider.mytasklist[index];
                return Card(
                  color: AppColor.backgroundcontainerColor,
                  elevation: 0.2,
                  child: ListTile(
                    leading: Image.network('${task.baseUrl}${task.before}'),
                    title: Text(
                      '@${task.title}',
                      style: TextStyle(
                        color: AppColor.usernamehomeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(task.description),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailTaskScreen(taskId: task.id)));
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                            '>',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
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
