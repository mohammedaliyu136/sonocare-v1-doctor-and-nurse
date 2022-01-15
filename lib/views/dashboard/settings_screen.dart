import 'package:doctor_v2/views/forget_password/forget_password.dart';
import 'package:doctor_v2/views/settings/about_screen.dart';
import 'package:doctor_v2/views/settings/help_screen.dart';
import 'package:doctor_v2/views/settings/privacy_screen.dart';
import 'package:doctor_v2/views/settings/reset_password.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:flutter/material.dart';


class SettingsScreenDash extends StatelessWidget {
  SettingsScreenDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      //DarkBackGround(),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(children: [
            ListTile(title: Text('Notification', style: TextStyle(color: Colors.white),),leading: Icon(Icons.notifications, color: Colors.white,), trailing: Switch(onChanged: (bool value) {  }, value: true,activeColor: Colors.green,)),
            ListTile(title: Text('Account Settings', style: TextStyle(color: Colors.white),),leading: Icon(Icons.person, color: Colors.white,), trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
            ListTile(
                title: Text('Privacy', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.visibility, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyScreen()),
                  );
                },
            ),
            ListTile(
                title: Text('Security', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.lock, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                onTap: (){
                  //Navigator.push(
                   // context,
                   // MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                  //);
                  //ForgetPasswordScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                  );
                },
            ),
            ListTile(
                title: Text('Ads', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.all_out_sharp, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
            ListTile(
                title: Text('Help', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.camera, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
            ListTile(
                title: Text('About', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.info, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
          ]))
    ],);
  }
}
