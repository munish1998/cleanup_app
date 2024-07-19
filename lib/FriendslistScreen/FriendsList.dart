import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Friends',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColor.rank1Color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 66,
                    width: 360,
                    child: Card(
                      color: AppColor.backgroundcontainerColor,
                      elevation: 0.2,
                      child: ListTile(
                        leading: Image.asset('assets/images/image11.png'),
                        title: const Text(
                          '@username',
                          style: TextStyle(
                            color: Color.fromARGB(159, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text('task title name'),
                        trailing: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColor.rank1Color,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: AppColor.backgroundcontainerColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
