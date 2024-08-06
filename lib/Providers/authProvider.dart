import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:cleanup_mobile/apiServices/apiServices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';
import '../utils/customLoader.dart';
import '/utils/commonMethod.dart';

class AuthProvider with ChangeNotifier {
  String _address = '';

  String get address => _address;
  bool _isAgree = false;

  bool get isAgree => _isAgree;

  bool _isOTP = false;

  bool get isOTP => _isOTP;

  bool _isVerify = false;

  bool get isVerify => _isVerify;
  bool _isForgot = false;

  bool get isForgot => _isForgot;

  bool _isChange = false;

  bool get isChange => _isChange;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  String _uId = '';

  String get uId => _uId;
  String _token = '';

  String get token => _token;
  bool isRemember = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  TextEditingController fEmailController = TextEditingController();

  TextEditingController lEmailController = TextEditingController();
  TextEditingController lPassController = TextEditingController();

  TextEditingController nPassController = TextEditingController();
  TextEditingController nCPassController = TextEditingController();
  File? image;
  final picker = ImagePicker();
  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    locationController.dispose();
    areaController.dispose();
    passController.dispose();
    cPassController.dispose();
    otpController.dispose();
    fEmailController.dispose();
    lEmailController.dispose();
    lPassController.dispose();
    nPassController.dispose();
    nCPassController.dispose();
    super.dispose();
  }

  Future<void> pickedImage() async {
    final imaged = await picker.pickImage(source: ImageSource.gallery);
    if (imaged != null) {
      // var pic =http.m
    }
  }

  void checkAgree(bool value) async {
    _isAgree = !value;
    log('----------->>>   $value   $_isAgree');
    notifyListeners();
  }

  void checkOTP() async {
    _isOTP = false;
  }

  void getToken() async {
    _token = (await FirebaseMessaging.instance.getToken())!;
  }

  void clear() async {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passController.clear();
    cPassController.clear();
    lEmailController.clear();
    lPassController.clear();
    fEmailController.clear();
    nPassController.clear();
    nCPassController.clear();
  }

  Future<void> Logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<void> logoutt(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    // navPushRemove(context: context, action: FirstOnboard());
    notifyListeners();
  }

  Future<void> signUpp(
      {required BuildContext context,
      required Map<String, dynamic> data}) async {
    final url = ApiServices.register; // Replace with your actual endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('Response__POST___====> $responseBody');
        // Process the response here
      } else if (response.statusCode == 409) {
        log('SignUp Error: Conflict - likely duplicate data');
        commonToast(
            msg: 'Conflict: This email or username already exists',
            color: Colors.red);
        throw Exception('SignUp Error: Conflict - likely duplicate data');
      } else {
        log('SignUp Error: Unexpected status code: ${response.statusCode}');
        commonToast(
            msg: 'SignUp Error: Unexpected status code: ${response.statusCode}',
            color: Colors.red);
        throw Exception(
            'SignUp Error: Unexpected status code: ${response.statusCode}');
      }
    } catch (error) {
      log('SignUp Error: $error');
      throw Exception('SignUp Error: $error');
    }
  }

  Future<void> signUp(
      {required BuildContext context,
      required Map<String, dynamic> data}) async {
    var url = Uri.parse(ApiServices.register);
    showLoaderDialog(context, 'Please Wait..');

    try {
      // Make the POST request
      final response =
          await ApiClient().postData(context: context, url: url, body: data);

      // Log the raw response body
      log('Response body: ${response.body}');

      // Handle non-200 status codes
      if (response.statusCode != 200) {
        // Attempt to decode error response
        var errorResult = {};
        try {
          errorResult = jsonDecode(response.body);
        } catch (e) {
          log('Error decoding response body: $e');
          customToast(
              context: context, msg: 'An unexpected error occurred', type: 0);
          return;
        }
        customToast(
            context: context,
            msg: errorResult['message'] ?? 'Unknown error',
            type: 0);
        _isOTP = false;
        notifyListeners();
        return;
      }

      // Attempt to decode JSON response
      var result = {};
      try {
        result = jsonDecode(response.body);
      } catch (e) {
        log('Error decoding JSON response: $e');
        customToast(context: context, msg: 'Invalid response format', type: 0);
        _isOTP = false;
        notifyListeners();
        return;
      }

      log('SignUp result: $result');

      // Handle response based on 'code'
      if (result['code'] == 200) {
        _uId = result['id'];
        _isOTP = true;
        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isOTP = false;
        notifyListeners();
      }
    } catch (e) {
      // Handle any other errors (network issues, etc.)
      log('SignUp Error: $e');
      customToast(context: context, msg: 'SignUp Error: $e', type: 0);
      _isOTP = false;
      notifyListeners();
    } finally {
      // Close the loader dialog
      navPop(context: context);
    }
  }

  Future<bool> login(
      {required BuildContext context,
      required Map<String, String> data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.login);
    _isLogin = false;

    showLoaderDialog(context, 'Please wait...');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);

    // Log the response details
    log('Login response status code: ${response.statusCode}');
    log('Login response body: ${response.body}');

    navPop(context: context);

    if (response.statusCode == 200) {
      try {
        var result = jsonDecode(response.body);

        // Log the parsed response
        log('Parsed response: $result');

        if (result.containsKey('access_token')) {
          // Save values in SharedPreferences
          pref.setBool(isUserLoginKey, true);
          pref.setString(accessTokenKey, result['access_token']);
          pref.setString(
              userIdKey,
              result['user']['id']
                  .toString()); // Ensure user ID is stored as a string

          // Log stored values
          log('Stored access token: ${pref.getString(accessTokenKey)}');
          log('Stored user ID: ${pref.getString(userIdKey)}');
          log('check logged===>>>>${pref.setBool(isUserLoginKey, true)}');

          _isLogin = true;
          notifyListeners();
          return true; // Login successful
        } else {
          // Handle missing access token
          customToast(
              context: context,
              msg: result['message'] ?? 'Login failed',
              type: 0);
          _isLogin = false;
          notifyListeners();
          return false; // Login failed
        }
      } catch (e) {
        log('Error parsing response: $e');
        customToast(
            context: context,
            msg: 'An error occurred while processing the response',
            type: 0);
        _isLogin = false;
        notifyListeners();
        return false; // Login failed
      }
    } else {
      log('Error response status code: ${response.statusCode}');
      customToast(
          context: context,
          msg: 'Server error: ${response.statusCode}',
          type: 0);
      _isLogin = false;
      notifyListeners();
      return false; // Login failed
    }
  }

  Future<String?> verifyOTPpp(
      {required BuildContext context,
      required Map<String, String> data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isVerify = false;
    var url = Uri.parse(ApiServices.verifyOtp);
    showLoaderDialog(context, 'P..');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    log('OTP Result---------->>>>   $result');
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        pref.setBool(isUserLoginKey, true);
        pref.setString(accessTokenKey, result['access_token']);
        pref.setString(userIdKey, result['user_id']);
        _isVerify = true;
        notifyListeners();
        return result['reset_token']; // Return the reset token
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isVerify = false;
        notifyListeners();
        return null;
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isVerify = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> sendOtp(
      {required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.sendOtp);

    showLoaderDialog(context, 'Please wait..');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        _uId = result['id'];
        _isForgot = true;
        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isForgot = false;
        notifyListeners();
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isForgot = false;
      notifyListeners();
    }
  }

  Future<String?> verifyOTP(
      {required BuildContext context,
      required Map<String, String> data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isVerify = false;
    var url = Uri.parse(ApiServices.verifyOtp);
    showLoaderDialog(context, 'Please wait..');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    log('OTP Result---------->>>>   $result');
    navPop(context: context);

    if (response.statusCode == 200) {
      if (result['success'] == true) {
        // Store the reset token correctly
        pref.setString('reset_token', result['reset_token'] ?? '');
        pref.setBool(isUserLoginKey, true);
        pref.setString('accessTokenKey', result['access_token'] ?? '');
        pref.setString('userIdKey', result['user_id'] ?? '');

        log('AccessToken: ${pref.getString('accessTokenKey')}');
        log('UserID: ${pref.getString('userIdKey')}');
        log('ResetToken: ${pref.getString('reset_token')}'); // Ensure this logs correctly

        _isVerify = true;
        notifyListeners();
        return result['reset_token']; // Return the reset token
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isVerify = false;
        notifyListeners();
        return null;
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isVerify = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> verifOTP(
      {required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isVerify = false;
    var url = Uri.parse(ApiServices.verifyOtp);
    // debugPrint('Data-==>  $url');
    showLoaderDialog(context, 'Please wait...');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    log('OTP Result---------->>>>   $result');
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        pref.setBool(isUserLoginKey, true);
        pref.setString(accessTokenKey, result['access_token']);
        pref.setString(userIdKey, result['id']);
        _isVerify = true;

        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isVerify = false;
        notifyListeners();
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isVerify = false;
      notifyListeners();
    }
  }

  Future<void> forgotPass(
      {required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.forgotPass);

    showLoaderDialog(context, 'Please wait..');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        _uId = result['id'];
        _isForgot = true;
        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isForgot = false;
        notifyListeners();
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isForgot = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString(accessTokenKey); // Retrieve token

    if (token == null) {
      customToast(context: context, msg: 'No access token found', type: 0);
      return;
    }

    final url = Uri.parse(ApiServices.logOut); // Logout URL

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      log('Logout response status code: ${response.statusCode}');
      log('Logout response body: ${response.body}');

      if (response.statusCode == 200) {
        // Clear user data from SharedPreferences
        await pref.remove(accessTokenKey);
        await pref.remove(userIdKey);
        await pref.setBool(isUserLoginKey, false);

        // Notify listeners and handle any UI updates
        notifyListeners();
        customToast(context: context, msg: 'Logout successful', type: 1);

        // Optionally, navigate to login or home screen
        // navPushRemove(context: context, action: FirstOnboard());
      } else {
        customToast(
            context: context,
            msg: 'Logout failed: ${response.statusCode}',
            type: 0);
      }
    } catch (e) {
      log('Logout error: $e');
      customToast(
          context: context, msg: 'An error occurred during logout', type: 0);
    }
  }
}
