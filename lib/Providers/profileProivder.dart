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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _dobController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  TextEditingController get nameController => _nameController;
  TextEditingController get locationController => _locationController;

  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;

  TextEditingController get dobController => _dobController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get cpasswordController => _cpasswordController;
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
}
