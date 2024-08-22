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
  static const String getrequestsendList = '${baseUrl}/api/auth/sent-requests';
  static const String getsharetaskList =
      '${baseUrl}/api/auth/task/shared-task-users';
  static const String getLeaderboard = '${baseUrl}/api/auth/leaderboard';
  static const String privacyPolicy = '${baseUrl}user/privacy_policy';
  static const String levels = '${baseUrl}user/levels';
  static const String exercises = '${baseUrl}user/exercises';
  static const String subscription = '${baseUrl}user/subscriptions';
  static const String contactUs = '${baseUrl}user/add_contact_enquiry';
  static const String practiceCategory = '${baseUrl}user/practice_categories';
  static const String practices = '${baseUrl}user/practices';
  static const String allUsers = '${baseUrl}user/users';
  static const String followUnfollow = '${baseUrl}user/follower_api';
  static const String completeExercise = '${baseUrl}user/complete_exercise';
  static const String getUsersProfile = '${baseUrl}user/user_profile';
  static const String getRewards = '${baseUrl}user/rewards';
  static const String getQueries = '${baseUrl}user/enquiry_types';
  // static const String getLeaderboard = '${baseUrl}user/leaderboard';
  static const String getPersonalizeCard = '${baseUrl}user/personlized_cards';
  static const String getLocation = '${baseUrl}user/locations';
  static const String getNotification = '${baseUrl}user/notifications';
  static const String challengeUser = '${baseUrl}user/challenge_to_user';
  static const String getChallenges = '${baseUrl}user/challenges';
  static const String updatePersonalizeCard =
      '${baseUrl}user/upload_personlized_card_image';
  static const String updateChallengeStatus =
      '${baseUrl}/user/update_challenge_status';
  static const String reporttoAdmin =
      '${baseUrl}/user/challenge_report_to_admin';

  //-----------Video section

  static const String upLoadVideo = '${baseUrl}video/upload_video';
  static const String getPopularVideo = '${baseUrl}video/popular_video';
  static const String getWatchVideo = '${baseUrl}video/watch_videos';
  static const String getProfileVideo = '${baseUrl}video/get_profile_videos';
  static const String getUsersProfileVideo =
      '${baseUrl}video/get_user_profile_videos';

  static const String addComment = '${baseUrl}video/add_video_comment';
  static const String getComment = '${baseUrl}video/get_video_comments';
  static const String updateVideoStatics =
      '${baseUrl}video/update_video_statistics';
  static const String updateVideoStatus =
      '${baseUrl}video/update_profile_video_status';

  //-------------------Chat section

  static const String addChat = '${baseUrl}chat/add_chat';
  static const String getchatHistory = '${baseUrl}chat/chat_history';
  static const String inboxHistory = '${baseUrl}chat/chat_inbox';

  //-------------------Subscription section

  static const String buySubscription = '${baseUrl}user/buy_subscription';
}
