import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/login/login.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotApprovedScreen extends StatelessWidget {
  String email="";
  String password="";
  NotApprovedScreen({Key? key, this.email="", this.password=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You will be notified when your account is approved. Thank You.', style: TextStyle(color: Colors.white, fontSize: 18, height: 1.8), textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                  return normalButton(
                      primaryColor: ColorResources.COLOR_WHITE,
                      fontSize: 16,
                      button_text: 'Login',
                      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => LoginScreen(email: authProvider.email, password: authProvider.password,)),
                          ModalRoute.withName('/'),
                        );
                      });
                }
              )
            ],
          ),
        ),
      )
    ],);
  }
}
