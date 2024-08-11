import 'package:cleanup_mobile/Auth_Screen/SignUp.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namecontroller = TextEditingController();
  bool isPass = true; // Start with obscured text
  bool isCPass = true; // Start with obscured text
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 248, 253, 255),
      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Image.asset('assets/images/image4.png'),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
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
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              textfields(
                                context: context,
                                controller: value.usernameController,
                                hint: 'Enter username',
                                icon: Icons.person,
                                ispas: false,
                                hintTextColor: Colors.grey,
                                index: 1,
                              ),
                              const SizedBox(height: 10),
                              textfields(
                                context: context,
                                controller: value.nameController,
                                hint: 'Enter name',
                                icon: Icons.person,
                                ispas: false,
                                hintTextColor: Colors.grey,
                                index: 1,
                              ),
                              const SizedBox(height: 10),
                              textfields(
                                context: context,
                                controller: value.emailController,
                                hint: 'Email',
                                icon: Icons.email,
                                ispas: false,
                                hintTextColor: Colors.grey,
                                index: 2,
                              ),
                              const SizedBox(height: 10),
                              textfields(
                                context: context,
                                controller: value.phoneController,
                                hint: 'Contact number',
                                icon: Icons.phone,
                                ispas: false,
                                hintTextColor: Colors.grey,
                                index: 3,
                              ),
                              const SizedBox(height: 10),
                              textfields(
                                context: context,
                                controller: value.locationController,
                                hint: 'Location',
                                icon: Icons.location_on,
                                ispas: false,
                                hintTextColor: Colors.grey,
                                index: 4,
                              ),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _isChecked,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _isChecked = newValue ?? false;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(fontSize: 15),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'I agree to the Cleaning ',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Terms of Service ',
                                            style: TextStyle(
                                              color: AppColor.rank1Color,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'and\n ',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                                color: AppColor.rank1Color),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: onTap,
                                child: Container(
                                  height: 54,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColor.rank1Color),
                                  child: const Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              AppColor.backgroundcontainerColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Already have an account? ',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                          color: AppColor.rank1Color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
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
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 68,
                    child: Divider(
                      height: 0.60,
                      thickness: 0.4,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          );
        },
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
  }) {
    return Card(
      elevation: 3,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: AppColor.backgroundcontainerColor,
          borderRadius: BorderRadius.circular(15),
        ),
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
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
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
  }

  void onTap() {
    var pro = Provider.of<AuthProvider>(context, listen: false);
    var data = {};
    if (pro.nameController.text.isEmpty) {
      log('Name is required');
      commonToast(msg: 'Name is required', color: Colors.red);
    } else if (pro.emailController.text.isEmpty) {
      log('Email is required');
      commonToast(msg: 'Email is required', color: Colors.red);
    } else if (!validateEmail(pro.emailController.text)) {
      log('Invalid email format');
      commonToast(msg: 'Invalid email format', color: Colors.red);
    } else if (pro.phoneController.text.isEmpty) {
      log('Contact number is required');

      commonToast(msg: 'Contact number is required', color: Colors.red);
    } else if (pro.locationController.text.isEmpty) {
      log('Country is required');
      commonToast(msg: 'Country is required', color: Colors.red);
    } else if (pro.passController.text.isEmpty) {
      log('Password is required');
      commonToast(msg: 'Password is required', color: Colors.red);
    } else if (pro.cPassController.text.isEmpty) {
      log('Confirm password is required');
      commonToast(msg: 'Confirm password is required', color: Colors.red);
    } else if (pro.passController.text != pro.cPassController.text) {
      log('Passwords do not match');
      commonToast(msg: 'Passwords do not match', color: Colors.red);
    } else if (!_isChecked) {
      log('You must agree to the terms and privacy policy');
      commonToast(
          msg: 'You must agree to the terms and privacy policy',
          color: Colors.red);
    } else {
      var data = {
        'username': pro.usernameController.text,
        'name': pro.nameController.text,
        'email': pro.emailController.text,
        'mobile': pro.phoneController.text,
        'password': pro.passController.text,
        'location': pro.locationController.text,
        'terms': "1",
        'password_confirmation': pro.cPassController.text,
        'is_admin': "0",
      };
      pro.signUp(context: context, data: data).then((value) {
        navPush(context: context, action: LoginScreen());
      }).catchError((error) {
        log('SignUp Error: $error');
        commonToast(msg: 'SignUp Error: $error', color: Colors.red);
      });
    }
  }

  bool validateEmail(String email) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email);
  }
}
