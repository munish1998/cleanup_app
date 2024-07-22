import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:cleanup_mobile/apiServices/apiServices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    // navPushRemove(context: context, action: FirstOnboard());
    notifyListeners();
  }

  Future<void> signUp(
      {required BuildContext context, required Map data}) async {
    var url = Uri.parse(ApiServices.register);
    showLoaderDialog(context, 'P...');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    log('response of jsondecode===>>>>${response.body}');
    log('SignUP --------->>>   $result');
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        _uId = result['id'];
        _isOTP = true;

        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isOTP = false;
        notifyListeners();
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isOTP = false;
      notifyListeners();
    }
  }

  Future<void> login({required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.login);
    _isLogin = false;

    showLoaderDialog(context, 'Please..');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    log('login response ====>>>>$response');
    navPop(context: context);
    print('');
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['code'] == 200) {
        pref.setBool(isUserLoginKey, true);
        pref.setString(accessTokenKey, result['access_token']);
        pref.setString(userIdKey, result['id']);
        log('response of accesstoken===>>>>>${pref.getString("access_token")}');
        log('response of userid====>>>>>${pref.getString("id")}');
        _isLogin = true;
        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isLogin = false;
        notifyListeners();
      }
    } else {
      _isLogin = false;
      notifyListeners();
    }
  }

  Future<void> verifyOTP(
      {required BuildContext context, required Map data}) async {
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

  Future<void> sendOtp(
      {required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.sendOtp);

    showLoaderDialog(context, '');
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

    showLoaderDialog(context, '');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        _uId = result['user_id'];
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

  Future<void> verifyForgotOTP(
      {required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isVerify = false;
    var url = Uri.parse(ApiServices.verifyForgotOtp);
    showLoaderDialog(context, 'Pl.');
    final response =
        await ApiClient().postData(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        pref.setBool(isUserLoginKey, true);
        pref.setString(accessTokenKey, result['access_token']);
        pref.setString(userIdKey, result['user_id']);
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

  Future<void> changePass(
      {required BuildContext context, required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var url = Uri.parse(ApiServices.changePassword);
    _isChange = false;
    showLoaderDialog(context, 'Please wait...');
    final response = await ApiClient()
        .postDataByToken(context: context, url: url, body: data);
    var result = jsonDecode(response.body);
    navPop(context: context);
    if (response.statusCode == 200) {
      if (result['code'] == 200) {
        _isChange = true;
        notifyListeners();
      } else {
        customToast(context: context, msg: result['message'], type: 0);
        _isChange = false;
        notifyListeners();
      }
    } else {
      customToast(context: context, msg: result['message'], type: 0);
      _isChange = false;
      notifyListeners();
    }
  }
}
