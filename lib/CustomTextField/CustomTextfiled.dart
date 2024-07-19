import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool hidePassword;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.hidePassword = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: 370,
      decoration: BoxDecoration(
        //color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: widget.prefixIcon,
              ),
            ],
            Expanded(
              child: TextFormField(
                maxLines: 1,
                obscureText: obscureText && widget.hidePassword,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: widget.hidePassword
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.rank1Color,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: widget.suffixIcon,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Password Visibility Toggle')),
      body: const Center(
        child: CustomTextField(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          hidePassword: true,
        ),
      ),
    ),
  ));
}
