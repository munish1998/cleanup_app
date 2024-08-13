import 'package:flutter/material.dart';

class MyTask extends StatelessWidget {
  const MyTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Blue container at the top
              Container(
                color: Colors.blue,
                width: double.infinity,
                height: MediaQuery.of(context).size.height /
                    6, // Adjust height as needed
                child: Center(
                  child: Container(
                    child: Text(
                      'My Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Container for CircleAvatar, username, and rank
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // CircleAvatar at the top center
                    CircleAvatar(
                      radius: 50, // Adjust size as needed
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150', // Replace with your image URL
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Username and rank
                    Text(
                      'Username', // Replace with actual username
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rank', // Replace with actual rank
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Container for title, description, and images
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Container(
                      width: 290,
                      height: 90,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Title', // Replace with actual title
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Description
                    Container(
                      width: 290,
                      height: 90,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Description', // Replace with actual description
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Row for before and after images
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 100, // Fixed height for square shape
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Placeholder color
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child:
                                  Text('Before', textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0), // Space between images
                        Expanded(
                          child: Container(
                            height: 100, // Fixed height for square shape
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Placeholder color
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text('After', textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
