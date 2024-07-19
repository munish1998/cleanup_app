import 'package:flutter/material.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 254,
      child: Container(
        //height: 254,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuItem(Icons.account_circle, 'Account Details'),
            const SizedBox(height: 10),
            _buildMenuItem(Icons.people, 'Friends List'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData iconData, String label) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 10),
        Text(label),
      ],
    );
  }
}
