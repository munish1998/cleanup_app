import 'dart:developer';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customSnackbar.dart';
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
  List<String> sharedFriends = []; // To keep track of already shared friends

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
    if (sharedFriends.contains(friendId)) {
      // Show a snackbar immediately if the user has already been shared with
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have already shared this task.')),
      );
      return; // Exit the method early to prevent further selection
    }

    setState(() {
      if (selectedFriends.contains(friendId)) {
        selectedFriends.remove(friendId);
      } else {
        if (selectedFriends.length < 3) {
          selectedFriends.add(friendId);
        } else {
          showTopSnackBar(context, 'not share more then three friends');
        }
      }
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
      _showSnackBar('At least one friend must be selected.');
      return;
    }

    bool alreadyShared =
        selectedFriends.any((friendId) => sharedFriends.contains(friendId));

    if (alreadyShared) {
      _showSnackBar(
          'You have already shared this task with one or more selected friends.');
      return;
    }

    _showLoadingDialog('Sharing with selected friends...');

    try {
      // Attempt to share the task
      bool success =
          await Provider.of<TaskProviders>(context, listen: false).shareTask(
        selectedFriends,
        context: context,
        taskId: widget.taskid ?? '',
        friendIds: selectedFriends,
      );

      // Close the loading dialog
      Navigator.of(context).pop();

      if (success) {
        setState(() {
          sharedFriends.addAll(selectedFriends);
          selectedFriends.clear();
        });

        // Navigate to the HomeScreen after a successful share
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show an error if the sharing was not successful
        // _showSnackBar('Failed to share the task.');
      }
    } catch (error) {
      // Close the loading dialog in case of an error
      Navigator.of(context).pop();

      // Handle any errors that occur during the sharing process
      // _showSnackBar('An error occurred: ${error.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showLoadingDialog(String message) {
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
              Expanded(child: Text(message)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFriendTile(TaskProviders taskProvider, int index) {
    final friend = taskProvider.myfriends[index];
    final isSelected = selectedFriends.contains(friend.id.toString());
    final isShared = sharedFriends.contains(friend.id.toString());

    //  final baseUrl = 'https://webpristine.com/cleanup/public/';
    final profileImageUrl =
        friend.image != null ? '${friend.baseUrl}${friend.image}' : null;

    log('Image URL: $profileImageUrl');

    return ListTile(
      tileColor: isSelected
          ? Colors.blue.shade100
          : isShared
              ? Colors.grey.shade300
              : Colors.white,
      leading: CircleAvatar(
        backgroundImage: profileImageUrl != null
            ? NetworkImage(profileImageUrl)
            : AssetImage('assets/images/image27.png') as ImageProvider,
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
          color: isSelected
              ? Colors.blue
              : isShared
                  ? Colors.grey
                  : Colors.black,
        ),
      ),
      subtitle: Text(
        friend.email ?? 'No email',
        style: TextStyle(
          color: isSelected
              ? Colors.blueGrey
              : isShared
                  ? Colors.grey
                  : Colors.black54,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Colors.green)
          : isShared
              ? Icon(Icons.block, color: Colors.red)
              : null,
      onTap: isShared
          ? () => _showSnackBar('You have already shared this task.')
          : () => _toggleFriendSelection(friend.id.toString()),
    );
  }

  @override
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

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: taskProvider.myfriends.length,
                  itemBuilder: (context, index) {
                    final friend = taskProvider.myfriends[index];
                    final isSelected =
                        selectedFriends.contains(friend.id.toString());
                    final isShared =
                        sharedFriends.contains(friend.id.toString());

                    // Construct the full image URL
                    final baseUrl = 'https://webpristine.com/cleanup/public/';
                    final profileImageUrl =
                        friend.image != null ? '$baseUrl${friend.image}' : null;

                    log('Image URL: $profileImageUrl');

                    return ListTile(
                      tileColor: isSelected
                          ? Colors.blue.shade100
                          : isShared
                              ? Colors.grey.shade300
                              : Colors.white,
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
                          // If an error occurs while loading the network image, fall back to the default asset image
                          setState(() {});
                        },
                      ),
                      title: Text(
                        friend.name ?? 'Unknown',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.blue
                              : isShared
                                  ? Colors.grey
                                  : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        friend.email ?? 'No email',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.blueGrey
                              : isShared
                                  ? Colors.grey
                                  : Colors.black54,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : isShared
                              ? Icon(Icons.block, color: Colors.red)
                              : null,
                      onTap: isShared
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'You have already shared this task.')),
                              );
                            }
                          : () => _toggleFriendSelection(friend.id.toString()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InkWell(
                    onTap: _shareSelectedFriends,
                    child: Container(
                      height: 54,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.rank1Color,
                      ),
                      child: const Center(
                        child: Text(
                          'Share Task',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
