//import 'dart:ffi';

import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/MyTaskScreen/MyTaskScreen.dart';
import 'package:cleanup_mobile/MyTaskScreen/myTask.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen1.dart';
import 'package:cleanup_mobile/PendingTaskScreen/PendingScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Drawer.dart';
import 'package:cleanup_mobile/Utils/Setting_Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 253, 255),
        // backgroundColor: Color.fromRGBO(248, 253, 255, 3.4),
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
                child: Image.asset('assets/images/image22.png')),
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
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        endDrawer: const SettingDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tasks',
                style: TextStyle(
                    color: AppColor.mytaskColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 0.2,
                color: AppColor.backgroundcontainerColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyTaskList()));
                  },
                  child: Container(
                    height: 55,
                    width: 390,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: ListTile(
                        leading: Image.asset('assets/images/image8.png'),
                        title: const Text(
                          'My Task',
                          style: TextStyle(
                              color: AppColor.mytaskColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0.2,
                color: AppColor.backgroundcontainerColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewTask1()));
                  },
                  child: Container(
                    height: 55,
                    width: 390,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: ListTile(
                        leading: Image.asset('assets/images/image8.png'),
                        title: const Text(
                          'New Task',
                          style: TextStyle(
                              color: AppColor.mytaskColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: const Text(
                          '10+',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0.2,
                color: AppColor.backgroundcontainerColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PendingTask()));
                  },
                  child: Container(
                    height: 55,
                    width: 390,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: ListTile(
                        leading: Image.asset('assets/images/image8.png'),
                        title: const Text(
                          'Pending Task',
                          style: TextStyle(
                              color: AppColor.mytaskColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: const Text(
                          '10+',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              const Divider(
                color: AppColor.dividerColor,
                thickness: 0.5,
                height: 0.7,
              ),
              const SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Leaderboard',
                      style: TextStyle(
                          color: AppColor.mytaskColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
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
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
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
                            fontWeight: FontWeight.bold),
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
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
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
                            fontWeight: FontWeight.bold),
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
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
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
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        '@Username',
                        style: TextStyle(color: AppColor.usernameColor),
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
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
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
}
