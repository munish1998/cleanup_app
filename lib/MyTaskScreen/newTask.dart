// import 'package:cleanup_mobile/Providers/homeProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//  // Import your provider here

// class NewTsk extends StatefulWidget {
//   const NewTsk({super.key});

//   @override
//   State<NewTsk> createState() => _NewTskState();
// }

// class _NewTskState extends State<NewTsk> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TaskProviders>(context, listen: false).getMyTask(context: context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<TaskProviders>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: taskProvider.isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: taskProvider.mytask.length,
//               itemBuilder: (context, index) {
//                 final taskModel = taskProvider.mytask[index];
//                // final sharer = taskModel.tasks;
//                 return ListTile(
//                   leading: taskModel.tasks!.first.user!.image != null
//                       ? CircleAvatar(
//                           backgroundImage: NetworkImage(taskModel.tasks!.first.user!.image!),
//                         )
//                       : CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                 //  title: Text(sharer?.username ?? 'No username'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                     //  Text(sharer?.name ?? 'No name'),
//                    //   Text(sharer?.email ?? 'No email'),
//                    //   Text(sharer?.location ?? 'No location'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
