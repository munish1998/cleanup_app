import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/commonMethod.dart';
import '../utils/constant.dart';

class ApiClient {
  Future<http.Response> getData(
      {required BuildContext context, required Uri uri}) async {
    try {
      final response = await http.get(
        uri,
      );
      // log('Response__GET___====>>${response.body.toString()}');
      return response;
    } on SocketException catch (e) {
      switch (e.osError!.errorCode) {
        case 7:
          commonAlert(context, 'No Internet Connection!');
          break;
        case 111:
          commonAlert(context, 'Unable to connect to server!');
          break;
      }
      log('Socket Exception thrown --> $e');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      commonAlert(context, 'Please! Try Again');
      log('TimeoutException thrown --> $e');

      return http.Response(e.toString(), 1);
    } catch (e) {
      log(e.toString());
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> getDataByToken(
      {required BuildContext context, required Uri uri}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var header = {
        'id': prefs.getString(userIdKey).toString(),
        'Authorization': prefs.getString(accessTokenKey).toString(),
      };
      final response = await http.get(uri, headers: header);
      // log('Response__GET___====>>${response.body.toString()}');
      return response;
    } on SocketException catch (e) {
      switch (e.osError!.errorCode) {
        case 7:
          commonAlert(context, 'No Internet Connection!');
          break;
        case 111:
          commonAlert(context, 'Unable to connect to server!');
          break;
      }
      log('Socket Exception thrown --> $e');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      commonAlert(context, 'Please! Try Again');
      log('TimeoutException thrown --> $e');

      return http.Response(e.toString(), 1);
    } catch (e) {
      log(e.toString());
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> getDataByPost(
      {required BuildContext context, required Uri uri}) async {
    try {
      final response = await http.post(
        uri,
      );
      // log('Response__GET_BY_POST___====>>${response.body.toString()}');
      return response;
    } on SocketException catch (e) {
      switch (e.osError!.errorCode) {
        case 7:
          commonAlert(context, 'No Internet Connection!');
          break;
        case 111:
          commonAlert(context, 'Unable to connect to server!');
          break;
      }
      log('Socket Exception thrown --> $e');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      commonAlert(context, 'Please! Try Again');
      log('TimeoutException thrown --> $e');

      return http.Response(e.toString(), 1);
    } catch (e) {
      log(e.toString());
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> postData(
      {required BuildContext context,
      required Uri url,
      required Map body}) async {
    var header = {"Content-Type": "application/x-www-form-urlencoded"};
    try {
      // log('BodyData------------>>>>>>   $body');
      final response = await http.post(
        url,
        body: body,
        headers: header,
      );
      log('Response__POST___====>>${response.body.toString()}');
      return response;
    } on SocketException catch (e) {
      switch (e.osError!.errorCode) {
        case 7:
          commonAlert(context, 'No Internet Connection!');
          break;
        case 111:
          commonAlert(context, 'Unable to connect to server!');
          break;
      }
      log('Socket Exception thrown --> $e');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      commonAlert(context, 'Please! Try Again');
      log('TimeoutException thrown --> $e');

      return http.Response(e.toString(), 1);
    } catch (e) {
      log(e.toString());
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> postDatat({
    required BuildContext context,
    required Uri url,
    required Map<String, String> body,
  }) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    try {
      final response = await http.post(url, body: body, headers: headers);

      // Check for HTTP errors
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('Failed to load data');
      }

      log('Response__POST___====>>${response.body.toString()}');
      return response;
    } on SocketException catch (e) {
      commonAlert(context, 'No Internet Connection!');
      log('SocketException: $e');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      commonAlert(context, 'Request timed out. Please try again.');
      log('TimeoutException: $e');
      return http.Response(e.toString(), 1);
    } catch (e) {
      log('Exception: $e');
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> postDataByToken({
    required BuildContext context,
    required Uri url,
    required Map<String, String> body,
    File? imageFile,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token =
          prefs.getString('accessTokenKey'); // Replace with your token key

      if (token == null || token.isEmpty) {
        throw Exception('Access token is missing.');
      }

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      // Log headers and body for debugging
      print('Header::---->>>  $headers');
      print('Body::---->>>  $body');

      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );

      // Log response for debugging
      print('Response__POST___====>>${response.body.toString()}');
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print('Socket Exception thrown --> $e');
      // _showAlert(context, 'Unable to connect to server!');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      print('TimeoutException thrown --> $e');
      //  _showAlert(context, 'Please try again');
      return http.Response(e.toString(), 1);
    } catch (e) {
      print('Exception thrown --> $e');
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> login(
      {required BuildContext context,
      required Uri url,
      required Map body}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString(accessTokenKey).toString();
      var headers = {
        'Contect-type': 'application/json;charset-UTF-8',
      };
      // debugPrint('BODY___====>>$body');
      final response = await http.post(url, body: body);
      // debugPrint('Response__Status___====>>${response.statusCode.toString()}');
      // debugPrint('Response___====>>${response.body.toString()}');
      return response;
    } on SocketException catch (e) {
      switch (e.osError!.errorCode) {
        case 7:
          commonAlert(context, 'No Internet Connection!');
          break;
        case 111:
          commonAlert(context, 'Unable to connect to server!');
          break;
      }
      log('Socket Exception thrown --> $e');
      return http.Response(e.toString(), 1);
    } on TimeoutException catch (e) {
      commonAlert(context, 'Please! Try Again');
      log('TimeoutException thrown --> $e');

      return http.Response(e.toString(), 1);
    } catch (e) {
      log(e.toString());
      return http.Response(e.toString(), 1);
    }
  }

  Future<dynamic> createTaskrepo({
    required File beforeImage,
    required File afterImage,
    required String userid,
    required String location,
    required String description,
    required String title,
  }) async {
    final request =
        http.MultipartRequest('POST', Uri.parse(ApiServices.createTask));
    SharedPreferences pref = await SharedPreferences.getInstance();
    // Create a multipart file from the file path

    var before = await http.MultipartFile.fromPath('before', beforeImage.path);
    var after = await http.MultipartFile.fromPath('after', afterImage.path);

    request.files.add(before);
    request.fields["location"] = location;
    request.fields["title"] = title;
    request.fields["description"] = description;

    request.files.add(after);

    // Add the file to the request

    request.headers["Authorization"] = "Bearer $accessTokenKey";
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    log(responseBody);

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }
}
