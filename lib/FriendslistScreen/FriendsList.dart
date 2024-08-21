import 'dart:developer';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';

class FriendListScreen extends StatefulWidget {
  final String? taskid;

  FriendListScreen({Key? key, required this.taskid}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  List<String> selectedFriends = []; // To keep track of selected friends

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getmyfreindsList(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('My Friends List'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.myfriends.isEmpty) {
            return Center(child: Text('No friends found'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: taskProvider.myfriends.length,
                  itemBuilder: (context, index) {
                    final friend = taskProvider.myfriends[index];

                    // Construct the full image URL if necessary
                    final baseUrl = 'https://webpristine.com/cleanup/public';
                    final profileImageUrl =
                        friend.image != null ? '$baseUrl${friend.image}' : null;

                    log('Image URL: $profileImageUrl');

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage('${friend.baseUrl}${friend.image}')
                            : AssetImage('assets/images/image27.png')
                                as ImageProvider,
                        backgroundColor: Colors.grey[300],
                        child: profileImageUrl == null
                            ? Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                      title: Text(friend.name ?? 'Unknown'),
                      subtitle: Text(friend.email ?? 'No email'),
                      onTap: () {
                        // Handle tap
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
