import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

class TermCondition extends StatefulWidget {
  const TermCondition({super.key});

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 253, 255),
      appBar: AppBar(
        title: Text('Term and Condition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1.Service Scope',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(AppColor.service),
            SizedBox(
              height: 15,
            ),
            Text(
              '2.Booking and payment',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(AppColor.service),
            SizedBox(
              height: 15,
            ),
            Text(
              '3.Cancel and reschduling',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(AppColor.service),
            SizedBox(
              height: 15,
            ),
            Text(
              '4.Customer obligations',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(AppColor.service),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 54,
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColor.rank1Color,
              ),
              child: const Center(
                  child: Text(
                'I agree',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
