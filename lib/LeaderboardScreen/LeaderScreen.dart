import 'package:cleanup_mobile/Bottomnavbar/Bottomnavbar.dart';
import 'package:cleanup_mobile/Models/leaderboardModel.dart';
import 'package:cleanup_mobile/NewTaskScreen/NewTaskScreen.dart';
import 'package:cleanup_mobile/Providers/leaderboardProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 253, 255),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            color: AppColor.leaderboardtextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
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
        },
      ),
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
      ),
    );
  }

  Widget tabview(BuildContext context) {
    return Consumer<LeaderboardProvider>(
      builder: (context, provider, child) {
        if (provider.getLeaderboard.isEmpty) {
          return Center(child: Text('No leaderboard data available.'));
        }

        // Separate the top 3 users and the rest
        List<Leaderboard> top3 = provider.getLeaderboard.take(3).toList();
        List<Leaderboard> rest = provider.getLeaderboard.skip(3).toList();

        return Column(
          children: [
            _buildTop3Row(top3),
            Expanded(
              child: ListView.builder(
                itemCount: rest.length,
                itemBuilder: (context, index) {
                  var leaderboardItem = rest[index];
                  return _buildLeaderboardListItem(
                    rank: index + 4,
                    username: leaderboardItem.user!.name.toString(),
                    points: leaderboardItem.point.toString(),
                    imageUrl:
                        '${leaderboardItem.user!.baseUrl}${leaderboardItem.user!.image}',
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTop3Row(List<Leaderboard> top3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(top3.length, (index) {
        var item = top3[index];
        return Expanded(
          child: _buildLeaderboardItem(
            height: 200,
            rank: index + 1,
            username: item.user!.name.toString(),
            points: item.point.toString(),
            textColor: _getRankColor(index + 1),
            containerColor: AppColor.backgroundcontainerColor,
            dottedBorderColor: _getRankColor(index + 1),
            imageUrl:
                '${item.user!.baseUrl}${item.user!.image}', // Pass the full image URL
            imageWidth: 90,
            imageHeight: 90,
          ),
        );
      }),
    );
  }

  Widget _buildLeaderboardListItem({
    required int rank,
    required String username,
    required String points,
    required String? imageUrl, // Use imageUrl instead of imageAssetPath
  }) {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
              ? NetworkImage(imageUrl)
              : AssetImage('assets/images/default_image.png') as ImageProvider,
        ),
      ),
      title: Text(username),
      subtitle: Text('Points: $points'),
      trailing: Text('Rank: $rank'),
    );
  }

  Widget _buildLeaderboardItem({
    required int height,
    required int rank,
    required String username,
    required String points,
    required Color textColor,
    required Color containerColor,
    required Color dottedBorderColor,
    required String? imageUrl,
    required double imageWidth,
    required double imageHeight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height.toDouble(),
        child: Stack(
          children: [
            // Rank balloon shape

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
                          '$username',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          points,
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
                child: ClipOval(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Stack(
                      children: [
                        (imageUrl != null && imageUrl.isNotEmpty)
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: imageWidth,
                                height: imageHeight,
                              )
                            : Image.asset(
                                'assets/images/default_image.png',
                                fit: BoxFit.cover,
                                width: imageWidth,
                                height: imageHeight,
                              ),
                        Positioned(
                          left: 35,
                          top: 70,
                          child: Container(
                            height: 20,
                            width: 20,
                            // height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getRankColor(rank),
                            ),
                            child: Center(
                              child: Text(
                                '$rank',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
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
      ),
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
        return AppColor.rank3Color;
    }
  }
}
