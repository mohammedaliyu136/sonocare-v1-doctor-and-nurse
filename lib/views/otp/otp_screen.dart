import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';

import 'widgets/otp_form.dart';

class OTPScreen extends StatelessWidget {
  String email="";
  String password="";
  OTPScreen({required this.email, required this.password});
  FocusNode _1Focus = FocusNode();
  FocusNode _2Focus = FocusNode();
  TextEditingController _1Controller = TextEditingController();
  TextEditingController _2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        BackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                Text('OTP', style: TextStyle(fontSize: 32, color: Colors.white),),
                SizedBox(height: 100,),
                Text('Check your email for OTP', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                SizedBox(height: 0,),
                /*
                Row(children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      focusNode: _1Focus,
                      //nextFocus: _2Focus,
                      controller: _1Controller,
                    ),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      focusNode: _2Focus,
                      //nextFocus: _2Focus,
                      controller: _2Controller,
                    ),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(),
                  )),
                ],),
                SizedBox(height: 60,),
                normalButton(
                  primaryColor: ColorResources.COLOR_WHITE,
                  fontSize: 16,
                  button_text: 'Submit',
                  backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  },
                ),
                */
                OtpForm(email:email, password: password,)

              ],),
          ),
        ),
      ],
    );
  }
}
