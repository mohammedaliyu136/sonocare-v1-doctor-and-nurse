import 'package:doctor_v2/nurse_provider/app_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_views/register/register.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/utill/images.dart';
import 'package:doctor_v2/views/login/login.dart';
import 'package:doctor_v2/views/register/register.dart';
import 'package:doctor_v2/views/ui_kits/normalButton.dart';
import 'package:doctor_v2/views/ui_kits/outLineButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProviderNurse>(context, listen: false).setFire();
    Provider.of<AppProviderNurse>(context, listen: false).setContext(context);
  }

  @override
  void dispose() {
    super.dispose();
  }


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
                button_text: 'Sign Up as Nurse',
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
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40, top: 0, bottom: 10),
          child: Row(
            children: [
              Expanded(child: outLineButton(
                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                button_text: 'Sign Up as Doctor',
                primaryColor: ColorResources.COLOR_WHITE,
                fontSize: 14,
                onTap: (){
                  Provider.of<AuthProvider>(context, listen: false).getServicePreferences();
                  Provider.of<AuthProvider>(context, listen: false).getDoctorType();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
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
