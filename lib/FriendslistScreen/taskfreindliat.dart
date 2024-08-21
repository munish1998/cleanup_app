import 'dart:developer';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final taskProvider = Provider.of<TaskProviders>(context, listen: false);

      // Fetch the list of friends
      await taskProvider.getmyfreindsList(context: context);

      // Fetch the task count if taskid is available
      if (widget.taskid != null) {
        await taskProvider.fetchTaskCount(widget.taskid!);
      }
    });
  }

  void _toggleFriendSelection(String friendId) async {
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
      // Log the updated selected friends list
      log('Updated selected friends: $selectedFriends');
    });

    // Fetch the task count again after updating the selected friends
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);
    if (widget.taskid != null) {
      await taskProvider.fetchTaskCount(widget.taskid!);
    }
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

      // Navigate to the home screen and remove the previous route
      navPushReplace(
        context: context,
        action: HomeScreen(),
      );

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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Consumer<TaskProviders>(
            builder: (context, taskProvider, child) {
              if (widget.taskid != null && taskProvider.taskCount != null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Task Shared Count: ${taskProvider.taskCount}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              } else {
                return Container(); // Empty container if no task count is available
              }
            },
          ),
        ),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.myfriends == null ||
              taskProvider.myfriends.isEmpty) {
            return Center(child: Text('No friends found'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: taskProvider.myfriends.length,
                  itemBuilder: (context, index) {
                    final friend = taskProvider.myfriends[index];
                    final isSelected =
                        selectedFriends.contains(friend.id.toString());

                    // Construct the full image URL
                    final baseUrl = 'https://webpristine.com/cleanup/public/';
                    final profileImageUrl =
                        friend.image != null ? '$baseUrl${friend.image}' : null;

                    log('Image URL: $profileImageUrl');

                    return ListTile(
                      tileColor:
                          isSelected ? Colors.blue.shade100 : Colors.white,
                      leading: CircleAvatar(
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(profileImageUrl)
                            : AssetImage('assets/images/image27.png')
                                as ImageProvider,
                        backgroundColor: Colors.grey[300],
                        child: profileImageUrl == null
                            ? Icon(Icons.person, color: Colors.white)
                            : null,
                        onBackgroundImageError: (error, stackTrace) {
                          log('Image load error: $error');
                        },
                      ),
                      title: Text(
                        friend.name ?? 'Unknown',
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        friend.email ?? 'No email',
                        style: TextStyle(
                          color: isSelected ? Colors.blueGrey : Colors.black54,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () => _toggleFriendSelection(friend.id.toString()),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  _shareSelectedFriends();
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.rank1Color),
                  child: const Center(
                    child: Text(
                      'Share Task',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
