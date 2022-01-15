import 'package:doctor_v2/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  late SharedPreferences sharedPreferences;

  AppProvider(){
    initialization();
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  initialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  getToken(){
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

}