import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Replace with actual path

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the friends list when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getmyfreindsList(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Friends'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.myfriends.isEmpty) {
            return Center(child: Text('No friends found'));
          }
          return ListView.builder(
            itemCount: taskProvider.myfriends.length,
            itemBuilder: (context, index) {
              final friend = taskProvider.myfriends[index];
              return ListTile(
                title: Text(friend.name ?? 'Unknown'),
                subtitle: Text(friend.email ?? 'No email'),
                // Add other widgets to display friend details as needed
              );
            },
          );
        },
      ),
    );
  }
}
