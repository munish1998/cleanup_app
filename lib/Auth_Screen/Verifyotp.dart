import 'dart:developer';

import 'package:cleanup_mobile/Providers/authProvider.dart';
import 'package:cleanup_mobile/Utils/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpControllers = List<TextEditingController>.generate(
      4, (index) => TextEditingController());
  final _focusNodes = List<FocusNode>.generate(4, (index) => FocusNode());

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter the 4-digit code sent to your number',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => _onOtpChanged(value, index),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onVerify,
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
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
}
