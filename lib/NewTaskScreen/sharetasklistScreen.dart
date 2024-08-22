import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart'; // Import your provider
import 'package:cleanup_mobile/Models/sharetaskModel.dart'; // Import your ShareTaskModel
import 'package:cleanup_mobile/NewTaskScreen/sharetaskdetailScreen.dart'; // Import the detail screen
import 'package:cleanup_mobile/Utils/AppConstant.dart'; // Import your constants

const String baseUrl = 'https://webpristine.com/cleanup/public/';

class ShareTaskScreen extends StatefulWidget {
  const ShareTaskScreen({super.key});

  @override
  State<ShareTaskScreen> createState() => _ShareTaskScreenState();
}

class _ShareTaskScreenState extends State<ShareTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProviders>(context, listen: false)
          .getsharetaskList(context: context, taskId: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.rank1Color,
        title: const Text('Shared Task List'),
      ),
      body: Consumer<TaskProviders>(
        builder: (context, provider, child) {
          if (provider.sharetasklist.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.sharetasklist.length,
            itemBuilder: (context, index) {
              final shareTask = provider.sharetasklist[index];

              // Construct the image URL
              final imageUrl = (shareTask.user?.image != null &&
                      shareTask.user!.image!.isNotEmpty)
                  ? '${shareTask.user!.baseUrl}${shareTask.user!.image}'
                  : 'assets/images/image27.png'; // Fallback placeholder image

              // Determine the image provider
              final imageProvider = imageUrl.startsWith('http')
                  ? NetworkImage(imageUrl) as ImageProvider<
                      Object> // Explicit cast to ImageProvider<Object>
                  : AssetImage(imageUrl) as ImageProvider<
                      Object>; // Explicit cast to ImageProvider<Object>

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.grey[300],
                  ),
                  title: Text(shareTask.user?.name ?? 'Unknown User'),
                  subtitle: Text(shareTask.user?.email ?? 'No Email'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text('View'),
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
