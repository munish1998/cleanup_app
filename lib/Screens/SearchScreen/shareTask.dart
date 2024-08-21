import 'dart:io';
import 'dart:developer';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class ShareTask extends StatefulWidget {
  String tasktitle;
  ShareTask({super.key, required this.tasktitle});

  @override
  State<ShareTask> createState() => _ShareTaskState();
}

class _ShareTaskState extends State<ShareTask> {
  int _selectedIndex = 0;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tasktitleController = TextEditingController();
  File? _beforeImage;
  File? _afterImage;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProviders>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text(
          widget.tasktitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, right: 15),
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
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, right: 15),
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
                    //  _showShareOptionsBottomSheet(context);
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

  void _saveTask(BuildContext context) async {
    final taskProvider = Provider.of<TaskProviders>(context, listen: false);
    final title = _tasktitleController.text.trim();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();

    // Validation checks
    if (location.isEmpty ||
        description.isEmpty ||
        _beforeImage == null ||
        _afterImage == null) {
      _showErrorSnackbar(
          context, 'Please fill in all fields and upload images.');
      return;
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userid = pref.getString(userIdKey);

    if (userid == null) {
      _showErrorSnackbar(context, 'User ID not found.');
      return;
    }

    bool success = await taskProvider.sharecreateTask(
        context: context,
        title: 'hello',
        userid: userid,
        location: location,
        description: description,
        beforeImage: _beforeImage!,
        afterImage: _afterImage!,
        sharetaskID: "31",
        status: '2');

    if (success) {
      navPush(context: context, action: LoginScreen());
      //  _showShareOptionsBottomSheet(context);
    } else {
      _showErrorSnackbar(context, 'Failed to create task.');
    }
  }

  void _showBottomSheet(BuildContext context, bool isBeforeImage) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  final pickedImage = await _pickImage(ImageSource.camera);
                  if (pickedImage != null) {
                    setState(() {
                      if (isBeforeImage) {
                        _beforeImage = pickedImage;
                      } else {
                        _afterImage = pickedImage;
                      }
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  final pickedImage = await _pickImage(ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      if (isBeforeImage) {
                        _beforeImage = pickedImage;
                      } else {
                        _afterImage = pickedImage;
                      }
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
