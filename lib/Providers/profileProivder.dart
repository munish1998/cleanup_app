import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/colors.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:cleanup_mobile/apiServices/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Models/profileModel.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _myProfile;
  ProfileModel? get myProfile => _myProfile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  Future<void> getmyProfile({
    required BuildContext context,
  }) async {
    var url = Uri.parse(ApiServices.getprofileDetails);

    // Retrieve the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(accessTokenKey);

    // Create headers with Authorization
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      // Make the GET request with headers
      final response = await http.get(url, headers: headers);

      var result = jsonDecode(response.body);
      log('user profile details response ===>>>>: ${response.body}');

      if (response.statusCode == 200) {
        if (result['success'] == true) {
          // Map the profile data from the response
          _myProfile = ProfileModel.fromJson(result['data']);
        } else {
          // Handle error from the response
          _myProfile = null;
          customToast(context: context, msg: result['message'], type: 0);
        }
      } else {
        // Handle server error
        _myProfile = null;
        customToast(context: context, msg: 'Server error', type: 0);
      }
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      _myProfile = null;
      customToast(context: context, msg: 'An error occurred', type: 0);
      notifyListeners();
    }
  }

  Future<bool> updateProfileIMG({
    required BuildContext context,
    required File imageFile,
  }) async {
    final url = Uri.parse(ApiServices.updateProfileIMG);
    showLoaderDialog(context, 'Uploading image...');

    final request = http.MultipartRequest('POST', url);
    final imageMultipartFile =
        await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(imageMultipartFile);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    if (accessToken == null) {
      log('Error: Access token is null');
      Navigator.pop(context); // Close the loader dialog
      return false;
    }

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    log('Access token response: $accessToken');

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success']) {
          final profileData = result['data'];
          _myProfile = ProfileModel.fromJson(profileData);
          notifyListeners(); // Update the UI with new profile data
          log('Response of image update: $result');
          commonToast(
              msg: result['message'] ?? 'Profile image updated successfully',
              color: Colors.blue);
          return true; // Image updated successfully
        } else {
          commonToast(
              msg: result['message'] ?? 'Failed to update image',
              color: Colors.red);
          return false; // Image update failed
        }
      } else {
        commonToast(
            msg: 'Failed to update image. Status code: ${response.statusCode}',
            color: Colors.red);
        return false; // Image update failed
      }
    } catch (e) {
      log('Error uploading image: $e');
      commonToast(msg: 'An error occurred: $e', color: Colors.red);
      return false; // Image update failed
    } finally {
      Navigator.pop(context); // Close the loader dialog
    }
  }

  Future<bool> updateProfileBG({
    required BuildContext context,
    required File imageFile,
  }) async {
    final url = Uri.parse(ApiServices.updateProfileBG);
    showLoaderDialog(context, 'Uploading image...');

    final request = http.MultipartRequest('POST', url);
    final imageMultipartFile =
        await http.MultipartFile.fromPath('bgimage', imageFile.path);
    request.files.add(imageMultipartFile);

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(accessTokenKey);

    if (accessToken == null) {
      log('Error: Access token is null');
      Navigator.pop(context); // Close the loader dialog
      return false;
    }

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    log('Access token response: $accessToken');

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success']) {
          final profileData = result['data'];
          _myProfile = ProfileModel.fromJson(profileData);
          notifyListeners(); // Update the UI with new profile data
          log('Response of image update: $result');
          commonToast(
              msg: result['message'] ?? 'Profile image updated successfully',
              color: Colors.blue);
          return true; // Image updated successfully
        } else {
          commonToast(
              msg: result['message'] ?? 'Failed to update image',
              color: Colors.red);
          return false; // Image update failed
        }
      } else {
        commonToast(
            msg: 'Failed to update image. Status code: ${response.statusCode}',
            color: Colors.red);
        return false; // Image update failed
      }
    } catch (e) {
      log('Error uploading image: $e');
      commonToast(msg: 'An error occurred: $e', color: Colors.red);
      return false; // Image update failed
    } finally {
      Navigator.pop(context); // Close the loader dialog
    }
  }

  Future<bool> editProfile({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    var url = Uri.parse(ApiServices.editProfile);

    // Fetch the access token from shared preferences
    final accessToken =
        await getAccessToken(); // Ensure this method is implemented correctly

    // Set up the headers with the Bearer token
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    showLoaderDialog(context, 'Please Wait..');

    try {
      // Make the POST request with headers and body
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data), // Convert the body map to JSON string
      );

      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the response body
        final result = jsonDecode(response.body) as Map<String, dynamic>;

        if (result['success']) {
          final profileData = result['data'] as Map<String, dynamic>;
          _myProfile = ProfileModel.fromJson(profileData);
          notifyListeners();
          commonToast(
            msg: 'Profile updated successfully',
            color: Colors.blue,
          );
          return true;
        } else {
          commonToast(
            msg: result['message'] ?? 'Failed to update profile',
            color: Colors.red,
          );
          return false;
        }
      } else {
        commonToast(
          msg: 'Failed to update profile. Status code: ${response.statusCode}',
          color: Colors.red,
        );
        return false;
      }
    } catch (e) {
      log('Error updating profile: $e');
      commonToast(
        msg: 'An error occurred: $e',
        color: Colors.red,
      );
      return false;
    } finally {
      Navigator.pop(context); // Close the loader dialog
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    final mobileRegex = RegExp(r'^\d{1,12}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Mobile number should be digits only and up to 12 digits';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your location';
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    final dobRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dobRegex.hasMatch(value)) {
      return 'Date of birth must be in YYYY-MM-DD format';
    }
    try {
      final parts = value.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      if (year < 1900 || year > DateTime.now().year) {
        return 'Year should be between 1900 and ${DateTime.now().year}';
      }
      if (month < 1 || month > 12) {
        return 'Month should be between 01 and 12';
      }
      if (day < 1 || day > 31) {
        return 'Day should be between 01 and 31';
      }

      final isLeapYear =
          (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      final daysInMonth = [
        31, // Jan
        (isLeapYear ? 29 : 28), // Feb
        31, // Mar
        30, // Apr
        31, // May
        30, // Jun
        31, // Jul
        31, // Aug
        30, // Sep
        31, // Oct
        30, // Nov
        31, // Dec
      ];

      if (day > daysInMonth[month - 1]) {
        return 'Invalid day for the given month';
      }
    } catch (_) {
      return 'Invalid date format';
    }
    return null;
  }
}
