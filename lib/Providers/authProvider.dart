import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Models/userModel.dart';
import 'package:cleanup_mobile/Utils/customSnackbar.dart';
import 'package:cleanup_mobile/Utils/customredSnackbar.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:cleanup_mobile/apiServices/apiServices.dart';
import 'package:firebase_auth/firebase_auth.dart ' as fa;
import 'package:firebase_auth/firebase_auth.dart%20';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';
import '../utils/customLoader.dart';
import '/utils/commonMethod.dart';

class AuthProvider with ChangeNotifier {
  // Userdetails? userDetail;
  final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // List<Userdetails> _pending = [];
  //List<Userdetails> get pending => _pending;
  String _address = '';
  bool isloading = false;
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

  Future<String> getToken() async {
    String token = await FirebaseMessaging.instance.getToken() ?? '';
    log('_token response ====>>>$token');
    _token = token; // Store it if needed globally
    return token;
  }

  Future<bool> login({
    required BuildContext context,
    required Map<String, String> data,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.login);
    _isLogin = false;

    // Ensure that _token is not empty before proceeding
    if (_token.isEmpty) {
      log('Device token is empty');
      await getToken(); // Try getting the token again
    }

    data['device_token'] = _token;
    log('Device token being sent: $_token');

    showLoaderDialog(context, 'Please wait...');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);

    log('Login response status code: ${response.statusCode}');
    log('Login response body: ${response.body}');

    navPop(context: context);

    if (response.statusCode == 200) {
      try {
        var result = jsonDecode(response.body);

        log('Parsed response: $result');

        if (result.containsKey('access_token')) {
          pref.setBool(isUserLoginKey, true);
          pref.setString(accessTokenKey, result['access_token']);
          pref.setString(userIdKey, result['user']['id'].toString());

          log('Stored access token: ${pref.getString(accessTokenKey)}');
          log('Stored user ID: ${pref.getString(userIdKey)}');
          showTopSnackBar(context,'Login successful');
          _isLogin = true;
          notifyListeners();

          await updateDeviceToken(
              _token); // Update the device token after login

          return true; // Login successful
        } else {
          showredTopSnackBar(context, response.body);
          _isLogin = false;
          notifyListeners();
          return false; // Login failed
        }
      } catch (e) {
        log('Error parsing response: $e');
        showredTopSnackBar(context, response.body);
        _isLogin = false;
        notifyListeners();
        return false; // Login failed
      }
    } else {
      log('Error response status code: ${response.statusCode}');
      showredTopSnackBar(context, response.body);
      _isLogin = false;
      notifyListeners();
      return false; // Login failed
    }
  }

  Future<void> updateDeviceToken(String deviceToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(
        accessTokenKey); // Retrieve the access token from SharedPreferences

    var url = ApiServices.updatedeviceToken; // Replace with the actual API URL

    var data = {
      'device_token': deviceToken, // Use the provided deviceToken
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Add the authorization header with the Bearer token
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        log('Device token updated successfully: $deviceToken');
      } else {
        log('Failed to update device token. Status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error updating device token: $error');
    }
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

  Future<void> googleLogin(BuildContext context) async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? result = await _googleSignIn.signIn();
      if (result == null) {
        print("Sign-in failed or user cancelled");
        return;
      }

      final GoogleSignInAuthentication userData = await result.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );

      final UserCredential finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = finalResult.user;

      if (user != null) {
        log("User signed in: ${user.displayName}");
        log("User email: ${user.email}");
        log("User photo URL: ${user.photoURL}");

        // Save the token to SharedPreferences
        if (userData.accessToken != null) {
          await saveTokenToSharedPreferences(userData.accessToken!);
        }

        // Call socialSignup API with the user's details
        try {
          final Map<String, dynamic> socialSignupResponse = await socialSignup(
            username: user.displayName ?? '',
            name: user.displayName ?? '',
            terms: '1',
            email: user.email!,
            mobile: '1234567890', // Adjust if mobile number is available
            isAdmin: '0', // Adjust according to your requirements
            socialSignup: 'gmail',
          );
          log("Social signup API response: $socialSignupResponse");

          // Check if socialSignup was successful before proceeding
          if (socialSignupResponse['status'] == 'success') {
            // Call socialLogin API with the user's email
            final Map<String, dynamic> socialLoginResponse = await socialLogin(
              email: user.email!,
            );
            log("Social login API response: $socialLoginResponse");

            // Navigate to HomeScreen if login is successful
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            // Handle the case where socialSignup fails
            log("Social signup failed: ${socialSignupResponse['message']}");
            // Show error message to the user if needed
          }
        } catch (signupError) {
          log("Error during social signup: $signupError");
          // Handle signup error, e.g., show an error message to the user
        }
      }
    } catch (error) {
      print("Error during Google sign-in: $error");
      // Handle Google sign-in error, e.g., show an error message to the user
    }
  }

  Future<Map<String, dynamic>> socialSignup({
    required String username,
    required String name,
    required String email,
    required String terms,
    required String mobile,
    required String isAdmin,
    required String socialSignup,
  }) async {
    final String? token = await getTokenFromSharedPreferences();
    log('token response ===>>>$token');

    try {
      final response = await http.post(
        Uri.parse(ApiServices.socialSignup),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include token if required by your API
        },
        body: jsonEncode({
          "username": username,
          "terms": terms,
          "name": name,
          "email": email,
          "mobile": mobile,
          "is_admin": isAdmin,
          "social_signup": socialSignup,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw Exception(
            'Failed to sign up: ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (error) {
      log("Error during social signup: $error");
      throw Exception('Error during social signup: $error');
    }
  }

  Future<void> saveTokenToSharedPreferences(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('accessTokenKey', token);
  }

  Future<void> logoutt() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<String?> getTokenFromSharedPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(
        'accessTokenKey'); // Replace 'accessTokenKey' with your actual key
  }

  Future<Map<String, dynamic>> socialLogin({required String email}) async {
    final String? token = await getTokenFromSharedPreferences();
    if (token == null) {
      throw Exception('No access token found');
    }

    try {
      final response = await http.post(
        Uri.parse(ApiServices.socialLogin),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "social_signup": "gmail",
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw Exception('Failed to login: ${errorResponse['message']}');
      }
    } catch (error) {
      log("Error during social login: $error");
      throw Exception('Error during social login: $error');
    }
  }

  Future<void> socialLoginn({
    required BuildContext context,
    required String email,
    required String username,
    required String name,
    required String mobileNumber,
    required String password,
    required String confirmPassword,
    required String is_admin,
    required String social_signup,
  }) async {
    isloading = true;
    notifyListeners();

    try {
      final response = await ApiClient().socialSignup(
        username: username,
        name: name,
        is_admin: is_admin,
        terms: '1', // Assuming '1' is for accepting terms
        social_signup: social_signup,
        email: email,
        mobileNumber: mobileNumber,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (response['success'] == true) {
        // Handle successful signup
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', response['access_token']);
        await prefs.setString('token_type', response['token_type']);

        // Navigate to the next screen or update state
        Navigator.of(context).pushReplacementNamed('/next_screen');
      } else {
        // Handle failed signup
        log("Signup failed: ${response['message']}");
        // Optionally show an error message to the user
        // customToast(context: context, msg: response['message'], type: 0);
      }
    } catch (error) {
      log("Error during social login: $error");
      // Optionally handle exception, e.g., show an error message
      // customToast(context: context, msg: 'An unexpected error occurred.', type: 0);
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> Logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<void> logouttt(BuildContext context) async {
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

  void navPushh(
      {required BuildContext context,
      required Widget action,
      String? accessToken}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => action, // Modify this if necessary
      ),
    );
  }

  Future<void> signUp({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    var url = Uri.parse(ApiServices.register); // Replace with your API URL
    showLoaderDialog(context, 'Please Wait..'); // Show a loading indicator

    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          var result = jsonDecode(response.body);

          if (result['success'] == true) {
            // Registration successful
            String accessToken = result['access_token'];
            String tokenType = result['token_type'];

            // Save tokens if needed
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('access_token', accessToken);
            await prefs.setString('token_type', tokenType);

            // Close the loader dialog
            if (Navigator.canPop(context)) {
              navPop(context: context);
            }

            // Show success message in a Snackbar
            showTopSnackBar(context, response.body);

            // Navigate to the Home screen after a delay
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen()), // Adjust to your HomeScreen
              );
            });
          } else {
            // Handle validation errors
            if (result['errors'] != null) {
              var errors = result['errors'];
              String errorMessages = '';

              // Extract error messages from the response
              errors.forEach((key, value) {
                for (var message in value) {
                  errorMessages += '$message\n';
                }
              });

              // Show validation error messages in a Snackbar
              showredTopSnackBar(context, response.body);
            } else {
              // Show generic error message from API
              showredTopSnackBar(context, response.body);
            }
          }
        } catch (e) {
          // Handle JSON parsing error
          log('JSON Parsing Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unexpected response format'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else if (response.statusCode == 409) {
        // Handle conflict error
        var errorMsg = 'Server side error ';
        try {
          var result = jsonDecode(response.body);
          errorMsg = result['message'] ?? errorMsg;
        } catch (e) {
          log('Error parsing conflict response: $e');
        }
        showredTopSnackBar(context, response.body);
      } else if (response.statusCode == 405) {
        // Handle method not allowed error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Method Not Allowed: ${response.body}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        // Show server error message
        showredTopSnackBar(context, response.body);
      }
    } catch (e) {
      log('SignUp Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SignUp Error: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    } finally {
      // Ensure the loader dialog is closed in case of both success and failure
      if (Navigator.canPop(context)) {
        navPop(context: context);
      }
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
      showredTopSnackBar(context, response.body);
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
        showredTopSnackBar(context, response.body);
        _isForgot = false;
        notifyListeners();
      }
    } else {
      showredTopSnackBar(context, response.body);
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
        showredTopSnackBar(context, response.body);
        _isVerify = false;
        notifyListeners();
        return null;
      }
    } else {
      showredTopSnackBar(context, response.body);
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
        showredTopSnackBar(context, response.body);
        _isVerify = false;
        notifyListeners();
      }
    } else {
      showredTopSnackBar(context, response.body);
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
        showredTopSnackBar(context, response.body);
        _isForgot = false;
        notifyListeners();
      }
    } else {
      showredTopSnackBar(context, response.body);
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
        showTopSnackBar(context, response.body);

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
