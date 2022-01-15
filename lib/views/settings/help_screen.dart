import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {

  TextEditingController _otpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      DarkBackGround(),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
            title: Text('Help', style: TextStyle(color: Colors.white),),
            elevation: 0,
          ),
          body: ListView(children: [])
      )
    ],);
  }
}
