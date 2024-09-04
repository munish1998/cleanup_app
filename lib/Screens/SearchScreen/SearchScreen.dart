import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Models/userModel.dart'; // Ensure correct import

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Track which users have been requested
  Set<int> _requestedUsers = Set<int>();

  // Track loading state for each user request
  Set<int> _loadingUsers = Set<int>();

  // List of all users
  List<AllUserModel> _allUsers = [];

  // Filtered list based on search query
  List<AllUserModel> _filteredUsers = [];

  // Search query
  String _searchQuery = '';

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
    setState(() {
      _loadingUsers.add(userId); // Show loading indicator
    });

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
    } finally {
      setState(() {
        _loadingUsers.remove(userId); // Hide loading indicator
      });
    }
  }

  // Filter users based on the search query
  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query;
      _filteredUsers = _allUsers
          .where((user) =>
              user.username?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('Search User'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navPushReplace(context: context, action: HomeScreen());
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: _filterUsers,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search by username...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<TaskProviders>(
              builder: (context, provider, child) {
                if (provider.allUser.isEmpty) {
                  return Center(child: Text('No users found'));
                }

                // Update _allUsers and _filteredUsers when new data is fetched
                if (_allUsers.isEmpty) {
                  _allUsers = provider.allUser;
                  _filteredUsers = _allUsers;
                }

                return ListView.builder(
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    var user = _filteredUsers[index];
                    bool isRequested = _requestedUsers.contains(user.id);
                    bool isLoading = _loadingUsers.contains(user.id);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      color: Colors.white, // Set card background color to white
                      elevation: 4,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12.0),
                        leading: CircleAvatar(
                          backgroundImage: user.image != null
                              ? NetworkImage('${user.baseUrl}${user.image}')
                              : AssetImage('assets/images/image27.png')
                                  as ImageProvider,
                          radius: 24,
                        ),
                        title: Text(user.name ?? 'No Username'),
                        subtitle: Text(user.email ?? 'No Email'),
                        trailing: isLoading
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  onPressed: () {
                                    if (!isRequested) {
                                      _sendFriendRequest(user.id);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: isRequested
                                        ? Colors.black
                                        : Colors.white,
                                    backgroundColor: isRequested
                                        ? Colors.grey[300]
                                        : Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    isRequested ? 'Requested' : 'Send Request',
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
