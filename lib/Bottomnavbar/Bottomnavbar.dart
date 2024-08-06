import 'package:cleanup_mobile/FriendslistScreen/FriendsList.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/LeaderboardScreen/LeaderScreen.dart';
import 'package:cleanup_mobile/ProfileScreen/ProfileScreen.dart';
import 'package:cleanup_mobile/Screens/SearchScreen/SearchScreen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                onItemTapped(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Image.asset(
                selectedIndex == 0
                    ? 'assets/images/image23.png'
                    : 'assets/images/image23.png',
                width: 24, // Adjust width as needed
                height: 24, // Adjust height as needed
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Image.asset(
                selectedIndex == 1
                    ? 'assets/images/image24.png'
                    : 'assets/images/image24.png',
                width: 24, // Adjust width as needed
                height: 24, // Adjust height as needed
              ),
            ),
            SizedBox(
              width: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderBoardScreen()),
                );
              },
              child: Image.asset(
                selectedIndex == 2
                    ? 'assets/images/image25.png'
                    : 'assets/images/image25.png',
                width: 24, // Adjust width as needed
                height: 24, // Adjust height as needed
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 254,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel,
                                    color: Colors.lightBlue.shade300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          const Row(
                            children: [
                              Icon(Icons.person, color: Colors.black),
                              SizedBox(width: 6),
                              Text(
                                'Profiles',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          _buildMenuItem(
                              Icons.account_circle, 'Account Details', context),
                          SizedBox(height: 10),
                          _buildMenuItem(Icons.people, 'Friends List', context),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                selectedIndex == 3
                    ? 'assets/images/image26.png'
                    : 'assets/images/image26.png',
                width: 24, // Adjust width as needed
                height: 24, // Adjust height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the bottom sheet
        if (text == 'Account Details') {
          // Open bottom sheet for Account Details
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SizedBox(
                height: 857,
                child: ProfileScreen(),
              );
            },
          );
        } else if (text == 'Friends List') {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
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
          SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
