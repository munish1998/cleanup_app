import 'dart:developer';

import 'package:cleanup_mobile/Auth_Screen/Register.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked1 = false;
  List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
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
                      Image.asset('assets/images/image6.png'),
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
                      ispas: true,
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
                            context: context,
                            builder: (BuildContext context) {
                              return Consumer<AuthProvider>(
                                builder: (context, authProvider, child) {
                                  return Container(
                                    height: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const Text(
                                              'FORGET PASSWORD?',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            const Text(
                                              'Enter your email or phone number',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Text(
                                              'We will send you confirm code',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                              child: Card(
                                                elevation: 3,
                                                child: Container(
                                                  height: 54,
                                                  width: 370,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17)),
                                                  child: TextFormField(
                                                    controller: authProvider
                                                        .emailController,
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                        labelText: 'Email',
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        border:
                                                            InputBorder.none,
                                                        suffixIcon: const Icon(
                                                          Icons.email,
                                                          color: AppColor
                                                              .rank1Color,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: AppColor
                                                                      .rank1Color,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            17))),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                // Call onSendOtp function
                                                await onSendOtp(context);
                                              },
                                              child: Container(
                                                height: 54,
                                                width: 370,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: AppColor.rank1Color,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'Send Otp',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
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

  Widget textfields(
      {required BuildContext context,
      required TextEditingController controller,
      required String hint,
      required IconData icon,
      required bool ispas,
      required int index,
      required Color hintTextColor}) {
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
          )
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
            if (value.isNotEmpty) {
              if (index + 1 < _otpControllers.length) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else {
                FocusScope.of(context).unfocus();
              }
            }
          },
        ),
      );
    });
  }

  Future<void> onSendOtp(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var data = {};

    if (authProvider.emailController.text.isEmpty) {
      customToast(context: context, msg: 'Email ID required', type: 0);
    } else if (!emailExpression.hasMatch(authProvider.emailController.text)) {
      customToast(context: context, msg: 'Enter valid Email ID', type: 0);
    } else {
      data = {
        'email': authProvider.emailController.text,
      };

      try {
        await authProvider.sendOtp(context: context, data: data);
        // Show the verification code bottom sheet after OTP is sent
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
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildOtpFields()),
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: onVerify,
                            // Verify code logic here

                            child: Container(
                              height: 54,
                              width: 370,
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
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      } catch (e) {
        // Handle errors here
        customToast(context: context, msg: 'Failed to send OTP', type: 0);
      }
    }
  }

  void onVerify() async {
    var pro = Provider.of<AuthProvider>(context, listen: false);

    // Collect OTP by combining the text from all controllers
    String otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      customToast(context: context, msg: 'Please enter all 4 digits', type: 0);
      return;
    }

    var data = {
      'email': "munishrai.mr1998@gmail.com", // Adjust this if needed
      'otp': otp,
    };

    if (pro.isForgot) {
      pro.verifyOTP(context: context, data: data).then((value) {
        if (pro.isVerify) {
          // Navigate to ChangePassScreen or handle verification success
          // navPush(context: context, action: ChangePassScreen());
        }
      }).catchError((error) {
        log('Error verifying OTP: $error');
        customToast(context: context, msg: 'Verification failed', type: 0);
      });
    } else {
      pro.verifyOTP(context: context, data: data).then((value) {
        if (pro.isVerify) {
          // Navigate to DashboardScreen or handle verification success
          // navPushRemove(context: context, action: DashboardScreen());
        }
      }).catchError((error) {
        log('Error verifying OTP: $error');
        customToast(context: context, msg: 'Verification failed', type: 0);
      });
    }

    log('OTP Verified Here------------${pro.isForgot}-------- $data');
  }

  Future<void> onLogin() async {
    var pro = Provider.of<AuthProvider>(context, listen: false);
    var data = {};
    if (pro.lEmailController.text.isEmpty) {
      customToast(context: context, msg: 'Email ID required', type: 0);
    } else if (!emailExpression.hasMatch(pro.lEmailController.text)) {
      customToast(context: context, msg: 'Enter valid Email ID', type: 0);
    } else if (pro.lPassController.text.isEmpty) {
      customToast(context: context, msg: 'Please enter password', type: 0);
    } else if (pro.lPassController.text.length < 8) {
      customToast(
          context: context, msg: 'Please enter 8 digit password', type: 0);
    } else {
      data = {
        'email': pro.emailController.text,
        'password': pro.passController.text,
      };

      pro.login(context: context, data: data).then((value) {
        if (pro.isLogin) {
          log('Login Here-------------------- $data');
          navPushRemove(context: context, action: HomeScreen());
        }
      });
    }
    // log('Login Here-------------------- $data');
  }
}
