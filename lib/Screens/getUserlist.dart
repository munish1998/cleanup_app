import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Models/userModel.dart'; // Import your user model
// Import your provider

class UserListSscreen extends StatefulWidget {
  const UserListSscreen({super.key});

  @override
  State<UserListSscreen> createState() => _UserListSscreenState();
}

class _UserListSscreenState extends State<UserListSscreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the user list when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getallUsers(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, provider, child) {
          if (provider.allUser.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.allUser.length,
            itemBuilder: (context, index) {
              final user = provider.allUser[index];
              return ListTile(
                title: Text(user.name.toString()),
                subtitle: Text(user.email.toString()),
                trailing: Text(user.mobile.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
