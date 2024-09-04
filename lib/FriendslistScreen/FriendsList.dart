import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanup_mobile/Models/myfriendsModel.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';

class FriendListScreen extends StatefulWidget {
  final String? taskid;

  FriendListScreen({Key? key, required this.taskid}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  bool _isLoading = false; // Track loading state
  List<Friends> _myfreinds = [];
  List<Friends> get myfriends => _myfreinds;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getmyfreindsList(context: context);
    });
  }

  bool isUserBlocked(String userId, List<Blocked> blockedList) {
    // Check if the blocked list contains the user ID
    return blockedList.any((blocked) => blocked.id.toString() == userId);
  }

  Future<void> unfriendUser(String userId) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final String baseUrl = 'https://webpristine.com/cleanup/public';
    final String endpoint = '/api/auth/unfriend/$userId';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    if (accessToken == null) {
      print('Access token not found.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success']) {
          print('User unfriended successfully');

          final taskProvider =
              Provider.of<TaskProviders>(context, listen: false);
          taskProvider.removeFriend(userId); // Remove friend from the list

          // Optionally, refresh the friends list
          await taskProvider.getmyfreindsList(context: context);
        } else {
          print('Failed to unfriend user: ${result['message']}');
        }
      } else {
        print('Failed to unfriend user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> sendReport({
    required String userId,
    required String reason,
  }) async {
    final url = Uri.parse(ApiServices.reportUser);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'reported_user_id': userId,
        'reason': reason,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully sent the report
      log('Report sent successfully');
    } else {
      // Handle error
      log('Failed to send report: ${response.statusCode}');
      log('Error: ${response.body}');
    }
  }

  void _showReportDialog(String userId) {
    final TextEditingController _reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report User'),
          content: TextField(
            controller: _reasonController,
            decoration: InputDecoration(hintText: 'Enter reason for reporting'),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                final reason = _reasonController.text;
                if (reason.isNotEmpty) {
                  sendReport(userId: userId, reason: reason).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Report submitted')),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a reason')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void handleMenuAction(String action, String userId) {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);

    switch (action) {
      case 'report':
        // Show report dialog
        _showReportDialog(userId);
        break;
      case 'block':
        // Handle block action
        taskProvider.blockUser(receiverID: userId, context: context).then((_) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('User blocked successfully')),
          // );
          setState(() {
            taskProvider.getmyfreindsList(
                context: context); // Refresh friends list
            //taskProvider.getBlockedUsers(context: context); // Refresh blocked users list
          });
        });

        break;
      case 'unfriend':
        // Handle unfriend action
        unfriendUser(userId);
        break;
    }
  }

  // bool isUserBlocked(String userId, List<Blocked> blockedList) {
  //   return blockedList.any((blocked) => blocked.id.toString() == userId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('My Friends List'),
      ),
      body: Stack(
        children: [
          Consumer<TaskProviders>(
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
                        final isBlocked = isUserBlocked(
                          friend.id.toString(),
                          taskProvider.blocked,
                        );

                        final baseUrl =
                            'https://webpristine.com/cleanup/public';
                        final profileImageUrl = friend.image != null
                            ? '${friend.baseUrl}${friend.image}'
                            : null;

                        log('Image URL link: $profileImageUrl');

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: profileImageUrl != null
                                ? CachedNetworkImageProvider(profileImageUrl)
                                : AssetImage('assets/images/image27.png')
                                    as ImageProvider,
                            backgroundColor: Colors.grey[300],
                            child: profileImageUrl == null
                                ? Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          title: Text(friend.name ?? 'Unknown'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(friend.email ?? 'No email'),
                              Container(
                                height: 24,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.rank1Color,
                                ),
                                child: Center(
                                    child: Text(
                                  isBlocked ? 'Blocked' : 'Friend',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColor.backgroundcontainerColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String action) {
                              handleMenuAction(action, friend.id.toString());
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'report',
                                  child: Text('Report'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'block',
                                  child: Text('Block'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'unfriend',
                                  child: Text('Unfriend'),
                                ),
                              ];
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
        ],
      ),
    );
  }
}
