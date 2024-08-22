import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/Models/leaderboardModel.dart';
import 'package:cleanup_mobile/Providers/leaderboardProvider.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart'; // Adjust the import based on your project structure
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the LeaderboardProvider

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Fetch leaderboard data when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaderboardProvider>(context, listen: false)
          .fetchTasks(context: context);
    });
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
                onTap: () => Navigator.pop(context),
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
                    onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
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
                    borderRadius: BorderRadius.circular(25.0),
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
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
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
                        Tab(text: 'Region'),
                        Tab(text: 'National'),
                        Tab(text: 'Global'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    tabview(context),
                    tabview(context),
                    tabview(context),
                  ],
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

  Widget tabview(BuildContext context) {
    return Consumer<LeaderboardProvider>(
      builder: (context, provider, child) {
        if (provider.getLeaderboard.isEmpty) {
          return Center(child: Text('No leaderboard data available.'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            bool isWideScreen = constraints.maxWidth > 600;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWideScreen ? 3 : 1,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: provider.getLeaderboard.length,
              itemBuilder: (context, index) {
                var leaderboardItem = provider.getLeaderboard[index];
                return _buildLeaderboardItem(
                  height: isWideScreen ? 200 : 150,
                  rank: index + 1,
                  textColor: _getRankColor(index + 1),
                  containerColor: AppColor.backgroundcontainerColor,
                  dottedBorderColor: _getRankColor(index + 1),
                  imageAssetPath: 'assets/images/image30.png',
                  imageWidth: 90,
                  imageHeight: 90,
                  smallImageAssetPath: 'assets/images/image34.png',
                );
              },
            );
          },
        );
      },
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return AppColor.rank1Color;
      case 2:
        return AppColor.rank2Color;
      case 3:
        return AppColor.rank3Color;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLeaderboardItem({
    required int height,
    required int rank,
    required Color textColor,
    required Color containerColor,
    required Color dottedBorderColor,
    required String imageAssetPath,
    required double imageWidth,
    required double imageHeight,
    required String smallImageAssetPath,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height.toDouble(),
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
                        Text(
                          '@username $rank',
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
                            smallImageAssetPath,
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
