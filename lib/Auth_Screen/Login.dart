import 'dart:developer';

import 'package:cleanup_mobile/Auth_Screen/SignUp.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/MyTaskScreen/myTask.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController namecontroller = TextEditingController();
  bool _isChecked = false;
  bool _isChecked1 = false;
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
                          // textfields(
                          //     context: context,
                          //     controller: namecontroller,
                          //     hint: 'enter name',
                          //     icon: Icons.person,
                          //     ispas: true,
                          //     hintTextColor: Colors.grey,
                          //     index: 1),
                          // const SizedBox(
                          //   height: 2,
                          // ),
                          // textfieldsss(
                          //     context: context,
                          //     controller: value.areaController,
                          //     hint: 'enter mail',
                          //     icon: Icons.email,
                          //     color: AppColor.rank1Color,
                          //     isPas: true,
                          //     index: 2),
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
                                decoration: InputDecoration(
                                    // hintText: 'email',
                                    labelText: 'Enter username ',
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
                            height: 2,
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
                                decoration: InputDecoration(
                                    // hintText: 'email',
                                    labelText: 'Enter name ',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(
                                      Icons.calendar_today,
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
                            height: 2,
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
                                decoration: InputDecoration(
                                    // hintText: 'email',
                                    labelText: 'location',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(
                                      Icons.calendar_today,
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
                            height: 2,
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
                                decoration: InputDecoration(
                                    // hintText: 'email',
                                    labelText: 'Phone Number',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColor.rank1Color),
                                        borderRadius:
                                            BorderRadius.circular(17))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
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
                                decoration: InputDecoration(
                                    // hintText: 'email',
                                    labelText: 'Email',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(
                                      Icons.email,
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
                            height: 2,
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              height: 54,
                              width: 370,
                              decoration: BoxDecoration(
                                color: AppColor.backgroundcontainerColor,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: TextFormField(
                                maxLines: 1,
                                obscureText:
                                    !_isChecked1, // Toggle password visibility based on _isChecked
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  contentPadding:
                                      const EdgeInsets.only(left: 10),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isChecked1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColor.rank1Color,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isChecked1 =
                                            !_isChecked1; // Toggle _isChecked state
                                      });
                                    },
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColor.rank1Color),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isChecked = newValue ?? false;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                  //width: size.width * 0.02,
                                ),
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
                                        text: 'privacy policy',
                                        style: TextStyle(
                                            color: AppColor.rank1Color),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()),
                              );
                            },
                            child: Container(
                              height: 54,
                              width: 370,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.rank1Color),
                              child: const Center(
                                  child: Text(
                                'Sign Up',
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
        elevation: 1,
        child: Container(
          height: 54,
          width: 370,
          decoration: BoxDecoration(
              color: AppColor.backgroundcontainerColor,
              borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            keyboardType: (index == 0)
                ? TextInputType.name
                : (index == 1)
                    ? TextInputType.text
                    : (index == 2)
                        ? TextInputType.emailAddress
                        : (index == 3)
                            ? TextInputType.datetime
                            : (index == 4)
                                ? TextInputType.number
                                : TextInputType.text,
            obscureText: ispas,
            textCapitalization:
                (index == 0 || index == 3 || index == 4 || index == 5)
                    ? TextCapitalization.words
                    : TextCapitalization.none,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(color: Colors.grey),
            //  textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15, top: 15),
              hintText: hint,

              hintStyle: TextStyle(color: hintTextColor),
              // Custom hint text color
              isDense: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.rank1Color),
                  borderRadius: BorderRadius.circular(17)),
              border: InputBorder.none,
              suffixIcon: index == 6 || index == 7
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          ispas = !ispas;
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

  Widget textfieldsss(
          {required BuildContext context,
          required TextEditingController controller,
          required String hint,
          required IconData icon,
          required Color color,
          required bool isPas,
          required Color clr,
          required int index}) =>
      Container(
        color: AppColor.backgroundcontainerColor,
        child: TextFormField(
          keyboardType: (index == 0)
              ? TextInputType.name
              : (index == 1)
                  ? TextInputType.emailAddress
                  : TextInputType.text,
          obscureText: !isPas,
          textCapitalization: (index == 0 || index == 3 || index == 5)
              ? TextCapitalization.words
              : TextCapitalization.none,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(),
          inputFormatters: [
            if (index == 0) LengthLimitingTextInputFormatter(50),
            if (index == 1) LengthLimitingTextInputFormatter(50),
            if (index == 3) LengthLimitingTextInputFormatter(50)
          ],
          decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  if (index == 6) {
                    setState(() {
                      isPas = !isPas;
                    });
                  } else if (index == 7) {
                    setState(() {});
                  }
                },
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              hintText: hint,
              hintStyle: TextStyle(),
              isDense: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10))),
        ),
      );
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
          navPushRemove(context: context, action: MyTaskList());
        }
      });
    }
    // log('Login Here-------------------- $data');
  }
}
