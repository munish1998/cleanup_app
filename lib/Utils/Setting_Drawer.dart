import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
// Import your AuthProvider

class SettingDrawer extends StatelessWidget {
  const SettingDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: ListTile(
                  leading: Icon(Icons.menu),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
              const Divider(color: Colors.grey),
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
                  _showLogoutDialog(context, authProvider);
                },
                child: _listContent(
                  icon: Icons.logout,
                  name: "Logout",
                ),
              ),
              Spacer(),
            ],
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning!!!!'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                // Navigator.of(context).pop(); // Close the dialog

                await authProvider.logout(context);
                customToast(
                    context: context, msg: 'Logout successfully', type: 0);
                navPushRemove(context: context, action: LoginScreen());
                // Ensure that the widget is still mounted

                // Show a Snackbar to indicate successful logout
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: const Text('Successfully logged out'),
                //     backgroundColor: Colors.green,
                //     duration: const Duration(seconds: 2),
                //   ),
                // );

                // Optionally, navigate to a different screen (e.g., login screen)
                // Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Yes'),
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
