import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showtoast({required String message}){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16,
    );
}