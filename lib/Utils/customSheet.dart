import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 12),
              const Text(
                'Enter your email or phone number',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'we will send you a confirm code',
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
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 80,
                        child: Center(
                          child: Text('Code Verified!'),
                        ),
                      );
                    },
                  );
                },
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _otpfields() {
    List<Widget> otpFields = [];
    for (int i = 0; i < 4; i++) {
      otpFields.add(Padding(padding: EdgeInsets.only(top: 3)));
    }
    return otpFields;
  }

  List<Widget> _buildOtpFields() {
    List<Widget> otpFields = [];
    for (int i = 0; i < 4; i++) {
      otpFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            width: 40,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      );
    }
    return otpFields;
  }
}
