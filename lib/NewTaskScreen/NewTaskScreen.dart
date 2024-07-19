import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/ProfileScreen/ProfileScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewTask> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 253, 255),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 248, 253, 255),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            centerTitle: true,
            title: const Text(
              'New Task',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                    onTap: () {
                      // _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/image28.png',
                      color: Colors.black,
                    )),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Title',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 0.2,
                child: Container(
                    height: 90,
                    width: 390,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundcontainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColor.rank1Color,
                              ),
                              Text(
                                'Location',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: 'Add loaction',
                                border: InputBorder.none),
                          )
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 0.2,
                child: Container(
                    height: 90,
                    width: 390,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundcontainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColor.rank1Color,
                              ),
                              Text(
                                'Add Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: 'Add description',
                                border: InputBorder.none),
                          )
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0.3,
                      child: Container(
                          height: 153,
                          width: 185,
                          decoration: BoxDecoration(
                            color: AppColor.backgroundcontainerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Before',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.grey,
                              ),
                            ],
                          )),
                    ),
                  ),
                  Card(
                    elevation: 0.3,
                    child: Container(
                        height: 153,
                        width: 185,
                        decoration: BoxDecoration(
                          color: AppColor.backgroundcontainerColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'After',
                              style: TextStyle(
                                // color: Colors.black,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showImagePickerDialog(context);
                              },
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 54,
                  width: 390,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.rank1Color),
                  child: const Center(
                      child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.backgroundcontainerColor,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(25.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewTask()));
            },
            backgroundColor: Colors.blue.shade200,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
            shape: const CircleBorder(),
          ),
        ));
  }

  Widget _buildMenuItem(IconData icon, String text, BuildContext context,
      void Function() param3) {
    return GestureDetector(
      onTap: () {
        // Handle tap on menu item
        Navigator.pop(context); // Close the bottom sheet
        if (text == 'Account Details') {
          // Open bottom sheet for Account Details
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const SizedBox(
                height: 857,
                child: ProfileScreen(),
              );
            },
          );
        } else if (text == 'Friends List') {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const SizedBox(
                  height: 750,
                  child: FriendListScreen(),
                );
              });
          // Handle other menu items here
        }
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.blue,
          ),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMenuItem(
                Icons.photo_library,
                'Gallery',
                context,
                () => _openGallery(context),
              ),
              _buildMenuItem(
                Icons.camera_alt,
                'Camera',
                context,
                () => _openCamera(context),
              ),
            ],
          ),
        );
      },
    );
  }

// Function to open the gallery
  void _openGallery(BuildContext context) {
    // Implement the code to open the gallery here
  }

// Function to open the camera
  void _openCamera(BuildContext context) {
    // Implement the code to open the camera here
  }
}
