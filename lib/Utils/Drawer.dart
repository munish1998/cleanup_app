import 'package:cleanup_mobile/Auth_Screen/SignUp.dart';
import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/LeaderboardScreen/LeaderScreen.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/ProfileScreen/ProfileScreen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int currentPage = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 7,
              ),
              child: ListTile(
                leading: Icon(Icons.menu),
                title: Text(
                  'Menu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue.shade300),
                    child: const Icon(
                      Icons.clear,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
//const SizedBox(height: 1),
            // const Padding(
            // padding: EdgeInsets.symmetric(
            //   horizontal: 10,
            // ),
            //  ),
            // SizedBox(height: 40),
            Divider(
              color: Colors.grey.shade300,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: _listContent(
                icon: Icons.home,
                name: "Home",
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendListScreen()));
              },
              child: _listContent(
                icon: Icons.search,
                name: "Search Friends",
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewTask()));
              },
              child: _listContent(
                icon: Icons.add,
                name: "Add Tak",
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeaderBoardScreen()));
              },
              child: _listContent(
                icon: Icons.leaderboard,
                name: "Leaderboard",
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: _listContent(
                icon: Icons.person,
                name: "Profile",
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: _listContent(
                icon: Icons.person,
                name: "Contacts",
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     _exitApp(context);
            //   },
            //   child: _listContent(
            //     icon: Icons.logout,
            //     name: "Logout",
            //   ),
            // ),
            Spacer(),
          ],
        ));
  }

  Future<dynamic> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning!!!!'),
          content: const Text('Are you sure want to logout'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                print("you choose no");
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            const SizedBox(
              width: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Widget _listContent({
    required IconData icon,
    required String name,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 7),
          Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                icon,
                size: 24, // Adjust the size as needed
                color: Colors.blue, // Adjust the color as needed
              ),
              const SizedBox(width: 10),
              Text(
                name,
                style: const TextStyle(
                  // letterSpacing: 4,
                  // fontFamily: "BankGothic",
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
        ],
      ),
    );
  }
}
