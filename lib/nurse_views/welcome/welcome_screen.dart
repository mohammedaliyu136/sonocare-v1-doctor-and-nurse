import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_utill/images.dart';
import 'package:doctor_v2/nurse_views/login/login.dart';
import 'package:doctor_v2/nurse_views/register/register.dart';
import 'package:doctor_v2/nurse_views/ui_kits/normalButton.dart';
import 'package:doctor_v2/nurse_views/ui_kits/outLineButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        Image.asset(Images.main_logo),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
          child: Text('Welcome to SonoCare, your health is our priority', style: TextStyle(
              color: ColorResources.COLOR_WHITE,
              fontSize: 16,
              fontWeight: FontWeight.w400
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(child: normalButton(
                //backgroundColor: ColorResources.COLOR_PURPLE_MID,
                backgroundColor: Colors.red,
                button_text: 'Log in',
                primaryColor: ColorResources.COLOR_WHITE,
                fontSize: 16,
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40, top: 0, bottom: 10),
          child: Row(
            children: [
              Expanded(child: outLineButton(
                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                button_text: 'Sign Up',
                primaryColor: ColorResources.COLOR_WHITE,
                fontSize: 14,
                onTap: (){
                  Provider.of<NurseAuthProvider>(context, listen: false).getServicePreferences();
                  Provider.of<NurseAuthProvider>(context, listen: false).getNurseService();
                  Provider.of<NurseAuthProvider>(context, listen: false).getNurseType();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterNurseScreen()),
                  );
                },
              )),
            ],
          ),
        ),
        Row(
          children: [
            Image.asset(Images.scope),
          ],
        ),
      ],),
    );
  }
}
