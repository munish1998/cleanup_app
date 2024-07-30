import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingTask extends StatefulWidget {
  const PendingTask({Key? key}) : super(key: key);

  @override
  State<PendingTask> createState() => _PendingTaskState();
}

class _PendingTaskState extends State<PendingTask> {
  int _selectedIndex = 0;
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
            'Pending Task',
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
                  child: Image.asset('assets/images/image28.png')),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Title',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10, // Number of ListTile widgets you want to print
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
                                color: Color.fromARGB(159, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('task title name'),
                          trailing: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 177, 209, 236),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 177, 209, 236),
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
