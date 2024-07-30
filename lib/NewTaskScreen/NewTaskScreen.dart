import 'dart:io';
import 'dart:developer';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/block/taskblock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/ProfileScreen/ProfileScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  int _selectedIndex = 0;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _beforeImage;
  File? _afterImage;
  File? _selectedImage;
  File? _selectImage1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 248, 253, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 253, 255),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          'New Task',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
              ),
            ),
          ),
        ],
      ),
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 0.2,
              child: Container(
                height: 90,
                width: 390,
                decoration: BoxDecoration(
                  color: AppColor.backgroundcontainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColor.rank1Color,
                          ),
                          const Text(
                            'Location',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          hintText: 'Add location',
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 0.2,
              child: Container(
                height: 90,
                width: 390,
                decoration: BoxDecoration(
                  color: AppColor.backgroundcontainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.description,
                            color: AppColor.rank1Color,
                          ),
                          const Text(
                            'Add Description',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Add description',
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 0.3,
                    child: GestureDetector(
                      onTap: () {
                        _showBottomSheet(context, true);
                      },
                      child: Container(
                        height: 153,
                        decoration: BoxDecoration(
                          color: AppColor.backgroundcontainerColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Before',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 12),
                            _beforeImage != null
                                ? Image.file(
                                    _beforeImage!,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                  ),
                          ],
                        ),
                      ),
                    ),
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
                      children: [
                        const Text(
                          'After',
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 12),
                        _afterImage != null
                            ? Image.file(
                                _afterImage!,
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, false);
                                },
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  _saveTask(context);
                },
                child: Container(
                  height: 54,
                  width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.rank1Color,
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.backgroundcontainerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateTask()),
            );
          },
          backgroundColor: Colors.blue.shade200,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          shape: const CircleBorder(),
        ),
      ),
    );
  }

  void _saveTask(BuildContext context) {
    final title = 'my task'; // Get this from your input field
    final location = _locationController.text;
    final description = _descriptionController.text;

    Provider.of<TaskProviders>(context, listen: false).createTask(
      context: context,
      title: title,
      userid: '11',
      location: location,
      description: description,
      beforeImage: _beforeImage,
      afterImage: _afterImage,
    );
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
            },
          );
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

  Future<void> _showBottomSheet(
      BuildContext context, bool isBeforeImage) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text('Choose Image'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              getPicker(ImageSource.camera, isBeforeImage);
              Navigator.pop(context);
            },
            child: Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              getPicker(ImageSource.gallery, isBeforeImage);
              Navigator.pop(context);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  Future<void> getPicker(ImageSource imageSource, bool isBeforeImage) async {
    try {
      XFile? image = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (image != null) {
        setState(() {
          if (isBeforeImage) {
            _beforeImage = File(image.path); // Set before image
          } else {
            _afterImage = File(image.path); // Set after image
          }
          log('Selected image path: ${image.path}');
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
