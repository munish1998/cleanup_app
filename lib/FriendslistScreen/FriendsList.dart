import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FriendListScreen extends StatefulWidget {
  final String? taskid;

  FriendListScreen({Key? key, required this.taskid}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  List<String> selectedFriends = []; // To keep track of selected friends
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getmyfreindsList(context: context);
    });
  }

  Future<void> unfriendUser(String userId) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final String baseUrl =
        'https://webpristine.com/cleanup/public'; // Replace with your base URL
    final String endpoint =
        '/api/auth/unfriend/$userId'; // Append userId to endpoint
    final Uri url = Uri.parse('$baseUrl$endpoint');

    // Get the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref
        .getString(accessTokenKey); // Use the correct key for your access token

    if (accessToken == null) {
      print('Access token not found.');
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      return;
    }

    // Create headers for the request
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      // Log the response for debugging
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success']) {
          print('User unfriended successfully');

          // Update the friends list in the Provider or state
          final taskProvider =
              Provider.of<TaskProviders>(context, listen: false);
          taskProvider.removeFriend(
              userId); // Assuming you have a method to remove a friend from the list

          // Optionally, you can refresh the friends list
          // taskProvider.getmyfreindsList(context: context);
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
        _isLoading = false; // Hide loading indicator
      });
    }
  }

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

                        // Construct the full image URL if necessary
                        final baseUrl =
                            'https://webpristine.com/cleanup/public';
                        final profileImageUrl = friend.image != null
                            ? '$baseUrl${friend.image}'
                            : null;

                        log('Image URL link: $profileImageUrl');

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: profileImageUrl != null
                                ? CachedNetworkImageProvider(
                                    profileImageUrl,
                                  )
                                : AssetImage('assets/images/image27.png')
                                    as ImageProvider,
                            backgroundColor: Colors.grey[300],
                            child: profileImageUrl == null
                                ? Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          title: Text(friend.name ?? 'Unknown'),
                          subtitle: Text(friend.email ?? 'No email'),
                          trailing: InkWell(
                            onTap: () {
                              unfriendUser(friend.id.toString());
                            },
                            child: Container(
                              height: 44,
                              width: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.rank1Color),
                              child: const Center(
                                child: Text(
                                  'Unfriend',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.backgroundcontainerColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
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
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
        ],
      ),
    );
  }
}
