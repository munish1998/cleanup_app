import 'dart:developer';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
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
  // Map to track the loading state for each request and action
  Map<int, bool> _acceptLoading = {};
  Map<int, bool> _declineLoading = {};

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
    setState(() {
      _acceptLoading[requestId] = true;
    });

    try {
      await Provider.of<TaskProviders>(context, listen: false)
          .acceptFriendRequest(context: context, requestId: requestId);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      //  );
    } catch (e) {
      print('Error accepting friend request: $e');
    } finally {
      setState(() {
        _acceptLoading[requestId] = false;
      });
    }
  }

  Future<void> _declineRequest(int requestId) async {
    setState(() {
      _declineLoading[requestId] = true;
    });

    try {
      await Provider.of<TaskProviders>(context, listen: false)
          .declineFriendRequest(context: context, requestId: requestId);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
    } catch (e) {
      print('Error declining friend request: $e');
    } finally {
      setState(() {
        _declineLoading[requestId] = false;
      });
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
          List<PendingRequestModel> pendingRequests = taskProvider.pending;

          if (pendingRequests.isEmpty) {
            return Center(child: Text('No pending requests'));
          }

          return ListView.builder(
            itemCount: pendingRequests.length,
            itemBuilder: (context, index) {
              final request = pendingRequests[index];
              final int requestId = request.id ?? 0;
              String baseUrl = 'https://webpristine.com/cleanup/public';
              final profileImageUrl =
                  '${request.sender!.baseUrl}${request.sender!.image}';
              final imageProvider = (profileImageUrl == null)
                  ? AssetImage('assets/images/image27.png') as ImageProvider
                  : NetworkImage(profileImageUrl.toString()) as ImageProvider;

              bool isAcceptLoading = _acceptLoading[requestId] ?? false;
              bool isDeclineLoading = _declineLoading[requestId] ?? false;

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(6),
                  leading: CircleAvatar(
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.grey[300],
                  ),
                  title: Text(request.sender?.name ?? 'Unknown'),
                  subtitle: Text(request.sender?.username ?? 'No email'),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isAcceptLoading) _acceptRequest(requestId);
                        },
                        child: Container(
                          height: 24,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.rank1Color,
                          ),
                          child: Center(
                            child: isAcceptLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColor.backgroundcontainerColor,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
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
                      SizedBox(height: 3), // Add spacing between buttons
                      GestureDetector(
                        onTap: () {
                          if (!isDeclineLoading) _declineRequest(requestId);
                        },
                        child: Container(
                          height: 24,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.rank1Color,
                          ),
                          child: Center(
                            child: isDeclineLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColor.backgroundcontainerColor,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
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
