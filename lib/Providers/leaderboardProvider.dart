import 'dart:convert';
import 'dart:developer';
import 'package:cleanup_mobile/Models/leaderboardModel.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LeaderboardProvider with ChangeNotifier {
  List<Leaderboard> _getLeaderboard = [];
  List<Leaderboard> get getLeaderboard => _getLeaderboard;

  Future<void> fetchTasks({required BuildContext context}) async {
    notifyListeners();

    final url = Uri.parse(ApiServices.getLeaderboard);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      log('leaderboard response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final leaderboardModel = LeaderboardModel.fromJson(result);

        // Convert points to int and sort by points in descending order
        final leaderboardList = leaderboardModel.leaderboard ?? [];
        leaderboardList.sort((a, b) => int.parse(b.point.toString())
            .compareTo(int.parse(a.point.toString())));

        // Store all leaderboard entries
        _getLeaderboard = leaderboardList;

        // Notify listeners after fetching and processing data
        notifyListeners();
      } else {
        customToast(context: context, msg: 'Server error', type: 0);
      }
    } catch (e) {
      log('Error: $e');
      customToast(context: context, msg: 'An error occurred', type: 0);
    } finally {
      notifyListeners();
    }
  }
}
