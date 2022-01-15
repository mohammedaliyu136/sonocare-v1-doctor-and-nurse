import 'package:doctor_v2/nurse_provider/app_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_views/register/register.dart';
import 'package:doctor_v2/views/welcome/welcome_screen.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/utill/images.dart';
import 'package:doctor_v2/views/login/login.dart';
import 'package:doctor_v2/views/register/register.dart';
import 'package:doctor_v2/views/ui_kits/normalButton.dart';
import 'package:doctor_v2/views/ui_kits/outLineButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getLoginType();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getLoginType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_login_type = await prefs.getString('user_login_type')??'';

    if(user_login_type.length>1){
      Provider.of<AppProviderNurse>(context, listen: false).setFire();
      Provider.of<AppProviderNurse>(context, listen: false).setContext(context);
      if(user_login_type=='doctor'){
        Provider.of<AuthProvider>(context, listen: false).getUserDetail(context: context);
      }
      if(user_login_type=='nurse'){
        Provider.of<NurseAuthProvider>(context, listen: false).getUserDetail(context: context);
      }
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Row(
              children: [
                Image.asset(Images.scope),
              ],
            ),
          ],),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(Images.main_logo),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
              child: Text('Welcome to SonoCare, your health is our priority', style: TextStyle(
                  height: 2,
                  color: ColorResources.COLOR_WHITE,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ), textAlign: TextAlign.center,),
            ),
              CircularProgressIndicator()
          ],),
        ],
      ),
    );
  }
}
