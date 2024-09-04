const String placeHolder =
    'https://research.cbc.osu.edu/sokolov.8/wp-content/uploads/2017/12/profile-icon-png-898.png';

class ApiServices {
  static const String baseUrl = 'https://webpristine.com/cleanup/public';

  static const String imageBaseUrl = baseUrl;

  // static const String baseUrl = 'http://lot.alobhadev.com/';

  //------------------------- Apis -----------------------------
  static const String register = '${baseUrl}/api/auth/register';
  static const String login = '${baseUrl}/api/auth/login';
  static const String sendOtp = '${baseUrl}/api/auth/send-otp';
  static const String verifyOtp = '${baseUrl}/api/auth/verify-otp';
  static const String forgotPass = '${baseUrl}/api/auth/reset-password';
  static const String logOut = '${baseUrl}/api/auth/logout';
  static const String updatedeviceToken = '${baseUrl}/api/auth/update-token';
  static const String createTask = '${baseUrl}/api/auth/task/create-task';
  static const String getmytaskList = '${baseUrl}/api/auth/task/my-task';
  static const String getallUser = '${baseUrl}/api/auth/non-friends';
  static const String sendfreindRequest = '${baseUrl}/api/auth/friend-request';
  static const String pendingRequest = '${baseUrl}/api/auth/pending-requests';
  static const String incomingTask = '${baseUrl}/api/auth/task/incoming-tasks';
  static const String updateProfileBG = '${baseUrl}/api/auth/profile/bgimage';
  static const String updateProfileIMG = '${baseUrl}/api/auth/profile/image';
  static const String acceptRequest =
      '${baseUrl}/api/auth/friend-request/2/accept';
  static const String declineRequest =
      '${baseUrl}/api/auth/friend-request/1/decline';
  static const String getprofileDetails = '${baseUrl}/api/auth/profile/details';
  static const String editProfile = '${baseUrl}/api/auth/profile/update';
  static const String myFreinds = '${baseUrl}/api/auth/friends';
  static String acceptTask(String shareId) =>
      '$baseUrl/api/auth/task/accept/$shareId';
  // static const String acceptTask = '${baseUrl}/api/auth/task/accept/$shareId';
  static const String socialLogin = '${baseUrl}/api/auth/social-login';
  static const String socialSignup = '${baseUrl}/api/auth/social-signup';
  static const String getrequestsendList = '${baseUrl}/api/auth/sent-requests';
  static const String getsharetaskList =
      '${baseUrl}/api/auth/task/shared-task-users';
  static const String getLeaderboard = '${baseUrl}/api/auth/leaderboard';
  static const String reportUser = '${baseUrl}/api/auth/report';
  static const String blockUser = '${baseUrl}/api/auth/block';
  static const String privacyPolicy = '${baseUrl}user/privacy_policy';
  static const String getNotification = '${baseUrl}/api/auth/notification/list';
  static const String exercises = '${baseUrl}user/exercises';
}
