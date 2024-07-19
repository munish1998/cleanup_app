import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/image13.png'),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle cancel icon tap action here
                },
                icon: const Icon(
                  Icons.cancel,
                  color: AppColor.rank1Color,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 155, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade50,
                    ),
                    child: Stack(
                      children: [
                        // Profile image
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/image32.png', // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Camera icon
                        Positioned(
                          top: 40,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColor.rank1Color,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '@username',
                    style: TextStyle(
                        color: AppColor.rank1Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.3,
                    child: Container(
                      width: 370,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColor.rank1Color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'cleaning app',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.3,
                    child: Container(
                      width: 370,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: AppColor.rank1Color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '1234567893',
                              style: TextStyle(color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.3,
                    child: Container(
                      width: 370,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: AppColor.rank1Color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'xyz@gmail.com',
                              style: TextStyle(color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.3,
                    child: Container(
                      width: 370,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: AppColor.rank1Color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Date of birth',
                              style: TextStyle(color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.3,
                    child: Container(
                      width: 370,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.password_outlined,
                              color: AppColor.rank1Color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'passwords',
                              style: TextStyle(color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: AppColor.backgroundcontainerColor,
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: 920,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: AppColor.rank1Color,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    const Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // Replace the existing text with TextFormField widgets
                                    Column(
                                      children: [
                                        Card(
                                          color:
                                              AppColor.backgroundcontainerColor,
                                          elevation: 0.3,
                                          child: TextFormField(
                                            initialValue:
                                                'cleaning app', // Initial value of the field
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: AppColor.rank1Color,
                                              ),
                                              labelText: 'Username',
                                              border: OutlineInputBorder(),
                                            ),
                                            // You can bind controllers to capture user input
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Card(
                                          color:
                                              AppColor.backgroundcontainerColor,
                                          elevation: 0.3,
                                          child: TextFormField(
                                            initialValue:
                                                '1234567893', // Initial value of the field
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.phone,
                                                color: AppColor.rank1Color,
                                              ),
                                              labelText: 'Phone',
                                              border: OutlineInputBorder(),
                                            ),
                                            // You can bind controllers to capture user input
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Card(
                                          color:
                                              AppColor.backgroundcontainerColor,
                                          elevation: 0.3,
                                          child: TextFormField(
                                            initialValue:
                                                'xyz@gmail.com', // Initial value of the field
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.email_outlined,
                                                color: AppColor.rank1Color,
                                              ),
                                              labelText: 'Email',
                                              border: OutlineInputBorder(),
                                            ),
                                            // You can bind controllers to capture user input
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Card(
                                          color:
                                              AppColor.backgroundcontainerColor,
                                          elevation: 0.3,
                                          child: TextFormField(
                                            initialValue:
                                                '', // Initial value of the field
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.calendar_month,
                                                color: AppColor.rank1Color,
                                              ),
                                              labelText: 'Date of Birth',
                                              border: OutlineInputBorder(),
                                            ),
                                            // You can bind controllers to capture user input
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    // Add a button to save changes
                                    Center(
                                      child: Container(
                                        width: 350,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: AppColor.rank1Color,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Save',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Container(
                        width: 350,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColor.rank1Color,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
