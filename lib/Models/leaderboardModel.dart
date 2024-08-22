class LeaderboardModel {
  bool? success;
  List<Leaderboard>? leaderboard;

  LeaderboardModel({this.success, this.leaderboard});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      success: json['success'],
      leaderboard: json['leaderboard'] != null
          ? (json['leaderboard'] as List)
              .map((item) => Leaderboard.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.leaderboard != null) {
      data['leaderboard'] = this.leaderboard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaderboard {
  String? point;
  dynamic user;
  dynamic task;

  Leaderboard({this.point, this.user, this.task});

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      point: json['point'],
      user: json['user'],
      task: json['task'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['point'] = this.point;
    data['user'] = this.user;
    data['task'] = this.task;
    return data;
  }
}
