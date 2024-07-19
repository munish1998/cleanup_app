import 'dart:developer';
import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:cleanup_mobile/Utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var emailExpression = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2}");

RegExp regex1 =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

RegExp regex = RegExp(r'^[a-zA-Z0-9_]*$');

var regIFSC = RegExp(r"^[A-Z]{4}[0]{1}[A-Z0-9]{6}");
var regPan = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");

var regUPI = RegExp('/[a-zA-Z0-9_]{3,}@[a-zA-Z]{3,}/');

Future<void> navPushh(
    {required BuildContext context, required Widget action}) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => action));
}

Future<void> navPush(
    {required BuildContext context, required Widget action}) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (ctx) => action),
  );
}

void navPushReplace({required BuildContext context, required Widget action}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (ctx) => action),
  );
}

void navPushRemove({required BuildContext context, required Widget action}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (ctx) => action), (route) => false);
}

void navPop({required BuildContext context}) {
  Navigator.pop(context);
}

Widget viewAllButton(
        {required BuildContext context,
        required double radius,
        required Widget action}) =>
    InkWell(
      onTap: () {
        navPush(context: context, action: action);
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: AppColor.rank1Color),
        child: Text(
          'View All',
          style: TextStyle(fontSize: 11, color: AppColor.rank2Color),
        ),
      ),
    );

Widget button3(
        {required String label,
        required bool isNext,
        required Function() onTap}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                tileMode: TileMode.clamp,
                colors: [
                  Color(0xff02B660),
                  Color(0xff51CDE2),
                ])),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.mulish(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              (isNext)
                  ? Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
Widget button(
        {required String label,
        required bool isNext,
        required Function() ontap}) =>
    InkWell(
      onTap: ontap,
      child: Container(
        height: 54,
        width: 370,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.rank1Color),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: 20,
                  color: AppColor.backgroundcontainerColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
void commonAlert(BuildContext context, String message) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData.dark(),
        child: CupertinoAlertDialog(
          title: Text(
            appName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Container(
            padding: EdgeInsets.all(15),
            // color: Colors.black,
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColor.mytaskColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

OutlineInputBorder get border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 1, color: AppColor.rank1Color),
    );
