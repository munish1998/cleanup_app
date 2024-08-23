import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/MyTaskScreen/myTask.dart';
import 'package:cleanup_mobile/MyTaskScreen/newTask.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen1.dart';
import 'package:cleanup_mobile/NewTaskScreen/completetaskScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/newtasksScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/pendingTask.dart';
import 'package:cleanup_mobile/NewTaskScreen/sharetasklistScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/pendilistRequest.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/requestsendList.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Drawer.dart';
import 'package:cleanup_mobile/Utils/Setting_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Fetch tasks when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTasks();
    });
  }

  Future<void> _fetchTasks() async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);
    await taskProvider.getMyTaskList(context: context);
    await taskProvider.fetchIncomingTasks('new');
    await taskProvider.fetchPendingTasks('pending');
    // taskProvider.getToken(); // Adjust status as needed
  }

  Future<void> _onRefresh() async {
    // Call the method to fetch tasks
    await _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProviders>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      drawer: const AppDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset('assets/images/image22.png'),
          ),
        ),
        centerTitle: true,
        title: Image.asset('assets/images/image21.png'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      endDrawer: const SettingDrawer(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tasks',
                style: TextStyle(
                  color: AppColor.mytaskColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    _buildTaskCard(
                      context,
                      title: 'My Task',
                      image: 'assets/images/image8.png',
                      trailing: '${taskProvider.mytasklist.length}',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyTaskList()),
                      ),
                    ),
                    _buildTaskCard(
                      context,
                      title: 'Pending Task',
                      image: 'assets/images/image8.png',
                      trailing: '${taskProvider.pendingTask.length}',
                      trailingColor: Colors.purple,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PendingTaskkScreen()),
                      ),
                    ),
                    _buildTaskCard(
                      context,
                      title: 'New Task',
                      image: 'assets/images/image8.png',
                      trailing: '${taskProvider.comingTask.length}',
                      trailingColor: Colors.purple,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpcomingTaskScreen()),
                      ),
                    ),
                    _buildTaskCard(
                      context,
                      title: 'Pending request',
                      image: 'assets/images/image8.png',
                      trailing: '${taskProvider.pending.length}',
                      trailingColor: Colors.orange,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PendingListScreen()),
                      ),
                    ),
                    _buildTaskCard(
                      context,
                      title: 'Complete Task',
                      image: 'assets/images/image8.png',
                      trailing: '${taskProvider.mycompletes.length}',
                      trailingColor: Colors.purple,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteTaskScreen(
                                  taskId: taskProvider.mytasklist.first.id,
                                )),
                      ),
                    ),
                    _buildTaskCard(
                      context,
                      title: 'Request send list',
                      image: 'assets/images/image8.png',
                      trailing: '${taskProvider.mycompletes.length}',
                      trailingColor: Colors.purple,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShareTaskScreen()),
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Divider(
                      color: AppColor.dividerColor,
                      thickness: 0.5,
                      height: 0.7,
                    ),
                    const SizedBox(height: 17),
                    _buildLeaderboardSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            size: 30,
          ),
          mini: true,
          shape: const CircleBorder(),
        ),
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required String title,
    required String image,
    String? trailing,
    Color trailingColor = Colors.blue,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 0.2,
      color: AppColor.backgroundcontainerColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 55,
          width: screenWidth - 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: ListTile(
              leading: Image.asset(image),
              title: Text(
                title,
                style: TextStyle(
                  color: AppColor.mytaskColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: trailing != null
                  ? Text(
                      trailing,
                      style: TextStyle(
                        color: trailingColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardSection() {
    return Column(
      children: List.generate(3, (index) {
        return SizedBox(
          height: 95,
          child: Card(
            color: AppColor.backgroundcontainerColor,
            elevation: 0.2,
            child: ListTile(
              leading: Image.asset('assets/images/image11.png'),
              title: const Text(
                'Sam Curran',
                style: TextStyle(
                  color: AppColor.mytaskColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                '@Username',
                style: TextStyle(color: AppColor.usernamehomeColor),
              ),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '422',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  Icon(
                    Icons.arrow_drop_up_sharp,
                    size: 40,
                    color: Colors.lightBlue,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
