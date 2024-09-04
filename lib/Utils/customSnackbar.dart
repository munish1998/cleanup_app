import 'package:cleanup_mobile/Utils/AppConstant.dart';
import 'package:flutter/material.dart';

void showTopSnackBar(BuildContext context, String message,
    {Color backgroundColor = AppColor.rank1Color}) {
  final overlay = Overlay.of(context);
  final snackBar = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(message, style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(snackBar);

  Future.delayed(Duration(seconds: 2)).then((_) {
    snackBar.remove();
  });
}
