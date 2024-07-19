import 'package:cleanup_mobile/Auth_Screen/Login.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/commonMethod.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

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
            child: Center(
                child: Consumer<AuthProvider>(builder: (context, data, child) {
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
                      controller: data.emailController,
                      hint: 'email',
                      icon: Icons.email,
                      ispas: false,
                      index: 0,
                      hintTextColor: AppColor.leaderboardtextColor),
                  const SizedBox(
                    height: 10,
                  ),
                  textfields(
                      context: context,
                      controller: data.passController,
                      hint: 'password',
                      icon: Icons.email,
                      ispas: false,
                      index: 0,
                      hintTextColor: AppColor.leaderboardtextColor),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: onLogin,
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const MyWidget()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 15),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Dont have an account? ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColor.rank1Color,
                            ),
                          ),
                        ],
                      ),
                    ),
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
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 15),
              hintText: hint,
              hintStyle: TextStyle(color: hintTextColor),
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

  List<Widget> _buildOtpFields() {
    List<Widget> otpFields = [];
    for (int index = 0; index < _otpControllers.length; index++) {
      otpFields.add(
        Container(
          width: 66,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _otpControllers[index].text.isNotEmpty
                ? Colors.white
                : Colors.grey,
            border: Border.all(
              color: _otpControllers[index].text.isNotEmpty
                  ? AppColor.rank1Color
                  : Colors.grey,
            ),
          ),
          child: TextFormField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1,
            onChanged: (value) {
              setState(() {
                // Trigger a rebuild to update the color
              });
              if (value.isNotEmpty && index < _otpControllers.length - 1) {
                _focusNodes[index].unfocus();
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              }
              if (value.isEmpty && index > 0) {
                _focusNodes[index].unfocus();
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
          ),
        ),
      );
    }
    return otpFields;
  }

  void showCustomBottomModelSheet(
      {required BuildContext context, required String text, required}) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
          ),
        );
      },
    );
  }

  Future<void> onLogin() async {
    var pro = Provider.of<AuthProvider>(context, listen: false);
    var data = {};
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
      data = {
        'email': pro.emailController.text,
        'password': pro.passController.text, // Corrected line
        // 'location': pro.address,
        // 'fcm_id': pro.token,
      };
      pro.login(context: context, data: data).then((value) {
        if (pro.isLogin) {
          log('Login Here-------------------- $data');
          navPush(context: context, action: HomeScreen());
        }
      });
    }
  }
}
