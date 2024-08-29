import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Models/NotificationModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when the screen is initialized
    Provider.of<TaskProviders>(context, listen: false)
        .fetchNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: Center(child: Text('Notifications')),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.notifications.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...provider.notifications.reversed
                      .map((notification) => Card(
                            elevation: 1,
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: notification.type == 'share_task'
                                      ? Color.fromRGBO(23, 196, 52, 0.1)
                                      : notification.type == 'completed_task'
                                          ? Color.fromRGBO(225, 9, 9, 0.1)
                                          : Color.fromRGBO(201, 170, 7, 0.1),
                                ),
                                child: Center(child: Icon(Icons.check)),
                              ),
                              title: Text(notification.title ?? 'No title'),
                              subtitle: Text(
                                  notification.createdAt.toString() ??
                                      'No body'),
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
