import 'package:flutter/material.dart';

class SettingDrawer extends StatefulWidget {
  const SettingDrawer({Key? key});

  @override
  State<SettingDrawer> createState() => _SettingDrawerState();
}

class _SettingDrawerState extends State<SettingDrawer> {
  int currentPage = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: ListTile(
              leading: Icon(Icons.menu),
              title: const Text(
                'Settings',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.clear,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {},
            child: _listContent(
              icon: Icons.person,
              name: "Contact Us",
            ),
          ),
          InkWell(
            onTap: () {},
            child: _listContent(
              icon: Icons.person,
              name: "Terms and Condition",
            ),
          ),
          InkWell(
            onTap: () {},
            child: _listContent(
              icon: Icons.add,
              name: "FAQ/Help",
            ),
          ),
          InkWell(
            onTap: () {},
            child: _listContent(
              icon: Icons.password_outlined,
              name: "Forgot Password",
            ),
          ),
          InkWell(
            onTap: () {
              _exitApp(context);
            },
            child: _listContent(
              icon: Icons.logout,
              name: "Logout",
            ),
          ),
          Spacer(),
        ],
      ),
    );
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
              onTap: () {},
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
                style: TextStyle(
                  color: Colors.black, // Set the color to black
                  fontWeight: FontWeight.bold, // Set the font weight to bold
                  fontSize: 13,
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
