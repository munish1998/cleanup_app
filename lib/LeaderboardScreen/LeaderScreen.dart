import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({
    super.key,
  });

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List<String> pokemons = [
    'pikachu',
    'charmander',
  ];
  List<String> fruits = [
    'apple',
    'banana',
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 253, 255),
        appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            centerTitle: true,
            title: const Text(
              'Leaderboard',
              style: TextStyle(
                  color: AppColor.leaderboardtextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Image.asset(
                      'assets/images/image28.png',
                      color: Colors.black,
                    )),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 0.2,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.backgroundcontainerColor,
                    //border: Border.all(color: const Color(0xff323232), width: 2),
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme.copyWith(
                        surfaceVariant: Colors.transparent,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorPadding: const EdgeInsets.all(8),
                      indicatorSize: TabBarIndicatorSize.tab,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: AppColor.rank1Color,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      labelStyle: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Region',
                        ),
                        Tab(
                          text: 'National',
                        ),
                        Tab(
                          text: 'Global',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  tabview(),
                  tabview(),
                  tabview(),
                ],
              ))
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
                  MaterialPageRoute(builder: (context) => const CreateTask()));
            },
            backgroundColor: AppColor.rank1Color,
            child: const Icon(
              Icons.add,
              color: AppColor.backgroundcontainerColor,
              size: 40,
            ),
            shape: const CircleBorder(),
          ),
        ));
  }

  Widget tabview() {
    List<String> imagePaths = [
      'assets/images/image35.png',
      'assets/images/image36.png'
    ];
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLeaderboardItem(
                    height: 180,
                    rank: 2,
                    textColor: AppColor.rank2Color,
                    containerColor: AppColor.backgroundcontainerColor,
                    dottedBorderColor: AppColor.rank2Color,
                    imageAssetPath: 'assets/images/image30.png',
                    imageHeight: 90,
                    imageWidth: 90,
                    smallImageAssetPath: 'assets/images/image34.png'),
                _buildLeaderboardItem(
                    height: 180,
                    rank: 1,
                    textColor: AppColor.rank1Color,
                    containerColor: AppColor.backgroundcontainerColor,
                    dottedBorderColor: AppColor.rank1Color,
                    imageAssetPath: 'assets/images/image37.png',
                    imageHeight: 90,
                    imageWidth: 90,
                    smallImageAssetPath: 'assets/images/image35.png'),
                _buildLeaderboardItem(
                    height: 180,
                    rank: 3,
                    textColor: AppColor.rank3Color,
                    containerColor: AppColor.backgroundcontainerColor,
                    dottedBorderColor: AppColor.rank3Color,
                    imageAssetPath: 'assets/images/image27.png',
                    imageHeight: 90,
                    imageWidth: 90,
                    smallImageAssetPath: 'assets/images/image36.png')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: AppColor.backgroundcontainerColor,
              padding: EdgeInsets.zero,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    color: AppColor.backgroundcontainerColor,
                    child: Card(
                      color: AppColor.backgroundcontainerColor,
                      elevation: 0.1,
                      child: SizedBox(
                        height: 75,
                        child: ListTile(
                            leading: Image.asset('assets/images/image11.png'),
                            title: const Text(
                              '@Username',
                              style: TextStyle(
                                  color: Color.fromARGB(159, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text('Take the title name'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '4222',
                                  style: TextStyle(
                                      color: AppColor.rank1Color,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 40,
                                  color: Colors.blue.shade200,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.1,
                    child: SizedBox(
                      height: 75,
                      child: ListTile(
                          leading: Image.asset('assets/images/image11.png'),
                          title: const Text(
                            '@Username',
                            style: TextStyle(
                                color: Color.fromARGB(159, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Take the title name'),
                          trailing: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '4222',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 40,
                                color: Colors.red,
                              )
                            ],
                          )),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.1,
                    child: SizedBox(
                      height: 75,
                      child: ListTile(
                          leading: Image.asset('assets/images/image11.png'),
                          title: const Text(
                            '@Username',
                            style: TextStyle(
                                color: Color.fromARGB(159, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Take the title name'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '4222',
                                style: TextStyle(
                                    color: AppColor.rank1Color,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 40,
                                color: Colors.blue.shade200,
                              )
                            ],
                          )),
                    ),
                  ),
                  Card(
                    color: AppColor.backgroundcontainerColor,
                    elevation: 0.1,
                    child: SizedBox(
                      height: 75,
                      child: ListTile(
                          leading: Image.asset('assets/images/image11.png'),
                          title: const Text(
                            '@Username',
                            style: TextStyle(
                                color: Color.fromARGB(159, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Take the title name'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '4222',
                                style: TextStyle(
                                    color: AppColor.rank1Color,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 40,
                                color: Colors.blue.shade200,
                              )
                            ],
                          )),
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

  // Widget _buildLeaderboardItem({
  //   required int height,
  //   required int rank,
  //   required Color textColor,
  //   required Color containerColor,
  //   required Color dottedBorderColor,
  // }) {
  //   return SizedBox(
  //     height: height.toDouble(),
  //     width: 117,
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           top: 0,
  //           left: 12,
  //           child: Card(
  //             elevation: 10,
  //             child: Container(
  //               width: 117,
  //               height: 154,
  //               decoration: BoxDecoration(
  //                 color: Colors.green,
  //                 // color: containerColor,
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(top: 100),
  //                 child: Column(
  //                   // mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     const Text(
  //                       '@username',
  //                       style: TextStyle(color: AppColor.leaderboardtextColor),
  //                     ),
  //                     Text(
  //                       '12345678',
  //                       style: TextStyle(color: textColor),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           // bottom: 0,
  //           top: 10,
  //           left: 21,
  //           child: DottedBorder(
  //             color: dottedBorderColor,
  //             strokeWidth: 1,
  //             borderType: BorderType.Circle,
  //             child: Container(
  //               width: 90,
  //               height: 90,
  //               decoration: BoxDecoration(
  //                 color: Colors.green,
  //                 borderRadius: BorderRadius.circular(100),
  //               ),
  //               child: Stack(
  //                 children: [
  //                   Image.asset(
  //                     'assets/images/image11.png',
  //                     fit: BoxFit.contain,
  //                     height: double.infinity,
  //                     width: double.infinity,
  //                   ),
  //                   Positioned(
  //                     left: 30,
  //                     top: 65,
  //                     child: Container(
  //                       height: 30,
  //                       width: 30,
  //                       decoration: BoxDecoration(
  //                         color: textColor,
  //                         borderRadius: const BorderRadius.only(
  //                           bottomLeft: Radius.circular(105),
  //                           bottomRight: Radius.circular(105),
  //                         ),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           rank.toString(),
  //                           style: const TextStyle(
  //                             color: Colors.white,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildLeaderboardItem({
    required int height,
    required int rank,
    required Color textColor,
    required Color containerColor,
    required Color dottedBorderColor,
    required String imageAssetPath,
    required double imageWidth,
    required double imageHeight,
    required String smallImageAssetPath, // Add this parameter
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height.toDouble(),
        width: 117,
        child: Stack(
          children: [
            Positioned.fill(
              child: Card(
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '@username',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '12345678',
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 0,
              child: DottedBorder(
                color: dottedBorderColor,
                strokeWidth: 1,
                borderType: BorderType.Circle,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        imageAssetPath,
                        fit: BoxFit.cover,
                        width: imageWidth,
                        height: imageHeight,
                      ),
                      Positioned(
                        left: 30,
                        top: 60,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            smallImageAssetPath, // Use the small image path here
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                          ),
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
    );
  }
}

class MirroredWaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.8, size.width, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.2, size.width / 2, 0);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.2, 0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.8, size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
