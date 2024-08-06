import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Models/pendingRequest.dart'; // Adjust the import according to your file structure

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
      // Optionally refresh the pending requests list
      _fetchPendingRequests();
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
              final requestId = request.id;

              // Ensure requestId is not null before using it
              if (requestId == null) {
                return ListTile(
                  title: Text(request.sender?.name ?? 'Unknown'),
                  subtitle: Text('Request ID: Unknown'),
                );
              }

              return ListTile(
                title: Text(request.sender?.name ?? 'Unknown'),
                subtitle: Text('Request ID: $requestId'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => _acceptRequest(requestId),
                      child: Text(
                        'Accept',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    SizedBox(width: 8), // Add spacing between buttons
                    TextButton(
                      onPressed: () => _declineRequest(requestId),
                      child: Text(
                        'Decline',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
