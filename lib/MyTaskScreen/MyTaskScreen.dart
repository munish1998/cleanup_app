import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 253, 255),
        appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            centerTitle: true,
            title: const Text(
              'My Task',
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
                      //  _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/image28.png',
                      color: Colors.black,
                    )),
              )
            ]),
        body: Padding(
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
              Card(
                color: AppColor.backgroundcontainerColor,
                elevation: 0.3,
                child: Container(
                  height: 528,
                  width: 390,
                  decoration: BoxDecoration(
                    color: AppColor.backgroundcontainerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Card(
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
                        Card(
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
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Center(
                                  child: Text(
                                    '>',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      // fontSize: 20,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Card(
                          color: AppColor.backgroundcontainerColor,
                          elevation: 0.2,
                          child: ListTile(
                              leading: Image.asset('assets/images/image11.png'),
                              title: const Text(
                                '@Username',
                                style: TextStyle(
                                    color: Color.fromARGB(159, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text('task title name'),
                              trailing: Container(
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
                                      color: Colors.blue,
                                      // fontSize: 20,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Card(
                          color: AppColor.backgroundcontainerColor,
                          elevation: 0.2,
                          child: ListTile(
                              leading: Image.asset('assets/images/image11.png'),
                              title: const Text(
                                '@Username',
                                style: TextStyle(
                                    color: Color.fromARGB(159, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text('task title name'),
                              trailing: Container(
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
                                      color: Colors.blue,
                                      // fontSize: 20,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Card(
                          color: AppColor.backgroundcontainerColor,
                          elevation: 0.2,
                          child: ListTile(
                              leading: Image.asset('assets/images/image11.png'),
                              title: const Text(
                                '@Username',
                                style: TextStyle(
                                    color: Color.fromARGB(159, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text('task title name'),
                              trailing: Container(
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
                                      color: Colors.blue,
                                      // fontSize: 20,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 44,
                              width: 167,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      'Add Friends',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'See More',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
                  MaterialPageRoute(builder: (context) => const NewTask()));
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
