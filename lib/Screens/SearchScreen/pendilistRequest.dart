import 'package:cleanup_mobile/Screens/SearchScreen/shareTask.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Models/pendingRequest.dart';

class PendingListScreen extends StatefulWidget {
  const PendingListScreen({super.key});

  @override
  State<PendingListScreen> createState() => _PendingListScreenState();
}

class _PendingListScreenState extends State<PendingListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch pending requests when the screen is initialized
    _fetchPendingRequests();
  }

  Future<void> _fetchPendingRequests() async {
    try {
      await Provider.of<TaskProviders>(context, listen: false)
          .getpendingRequest(context: context);
    } catch (e) {
      // Handle any errors that occur during fetching
      print('Error fetching pending requests: $e');
    }
  }

  Future<void> _acceptRequest(int requestId) async {
    try {
      await Provider.of<TaskProviders>(context, listen: false)
          .acceptFriendRequest(context: context, requestId: requestId);
      //  Navigate to ShareTaskScreen upon success
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShareTask(
                  tasktitle: '',
                )),
      );
    } catch (e) {
      // Handle any errors that occur during acceptance
      print('Error accepting friend request: $e');
    }
  }

  Future<void> _declineRequest(int requestId) async {
    try {
      await Provider.of<TaskProviders>(context, listen: false)
          .declineFriendRequest(context: context, requestId: requestId);
      // Optionally refresh the pending requests list
      _fetchPendingRequests();
    } catch (e) {
      // Handle any errors that occur during declination
      print('Error declining friend request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: const Text('Pending Requests'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          // Get the list of pending requests from the provider
          List<PendingRequestModel> pendingRequests = taskProvider.pending;

          // Check if there are any pending requests
          if (pendingRequests.isEmpty) {
            return Center(child: Text('No pending requests'));
          }

          return ListView.builder(
            itemCount: pendingRequests.length,
            itemBuilder: (context, index) {
              final request = pendingRequests[index];
              final int requestId = request.id ?? 0; // Default value if null

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(request.sender?.name ?? 'Unknown'),
                  subtitle: Text(request.sender?.email ?? 'No email'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _acceptRequest(requestId);
                        },
                        child: Container(
                          height: 34,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.rank1Color,
                          ),
                          child: const Center(
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.backgroundcontainerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8), // Add spacing between buttons
                      GestureDetector(
                        onTap: () {
                          _declineRequest(requestId);
                        },
                        child: Container(
                          height: 34,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.rank1Color,
                          ),
                          child: const Center(
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.backgroundcontainerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
