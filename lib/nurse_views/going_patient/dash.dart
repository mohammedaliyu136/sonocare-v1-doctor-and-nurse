import 'dart:async';

import 'package:doctor_v2/nurse_data/model/appointment_model.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/going_patient/going_to_patient_screen.dart';
import 'package:doctor_v2/nurse_views/going_patient/settings.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/normalButton.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  Dash({Key? key}) : super(key: key);

  @override
  _DashState createState() {
    return _DashState();
  }
}

class _DashState extends State<Dash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  showAboutPatient(context){
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top:20.0, bottom: 8, left: 15, right: 15),
        child: Row(children: [
          Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1.1),)
        ],),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(children: [
          Expanded(child: Text('Family Physician, General Medicine, General Practitioner, Pulmonology(Asthma doctors). Internal Medicine', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, height: 1.3, wordSpacing: 1.3, letterSpacing: 1.1),))
        ],),
      ),
      Padding(
        padding: const EdgeInsets.only(top:30.0, bottom: 8, left: 15, right: 15),
        child: Row(children: [
          Text('Appointment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1.1),)
        ],),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(children: [
          //  26th May 2021 (09:00 AM - 10 PM)
          Expanded(child: Text('10-12-2020', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, letterSpacing: 1.1),))
        ],),
      ),
      Padding(
        padding: const EdgeInsets.only(top:30.0, bottom: 8, left: 15, right: 15),
        child: Row(children: [
          Text('Distance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1.1),)
        ],),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(children: [
          //  26th May 2021 (09:00 AM - 10 PM)
          Expanded(child: Text('5km', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, letterSpacing: 1.1),))
        ],),
      ),
    ],);
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding:  const EdgeInsets.all(0.0),
      backgroundColor: Colors.green,
      content: Stack(
        children: [
          BackGround(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: ColorResources.COLOR_PURPLE_MID,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          400, 150.0)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            //SizedBox(height: 20,),
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  image:DecorationImage(
                                    fit:BoxFit.fill,
                                    image: AssetImage("assets/dummy/profile_dummy.png"),
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            //Todo: add loading...
                            Text('Mohammed Kabir Aliyu', style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              showAboutPatient(context),
              //if(isShowVial)showVitals(context),

              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Row(
                  children: [
                    Expanded(child: normalButton(
                      button_text: 'Decline',
                      fontSize: 14,
                      primaryColor: ColorResources.COLOR_WHITE,
                      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
                    SizedBox(width: 30,),
                    Expanded(child: normalButton(
                      button_text: 'Accept',
                      fontSize: 14,
                      primaryColor: ColorResources.COLOR_WHITE,
                      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                      onTap: () {
                        //GoingToPatientScreen
                        /*
                        Navigator.pop(context);
                        AppointmentModel appointmentModel = AppointmentModel();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GoingToPatientScreen(appointment:appointmentModel)),
                        );
                        */
                      },
                    )),
                  ],
                ),
              ),
            ],),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Timer(Duration(seconds: 7), () {
      print("Yeah, this line is printed after 3 seconds");
      showAlertDialog(context);
    });
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Settings()),
          );
        }, child: Text('Settings'))
      ],),
    );
  }
}