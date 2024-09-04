import 'dart:io';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/profileProivder.dart';
import 'package:cleanup_mobile/Models/profileModel.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/ProfileScreen/editProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile; // For profile image
  File? _backgroundImageFile; // For background image

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false)
          .getmyProfile(context: context);
    });
  }

  Future<void> _showImageSourceSheet({required bool isBackgroundImage}) async {
    showModalBottomSheet(
      backgroundColor: AppColor.backgroundcontainerColor,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height *
                0.2, // Adjusted for responsiveness
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, color: AppColor.rank1Color),
                  title: Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 100,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        if (isBackgroundImage) {
                          _backgroundImageFile = File(pickedFile.path);
                        } else {
                          _imageFile = File(pickedFile.path);
                        }
                      });
                      if (isBackgroundImage) {
                        await _updateProfileBG(File(pickedFile.path));
                      } else {
                        await _updateProfileImage(File(pickedFile.path));
                      }
                    }
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.photo_library, color: AppColor.rank1Color),
                  title: Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 100,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        if (isBackgroundImage) {
                          _backgroundImageFile = File(pickedFile.path);
                        } else {
                          _imageFile = File(pickedFile.path);
                        }
                      });
                      if (isBackgroundImage) {
                        await _updateProfileBG(File(pickedFile.path));
                      } else {
                        await _updateProfileImage(File(pickedFile.path));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateProfileImage(File imageFile) async {
    try {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      bool success = await profileProvider.updateProfileIMG(
          context: context, imageFile: imageFile);
      if (success) {
        setState(() {
          _imageFile = null; // Clear local image file after successful upload
        });
      }
    } catch (e) {
      print("Error updating profile image: $e");
    }
  }

  Future<void> _updateProfileBG(File imageFile) async {
    try {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      bool success = await profileProvider.updateProfileBG(
          context: context, imageFile: imageFile);
      if (success) {
        setState(() {
          _backgroundImageFile =
              null; // Clear local background image file after successful upload
        });
      }
    } catch (e) {
      print("Error updating profile background image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        var profile = profileProvider.myProfile;

        // Ensure profile is not null and has data
        if (profile == null) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 253, 255),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        var data = profile;

        return Scaffold(
          backgroundColor: Color.fromARGB(255, 248, 253, 255),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // Background image with height constraint
                  Container(
                    height: constraints.maxHeight * 0.3, // Responsive height
                    width: double.infinity,
                    child: _backgroundImageFile != null
                        ? Image.file(
                            _backgroundImageFile!,
                            fit: BoxFit.cover,
                          )
                        : data.bgimage != null
                            ? Image.network(
                                '${data.base_url}${data.bgimage}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(); // Placeholder in case of error
                                },
                              )
                            : Image.asset(
                                'assets/images/image13.png', // Placeholder image
                                fit: BoxFit.cover,
                              ),
                  ),
                  Positioned(
                      top: constraints.maxHeight * 0.02,
                      left: constraints.maxWidth * 0.02,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              navPushReplace(
                                  context: context, action: HomeScreen());
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: AppColor.rank1Color,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _showImageSourceSheet(isBackgroundImage: true);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.rank1Color,
                              size: 30,
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.23,
                      left: constraints.maxWidth * 0.03,
                      right: constraints.maxWidth * 0.03,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: constraints.maxWidth * 0.2,
                            width: constraints.maxWidth * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blue.shade50,
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: _imageFile != null
                                        ? Image.file(
                                            _imageFile!,
                                            fit: BoxFit.cover,
                                          )
                                        : data.image != null
                                            ? Image.network(
                                                '${data.base_url}${data.image}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(); // Placeholder in case of error
                                                },
                                              )
                                            : Container(), // Placeholder if profile image is not available
                                  ),
                                ),
                                Positioned(
                                  top: constraints.maxWidth * 0.1,
                                  right: constraints.maxWidth * 0.00002,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showImageSourceSheet(
                                          isBackgroundImage: false);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColor.rank1Color,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildProfileCard(
                              context, Icons.person, data.username),
                          _buildProfileCard(context, Icons.person, data.name),
                          _buildProfileCard(
                              context, Icons.email_outlined, data.email),
                          _buildProfileCard(context, Icons.phone, data.mobile),
                          _buildProfileCard(
                              context, Icons.phone, data.location),
                          _buildProfileCard(
                              context,
                              Icons.calendar_month,
                              data.dob != null
                                  ? data.dob.toString()
                                  : 'YY-MM-YY'),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              navPush(
                                  context: context,
                                  action: EditProfileScreen());
                            },
                            child: Center(
                              child: Container(
                                height: 44,
                                width: constraints.maxWidth * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: AppColor.rank1Color,
                                ),
                                child: const Center(
                                    child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(BuildContext context, IconData icon, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: AppColor.rank1Color,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
