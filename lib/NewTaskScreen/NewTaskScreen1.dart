import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/LeaderboardScreen/LeaderScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/detailsScreen.dart';
import 'package:cleanup_mobile/ProfileScreen/ProfileScreen.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/SearchScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTask1 extends StatefulWidget {
  const NewTask1({Key? key}) : super(key: key);

  @override
  State<NewTask1> createState() => _NewTask1State();
}

class _NewTask1State extends State<NewTask1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 253, 255),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 248, 253, 255),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            centerTitle: true,
            title: const Text(
              'New Task',
              style: TextStyle(
                  color: AppColor.leaderboardtextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                    onTap: () {
                      // _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/image28.png',
                      color: Colors.black,
                    )),
              )
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Title',
                  style: TextStyle(
                      color: AppColor.leaderboardtextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailTaskScreen(taskId: taskId)))
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          color: AppColor.backgroundcontainerColor,
                          elevation: 0.2,
                          child: ListTile(
                            leading: Image.asset('assets/images/image11.png'),
                            title: const Text(
                              '@Username',
                              style: TextStyle(
                                  color: AppColor.usernamehomeColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text('task title name'),
                            trailing: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: AppColor.rank1Color,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Center(
                                    child: Text(
                                      '>',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColor.rank1Color,
                                        // fontSize: 20,
                                        //fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.grey),
                padding: EdgeInsets.zero,
              ),
              SizedBox(width: 14),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(Icons.search, color: Colors.grey),
                padding: EdgeInsets.zero,
              ),
              SizedBox(width: 120),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderBoardScreen()));
                },
                icon: Icon(Icons.leaderboard, color: Colors.grey),
                padding: EdgeInsets.zero,
              ),
              SizedBox(width: 14),
              IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 254,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel,
                                      color: Colors.lightBlue.shade300),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.person, color: Colors.black),
                                SizedBox(width: 6),
                                Text(
                                  'Profiles',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            _buildMenuItem(Icons.account_circle,
                                'Account Details', context),
                            SizedBox(height: 10),
                            _buildMenuItem(
                                Icons.people, 'Friends List', context),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.person, color: Colors.grey),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(25.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateTask()));
            },
            backgroundColor: Colors.blue.shade200,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
            shape: const CircleBorder(),
          ),
        ));
  }

  Widget _buildMenuItem(IconData icon, String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap on menu item
        Navigator.pop(context); // Close the bottom sheet
        if (text == 'Account Details') {
          // Open bottom sheet for Account Details
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SizedBox(
                height: 857,
                child: ProfileScreen(),
              );
            },
          );
        } else if (text == 'Friends List') {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 750,
                  // child: FriendListScreen(taskid: taskpr,),
                );
              });
          // Handle other menu items here
        }
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
