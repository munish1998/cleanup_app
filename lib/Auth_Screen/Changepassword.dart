import 'dart:developer';

import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isPass = true; // Start with obscured text
  bool isCPass = true; // Start with obscured text
  bool _isChecked = false;
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
                            'ChangePassword',
                            style: TextStyle(
                                color: AppColor.backgroundcontainerColor,
                                fontSize: 20),
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
                          textfields(
                            context: context,
                            controller: value.passController,
                            hint: 'Password',
                            icon: isPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            ispas: isPass,
                            hintTextColor: Colors.grey,
                            index: 5,
                          ),
                          const SizedBox(height: 10),
                          textfields(
                            context: context,
                            controller: value.cPassController,
                            hint: 'Confirm password',
                            icon: isCPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            ispas: isCPass,
                            hintTextColor: Colors.grey,
                            index: 6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: onForgetpassword,
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

  Widget textfields({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool ispas,
    required int index,
    required Color hintTextColor,
  }) =>
      Card(
        elevation: 3,
        child: Container(
          height: 54,
          width: 370,
          decoration: BoxDecoration(
              color: AppColor.backgroundcontainerColor,
              borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            keyboardType: index == 2
                ? TextInputType.emailAddress
                : index == 3
                    ? TextInputType.phone
                    : TextInputType.text,
            obscureText: ispas,
            textCapitalization: TextCapitalization.none,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 15),
              hintText: hint,
              hintStyle: TextStyle(color: hintTextColor),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.rank1Color),
                borderRadius: BorderRadius.circular(17),
              ),
              border: InputBorder.none,
              suffixIcon: (index == 5 || index == 6)
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          if (index == 5) {
                            isPass = !isPass;
                          } else if (index == 6) {
                            isCPass = !isCPass;
                          }
                        });
                      },
                      child: Icon(
                        ispas ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      );
  void onForgetpassword() {
    var pro = Provider.of<AuthProvider>(context, listen: false);

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
        'email': " munishrai.mr1998@gmail.com",
        'password': pro.passController.text,
        'password_confirmation': pro.cPassController.text,
        'reset_token': "64a1e12c59d67b19ba485f4325804d4e",
      };

      pro.forgotPass(context: context, data: data).then((value) {
        navPush(context: context, action: HomeScreen());
      }).catchError((error) {
        log('SignUp Error: $error');
        commonToast(msg: 'SignUp Error: $error', color: Colors.red);
      });
    }
  }
}
