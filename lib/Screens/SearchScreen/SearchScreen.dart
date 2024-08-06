import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Models/userModel.dart'; // Ensure correct import

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Track which users have been requested
  Set<int> _requestedUsers = Set<int>();

  @override
  void initState() {
    super.initState();
    // Fetch the list of users when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getallUsers(context: context);
    });
  }

  // Method to handle sending friend requests
  Future<void> _sendFriendRequest(int userId) async {
    try {
      await Provider.of<TaskProviders>(context, listen: false)
          .sendFriendRequest(context: context, receiverId: userId);

      // Update the requested users set and refresh the UI
      setState(() {
        _requestedUsers.add(userId);
      });
    } catch (e) {
      // Handle any errors that occur during sending the request
      print('Error sending friend request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                    width: 10), // Add space between arrow back and TextField
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white, // Use your defined color
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<TaskProviders>(
              builder: (context, provider, child) {
                if (provider.allUser.isEmpty) {
                  return Center(child: Text('No users found'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: provider.allUser.length,
                    itemBuilder: (context, index) {
                      var user = provider.allUser[index];
                      bool isRequested = _requestedUsers.contains(user.id);

                      return ListTile(
                        title: Text(user.name ?? 'No Name'),
                        subtitle: Text(user.email ?? 'No Email'),
                        trailing: TextButton(
                          onPressed: () {
                            if (!isRequested) {
                              _sendFriendRequest(user.id);
                            }
                          },
                          child: Text(
                            isRequested ? 'Requested' : 'Send Request',
                            style: TextStyle(
                              color: isRequested ? Colors.grey : Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
