import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart'; // Assuming this file has your color constants

class RequestSendList extends StatefulWidget {
  const RequestSendList({super.key});

  @override
  State<RequestSendList> createState() => _RequestSendListState();
}

class _RequestSendListState extends State<RequestSendList> {
  @override
  void initState() {
    super.initState();
    // Fetch the request send list when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getrequestsendList(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Text('Request Send List'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, taskProvider, child) {
          if (taskProvider.requestsendlist.isEmpty) {
            return Center(child: Text('No requests found'));
          }

          return ListView.builder(
            itemCount: taskProvider.requestsendlist.length,
            itemBuilder: (context, index) {
              final request = taskProvider.requestsendlist[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: request.sender!.image != null
                      ? NetworkImage(
                          '${request.sender!.baseUrl}${request.receiver!.image}', // Make sure the image URL is correct
                        )
                      : AssetImage('assets/images/image29.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey[300],
                  child: request.sender!.image == null
                      ? Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                title: Text(request.receiver!.name ?? 'Unknown'),
                subtitle: Text(request.receiver!.email ?? 'No email'),
                // trailing: Text(request.status),
                onTap: () {
                  // Handle tap if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}
