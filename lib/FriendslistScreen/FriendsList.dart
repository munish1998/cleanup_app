import 'dart:convert';
import 'dart:math';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTaskfreind {
  final int id;
  final int userId;
  final String location;
  final String title;
  final String description;
  final String before;
  final String after;
  final String baseUrl;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  MyTaskfreind({
    required this.id,
    required this.userId,
    required this.location,
    required this.title,
    required this.description,
    required this.before,
    required this.after,
    required this.baseUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON data
  factory MyTaskfreind.fromJson(Map<String, dynamic> json) {
    return MyTaskfreind(
      id: json['id'],
      userId: json['user_id'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      before: json['before'],
      after: json['after'],
      baseUrl: json['base_url'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class FriendListScreen extends StatefulWidget {
  String? taskid;
  MyTaskfreind? _taskk;
  FriendListScreen({Key? key, required this.taskid}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  List<String> selectedFriends = []; // To keep track of selected friends

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
                    final isSelected = selectedFriends.contains(friend.id);

                    // Determine the image URL or use default image
                    final profileImageUrl =
                        friend.id; // Example profile image URL
                    final imageProvider = (profileImageUrl != null)
                        ? NetworkImage(profileImageUrl.toString())
                        : AssetImage('assets/images/image27.png')
                            as ImageProvider;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.grey[300],
                        child: (profileImageUrl == null)
                            ? Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                      title: Text(friend.name ?? 'Unknown'),
                      subtitle: Text(friend.email ?? 'No email'),
                      trailing: isSelected
                          ? CircleAvatar(
                              child: Text(
                                  '${selectedFriends.indexOf(friend.id.toString()) + 1}'),
                              backgroundColor:
                                  const Color.fromRGBO(33, 150, 243, 1),
                              foregroundColor: Colors.black,
                            )
                          : null,
                      onTap: () {
                        // setState(() {
                        //   if (isSelected) {
                        //     selectedFriends.remove(friend.id);
                        //   } else {
                        //     if (selectedFriends.length < 3) {
                        //       selectedFriends.add(friend.id.toString());
                        //     } else {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //             content: Text(
                        //                 'You can only select up to 3 friends')),
                        //       );
                        //     }
                        //   }
                        // });
                      },
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: InkWell(
              //     onTap: _shareSelectedFriends,
              //     child: Container(
              //       height: 54,
              //       width: 370,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: AppColor.rank1Color),
              //       child: const Center(
              //           child: Text(
              //         'Send Task',
              //         style: TextStyle(
              //             fontSize: 20,
              //             color: AppColor.backgroundcontainerColor,
              //             fontWeight: FontWeight.bold),
              //       )),
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  void _shareSelectedFriends() async {
    if (selectedFriends.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No friends selected to share')),
      );
      return;
    }

    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    // Example: Displaying a loading indicator while sharing
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
      // Call the shareTask method from TaskProviders
      await taskProvider.shareTask(
        selectedFriends,
        context: context,
        taskId: '', // Use taskid from the widget
        friendIds: selectedFriends,
      );

      // Dismiss the dialog after sharing is complete
      Navigator.of(context).pop(); // Close the dialog

      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task shared successfully!')),
      );
    } catch (error) {
      // Handle errors
      Navigator.of(context).pop(); // Close the dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share task')),
      );
    }
  }
}
