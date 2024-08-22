import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'package:cleanup_mobile/Auth_Screen/Register.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:cleanup_mobile/apiServices/apiConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPass = true;
  bool isCPass = false;
  bool _isChecked1 = false;
  List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _otpControllers = List.generate(4, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 248, 253, 255),
      body: Stack(
        children: [
          Image.asset('assets/images/image5.png'),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(child:
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
              return Column(
                children: [
                  const Text(
                    'Welcome to',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            await taskProvider.handleSignIn(context: context);
                          },
                          child: Image.asset('assets/images/image6.png')),
                      const SizedBox(
                        width: 22,
                      ),
                      Image.asset('assets/images/image7.png')
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.2, // Adjust the multiplier as needed
                  ),
                  textfields(
                      context: context,
                      controller: authProvider.emailController,
                      hint: 'Email',
                      icon: Icons.email,
                      ispas: false,
                      index: 0,
                      hintTextColor: AppColor.leaderboardtextColor),
                  const SizedBox(
                    height: 10,
                  ),
                  textfields(
                      context: context,
                      controller: authProvider.passController,
                      hint: 'Password',
                      icon: Icons.lock,
                      showSuffixIcon: true,
                      onSuffixIconPressed: () {
                        setState(() {
                          isPass = !isPass;
                        });
                      },
                      ispas: isPass,
                      index: 0,
                      hintTextColor: AppColor.leaderboardtextColor),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Show bottom sheet when "Forgot Password?" is tapped
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              final mediaQuery = MediaQuery.of(context);
                              return Consumer<AuthProvider>(
                                builder: (context, authProvider, child) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.only(
                                          bottom: mediaQuery.viewInsets
                                              .bottom), // Adjust for keyboard
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'FORGET PASSWORD?',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  const Text(
                                                    'Enter your email or phone number',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'We will send you a confirmation code',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    child: Card(
                                                      elevation: 3,
                                                      child: Container(
                                                        height: 54,
                                                        width: 370,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(17),
                                                        ),
                                                        child: TextFormField(
                                                          controller: authProvider
                                                              .fEmailController,
                                                          maxLines: 1,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'Email',
                                                            labelStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                            border: InputBorder
                                                                .none,
                                                            suffixIcon:
                                                                const Icon(
                                                              Icons.email,
                                                              color: AppColor
                                                                  .rank1Color,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await onSendOtp(context);
                                                    },
                                                    child: Container(
                                                      height: 54,
                                                      width: 370,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color:
                                                            AppColor.rank1Color,
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'Send OTP',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColor.rank1Color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: onLogin,
                    // Add your login function here

                    child: Container(
                      height: 54,
                      width: 370,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: AppColor.rank1Color,
                      ),
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          navPush(context: context, action: RegisterScreen());
                          // Navigate to sign up screen
                        },
                        child: const Text(
                          ' Sign up',
                          style: TextStyle(
                            color: AppColor.rank1Color,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            })),
          )
        ],
      ),
    );
  }

  Widget textfields({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool ispas,
    required int index,
    required Color hintTextColor,
    bool showSuffixIcon = false,
    VoidCallback? onSuffixIconPressed, // Add a callback for suffix icon press
  }) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: ispas,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: hintTextColor),
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  icon: Icon(
                    ispas ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: onSuffixIconPressed, // Use the callback here
                )
              : null,
        ),
      ),
    );
  }

  List<Widget> _buildOtpFields() {
    return List<Widget>.generate(4, (index) {
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
          ),
          onChanged: (value) {
            if (value.length == 1) {
              Timer(Duration(milliseconds: 100), () {
                if (index + 1 < _otpControllers.length) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                } else {
                  FocusScope.of(context).unfocus();
                }
              });
            }
          },
        ),
      );
    });
  }

  Future<void> onSendOtp(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var data = {};

    if (authProvider.fEmailController.text.isEmpty) {
      customToast(context: context, msg: 'Email ID required', type: 0);
    } else if (!emailExpression.hasMatch(authProvider.fEmailController.text)) {
      customToast(context: context, msg: 'Enter valid Email ID', type: 0);
    } else {
      data = {
        'email': authProvider.fEmailController.text,
      };

      try {
        await authProvider.sendOtp(context: context, data: data);
        // Show the verification code bottom sheet after OTP is sent
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Allow the bottom sheet to resize
          builder: (BuildContext context) {
            final mediaQuery = MediaQuery.of(context);
            return Padding(
              padding: EdgeInsets.only(
                bottom: mediaQuery.viewInsets.bottom,
              ),
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Allow the bottom sheet to be as small as needed
                        children: [
                          const Text(
                            'VERIFICATION CODE',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Enter the verification code',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildOtpFields(),
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: () => onVerify(
                                context, authProvider.fEmailController.text),
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colors.lightBlue.shade300,
                              ),
                              child: const Center(
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      } catch (e) {
        // Handle errors here
        customToast(context: context, msg: 'Failed to send OTP', type: 0);
      }
    }
  }

  void onVerify(BuildContext context, String email) async {
    var pro = Provider.of<AuthProvider>(context, listen: false);

    // Collect OTP by combining the text from all controllers
    String otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      customToast(context: context, msg: 'Please enter all 4 digits', type: 0);
      return;
    }

    var data = {
      'email': email,
      'otp': otp,
    };

    try {
      // Call the verifyOTP function and get the reset token
      String? resetToken = await pro.verifyOTP(context: context, data: data);
      log('Reset token received: $resetToken');

      if (resetToken != null) {
        // Proceed with UI update
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Container(
                  height: 400,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          const Text(
                            'Change Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          //const SizedBox(height: 30),
                          const SizedBox(height: 30),
                          textfields(
                            context: context,
                            controller: authProvider.passController,
                            hint: 'Password',
                            icon: Icons.lock,
                            showSuffixIcon: true,
                            onSuffixIconPressed: () {
                              setState(() {
                                isPass = !isPass;
                              });
                            },
                            ispas: isPass,
                            hintTextColor: Colors.grey,
                            index: 5,
                          ),
                          const SizedBox(height: 10),
                          textfields(
                            context: context,
                            controller: authProvider.cPassController,
                            hint: 'Confirm password',
                            icon: Icons.lock,
                            showSuffixIcon: true,
                            onSuffixIconPressed: () {
                              setState(() {
                                isCPass = !isCPass;
                              });
                            },
                            ispas: isCPass,
                            hintTextColor: Colors.grey,
                            index: 6,
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () =>
                                onForgetpassword(), // Pass the reset token here
                            child: Container(
                              height: 54,
                              width: 370,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.rank1Color,
                              ),
                              child: const Center(
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.backgroundcontainerColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      }
      //  else {
      //   customToast(
      //       context: context, msg: 'Invalid OTP. Please try again.', type: 0);
      // }
    } catch (e) {
      customToast(context: context, msg: 'Error verifying OTP.', type: 0);
      debugPrint('Error: $e');
    }
  }

  Future<void> onLogin() async {
    var pro = Provider.of<AuthProvider>(context, listen: false);

    if (pro.emailController.text.isEmpty) {
      customToast(context: context, msg: 'Email ID required', type: 0);
    } else if (!emailExpression.hasMatch(pro.emailController.text)) {
      customToast(context: context, msg: 'Enter valid Email ID', type: 0);
    } else if (pro.passController.text.isEmpty) {
      customToast(context: context, msg: 'Please enter password', type: 0);
    } else if (pro.passController.text.length < 8) {
      customToast(
          context: context, msg: 'Please enter 8 digit password', type: 0);
    } else {
      var data = {
        'email': pro.emailController.text,
        'password': pro.passController.text,
      };

      bool loginSuccessful = await pro.login(context: context, data: data);
      log('Login Here-------------------- $data');

      if (loginSuccessful) {
        customToast(context: context, msg: 'Login successful', type: 0);

        // Update device token after login
        String deviceToken = pro.token; // Retrieve the actual device token
        await pro.updateDeviceToken(deviceToken);
        log('login device token ===>>>$deviceToken');
        navPushRemove(context: context, action: HomeScreen());
      } else {
        customToast(context: context, msg: 'Incorrect login details', type: 0);
      }
    }
  }

  // Future<void> updateDeviceToken(String deviceToken) async {
  //   var url = ApiServices.updatedeviceToken; // Replace with actual base URL
  //   var data = {
  //     'device_token': deviceToken,
  //   };

  //   try {
  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(data),
  //     );

  //     if (response.statusCode == 200) {
  //    //   log('Device token updated successfully====>>>$deviceToken');
  //     } else {
  //     //  log('Failed to update device token');
  //     }
  //   } catch (error) {
  //     log('Error updating device token: $error');
  //   }
  // }

  void onForgetpassword() async {
    var pro = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? resetToken =
        pref.getString('reset_token'); // Retrieve the reset token
    log('Response of reset_token====>>>>>$resetToken');

    if (resetToken == null || resetToken.isEmpty) {
      log('Reset token is null or empty');
      commonToast(
          msg: 'Reset token not found. Please try again.', color: Colors.red);
      return;
    }

    if (pro.passController.text.isEmpty) {
      log('Password is required');
      commonToast(msg: 'Password is required', color: Colors.red);
    } else if (pro.cPassController.text.isEmpty) {
      log('Confirm password is required');
      commonToast(msg: 'Confirm password is required', color: Colors.red);
    } else if (pro.passController.text != pro.cPassController.text) {
      log('Passwords do not match');
      commonToast(msg: 'Passwords do not match', color: Colors.red);
    } else {
      var data = {
        'email': "munishwebpristine@gmail.com",
        'password': pro.passController.text,
        'password_confirmation': pro.cPassController.text,
        'reset_token': resetToken, // Use the reset token from SharedPreferences
      };

      pro.forgotPass(context: context, data: data).then((value) {
        navPushRemove(context: context, action: HomeScreen());
      }).catchError((error) {
        log('SignUp Error: $error');
        commonToast(msg: 'SignUp Error: $error', color: Colors.red);
      });
    }
  }
}
