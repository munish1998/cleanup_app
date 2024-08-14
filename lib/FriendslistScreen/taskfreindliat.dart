import 'dart:developer';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';

class FriendTaskScreen extends StatefulWidget {
  final String? taskid;

  FriendTaskScreen({Key? key, required this.taskid}) : super(key: key);

  @override
  _FriendTaskScreenState createState() => _FriendTaskScreenState();
}

class _FriendTaskScreenState extends State<FriendTaskScreen> {
  List<String> selectedFriends = []; // To keep track of selected friends

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getmyfreindsList(context: context);
    });
  }

  void _toggleFriendSelection(String friendId) {
    setState(() {
      if (selectedFriends.contains(friendId)) {
        selectedFriends.remove(friendId);
      } else {
        if (selectedFriends.length < 3) {
          selectedFriends.add(friendId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You can select a maximum of 3 friends.')),
          );
        }
      }
    });
  }

  void _shareSelectedFriends() async {
    if (selectedFriends.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('At least one friend must be selected.')),
      );
      return;
    }

    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Sharing Task'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(child: Text('Sharing with selected friends...')),
            ],
          ),
        );
      },
    );

    try {
      await taskProvider.shareTask(
        selectedFriends,
        context: context,
        taskId: widget.taskid ?? '',
        friendIds: selectedFriends,
      );

      Navigator.of(context).pop(); // Close the dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task shared successfully!')),
      );
    } catch (error) {
      Navigator.of(context).pop(); // Close the dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share task')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('My Friends List'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareSelectedFriends,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${selectedFriends.length} Selected',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
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
                    final isSelected = selectedFriends.contains(friend.id);

                    // Determine the image URL or use default image
                    final profileImageUrl = friend.image;
                    log('Image URL: $profileImageUrl');

                    final imageProvider = profileImageUrl != null
                        ? (profileImageUrl.startsWith('http')
                            ? NetworkImage(profileImageUrl)
                            : AssetImage('assets/images/$profileImageUrl')
                                as ImageProvider)
                        : AssetImage('assets/images/image27.png')
                            as ImageProvider;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.grey[300],
                        child: profileImageUrl == null
                            ? Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                      title: Text(friend.name ?? 'Unknown'),
                      subtitle: Text(friend.email ?? 'No email'),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () => _toggleFriendSelection(friend.id.toString()),
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
