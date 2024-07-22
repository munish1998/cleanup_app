import 'dart:developer';

import 'package:cleanup_mobile/Auth_Screen/SignIn.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({super.key});

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      body: Stack(
        children: [
          Image.asset('assets/images/image4.png'),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          const Text(
                            'Welcome to',
                            style: TextStyle(
                                color: AppColor.backgroundcontainerColor,
                                fontSize: 20),
                          ),
                          const Text(
                            'Sign up',
                            style: TextStyle(
                                color: AppColor.backgroundcontainerColor,
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
                          const SizedBox(
                            height: 90,
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              height: 54,
                              width: 370,
                              decoration: BoxDecoration(
                                  color: AppColor.backgroundcontainerColor,
                                  borderRadius: BorderRadius.circular(17)),
                              child: TextFormField(
                                maxLines: 1,
                                controller: value.emailController,
                                decoration: InputDecoration(
                                    // hintText: 'email',
                                    labelText: 'Enter email ',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(
                                      Icons.person,
                                      color: AppColor.rank1Color,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColor.rank1Color),
                                        borderRadius:
                                            BorderRadius.circular(17))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: onSendotp,
                            child: Container(
                              height: 54,
                              width: 370,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.rank1Color),
                              child: const Center(
                                  child: Text(
                                'Send Otp',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.backgroundcontainerColor,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 68, // Set the width of the SizedBox
                child: Divider(
                  height: 0.60,
                  thickness: 0.4,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onSendotp() async {
    var pro = Provider.of<AuthProvider>(context, listen: false);
    var data = {};
    if (pro.emailController.text.isEmpty) {
      customToast(context: context, msg: 'Email ID required', type: 0);
    } else if (!emailExpression.hasMatch(pro.emailController.text)) {
      customToast(context: context, msg: 'Enter valid Email ID', type: 0);
    } else {
      data = {
        'email': pro.emailController.text,
      };
      pro.sendOtp(context: context, data: data).then((value) {
        if (pro.isForgot) {
          log('Login Here-------------------- $data');

          //  navPush(context: context, action: VerificationScreen());
        }
      });
    }
    // log('Login Here-------------------- $data');
  }
}
