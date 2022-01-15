import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/accept_appointment/accept_appointment_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
//my_patient_screen
class MessageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Message'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Center(child: Text('You have no messages', style: TextStyle(color: Colors.white, fontSize: 16),),)
        ),
      ),
    ],);
  }
}
