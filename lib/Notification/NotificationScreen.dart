import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      appBar: AppBar(
        title: Center(child: Text('Notifications')),
        actions: [
          Icon(
            Icons.person,
            color: AppColor.rank1Color,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: TextStyle(color: Colors.black),
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(23, 196, 52, 0.1)),
                    child: Center(child: Icon(Icons.check)),
                  ),
                  title: Text('you have completed your target'),
                  subtitle: Text('Sam challenged you'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(225, 9, 9, 0.1)),
                    child: Center(child: Icon(Icons.check)),
                  ),
                  title: Text('you have completed your target'),
                  subtitle: Text('Sam challenged you'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(201, 170, 7, 0.1)),
                    child: Center(child: Icon(Icons.check)),
                  ),
                  title: Text('you have completed your target'),
                  subtitle: Text('Sam challenged you'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Yesterday',
                style: TextStyle(color: Colors.black),
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(23, 196, 52, 0.1)),
                    child: Center(child: Icon(Icons.check)),
                  ),
                  title: Text('you have completed your target'),
                  subtitle: Text('Sam challenged you'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(225, 9, 9, 0.1)),
                    child: Center(child: Icon(Icons.check)),
                  ),
                  title: Text('you have completed your target'),
                  subtitle: Text('Sam challenged you'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //  borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(201, 170, 7, 0.1)),
                    child: Center(child: Icon(Icons.check)),
                  ),
                  title: Text('you have completed your target'),
                  subtitle: Text('Sam challenged you'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
