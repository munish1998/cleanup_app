import 'package:cleanup_mobile/Auth_Screen/Login.dart';
import 'package:cleanup_mobile/Auth_Screen/Register.dart';
import 'package:cleanup_mobile/HomeScreen/HomeScreen.dart';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              child: Column(
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
                  Card(
                    elevation: 3,
                    child: Container(
                      height: 54,
                      width: 370,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17)),
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.email,
                              color: AppColor.rank1Color,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColor.rank1Color,
                                ),
                                borderRadius: BorderRadius.circular(17))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 3,
                    child: Container(
                      height: 54,
                      width: 370,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17)),
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.lock,
                              color: AppColor.rank1Color,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColor.rank1Color,
                                ),
                                borderRadius: BorderRadius.circular(17))),
                      ),
                    ),
                  ),
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
                                          'we will send you confirm code',
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
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    labelStyle: const TextStyle(
                                                        color: Colors.grey),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    border: InputBorder.none,
                                                    suffixIcon: const Icon(
                                                      Icons.email,
                                                      color:
                                                          AppColor.rank1Color,
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
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext) {
                                                  return Container(
                                                    height: 400,
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Column(
                                                          children: [
                                                            const Text(
                                                              'VERIFICATION CODE',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            // SizedBox(height: size.height * 0.03),
                                                            const Text(
                                                              'Enter your email or phone number',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.grey,
                                                                // fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            const Text(
                                                              'we will send you confirm code',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.grey,
                                                                // fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            //  SizedBox(height: size.height * 0.04),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children:
                                                                    _buildOtpFields()),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            // SizedBox(height: size.height * 0.03),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showModalBottomSheet(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext) {
                                                                      return Container(
                                                                        height:
                                                                            400,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 25),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Text(
                                                                                  'VERIFICATION CODE',
                                                                                  style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Colors.black,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                                // SizedBox(height: size.height * 0.03),
                                                                                const Text(
                                                                                  'Enter your email or phone number',
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    color: Colors.grey,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                                const Text(
                                                                                  'we will send you confirm code',
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    color: Colors.grey,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 12,
                                                                                ),
                                                                                //  SizedBox(height: size.height * 0.04),
                                                                                Row(mainAxisAlignment: MainAxisAlignment.center, children: _buildOtpFields()),
                                                                                const SizedBox(
                                                                                  height: 25,
                                                                                ),
                                                                                // SizedBox(height: size.height * 0.03),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    showModalBottomSheet(
                                                                                        context: context,
                                                                                        builder: (BuildContext) {
                                                                                          return Container(
                                                                                            height: 80,
                                                                                          );
                                                                                        });
                                                                                    // _showSignUpAlert();
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 54,
                                                                                    width: 370,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: Colors.lightBlue.shade300),
                                                                                    child: const Center(
                                                                                        child: Text(
                                                                                      'Verify',
                                                                                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                    )),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                // _showSignUpAlert();
                                                              },
                                                              child: Container(
                                                                height: 54,
                                                                width: 370,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  color: AppColor
                                                                      .rank1Color,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'Verify',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext) {
                                                    return Container(
                                                      height: 400,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 25),
                                                          child: Column(
                                                            children: [
                                                              const Text(
                                                                'VERIFICATION CODE',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              // SizedBox(height: size.height * 0.03),
                                                              const Text(
                                                                'Enter your email or phone number',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              const Text(
                                                                'we will send you confirm code',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey,
                                                                  // fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              //  SizedBox(height: size.height * 0.04),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children:
                                                                      _buildOtpFields()),
                                                              const SizedBox(
                                                                height: 25,
                                                              ),
                                                              // SizedBox(height: size.height * 0.03),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext) {
                                                                        return Container(
                                                                          height:
                                                                              400,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 20),
                                                                            child:
                                                                                Center(
                                                                              child: Column(
                                                                                children: [
                                                                                  const Text(
                                                                                    'Create New Password',
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
                                                                                    'Create your new password to login',
                                                                                    style: TextStyle(
                                                                                      fontSize: 15,
                                                                                      color: Colors.grey,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 15,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    child: Container(
                                                                                      height: 54,
                                                                                      width: 370,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.circular(17),
                                                                                      ),
                                                                                      child: TextFormField(
                                                                                        maxLines: 1,
                                                                                        obscureText: !_isChecked1, // Toggle password visibility based on _isChecked
                                                                                        decoration: InputDecoration(
                                                                                          labelText: 'new Password',
                                                                                          labelStyle: const TextStyle(color: Colors.grey),
                                                                                          contentPadding: const EdgeInsets.only(left: 10),
                                                                                          border: InputBorder.none,
                                                                                          suffixIcon: IconButton(
                                                                                            icon: Icon(
                                                                                              _isChecked1 ? Icons.visibility : Icons.visibility_off,
                                                                                              color: AppColor.rank1Color,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                _isChecked1 = !_isChecked1; // Toggle _isChecked state
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide(
                                                                                              color: AppColor.rank1Color,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(17),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 12,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    child: Container(
                                                                                      height: 54,
                                                                                      width: 370,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.circular(17),
                                                                                      ),
                                                                                      child: TextFormField(
                                                                                        maxLines: 1,
                                                                                        obscureText: !_isChecked1, // Toggle password visibility based on _isChecked
                                                                                        decoration: InputDecoration(
                                                                                          labelText: ' confirm Password',
                                                                                          labelStyle: const TextStyle(color: Colors.grey),
                                                                                          contentPadding: const EdgeInsets.only(left: 10),
                                                                                          border: InputBorder.none,
                                                                                          suffixIcon: IconButton(
                                                                                            icon: Icon(
                                                                                              _isChecked1 ? Icons.visibility : Icons.visibility_off,
                                                                                              color: AppColor.rank1Color,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                _isChecked1 = !_isChecked1; // Toggle _isChecked state
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: const BorderSide(
                                                                                              color: AppColor.rank1Color,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(17),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      showModalBottomSheet(
                                                                                          context: context,
                                                                                          builder: (BuildContext) {
                                                                                            return Container(
                                                                                              height: 400,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.only(top: 25),
                                                                                                child: Center(
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Image.asset('assets/images/image12.png'),
                                                                                                      const Text(
                                                                                                        'Success',
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      ),
                                                                                                      const Text(
                                                                                                        'you have Successfully reset your',
                                                                                                        style: TextStyle(color: Colors.grey),
                                                                                                      ),
                                                                                                      const Text(
                                                                                                        'Password',
                                                                                                        style: TextStyle(color: Colors.grey),
                                                                                                      ),
                                                                                                      const SizedBox(
                                                                                                        height: 20,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          height: 54,
                                                                                                          width: 370,
                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.lightBlue.shade300),
                                                                                                          child: const Center(
                                                                                                              child: Text(
                                                                                                            'Login',
                                                                                                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                          )),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          });
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 54,
                                                                                      width: 370,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(17),
                                                                                        color: AppColor.rank1Color,
                                                                                      ),
                                                                                      child: const Center(
                                                                                          child: Text(
                                                                                        'Create password',
                                                                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                  // _showSignUpAlert();
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 54,
                                                                  width: 370,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            17),
                                                                    color: AppColor
                                                                        .rank1Color,
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Verify',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .white,
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
                                                  });
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
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
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()),
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
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

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
}
