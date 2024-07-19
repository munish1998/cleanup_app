import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                    width: 10), // Add space between arrow back and TextField
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColor.backgroundcontainerColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 140,
            ),
            Center(
              child: Center(child: Image.asset('assets/images/image29.png')),
            )
          ],
        ),
      ),
    );
  }
}
