import 'dart:async';
import 'dart:convert';

import 'package:doctor_v2/main.dart';
import 'package:doctor_v2/nurse_provider/map_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/going_patient/going_to_patient_screen.dart';
import 'package:doctor_v2/nurse_views/going_patient/map_screen.dart';
import 'package:doctor_v2/nurse_views/going_patient/map_screen3.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProviderNurse with ChangeNotifier {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get scaffoldKey => _scaffoldKey;

  BuildContext? _context;
  get context => _context;

  bool run = true;
  var _message = '';

  DatabaseReference databaseRef =
  FirebaseDatabase.instance.reference().child('vital');

  StreamSubscription<Event>? _counterSubscription;

  var stream = 0;

  AppProvider(){
    initialization();
  }

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  initialization() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved provider");
      print(event.notification!.body);
    });
  }

  setFire() async {
    if(run){
      handleAppLifecycleState();

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("onMessage: ${message.data}");
        print("title: ${message.data['title']}");
        print("title: ${message.data['body']}");
        print("title: ${message.data['distance']}");
        print("title: ${message.data['record_id']}");
        print('from provider 231');//request_id
        showAlertDialog(
            message.data['title'],
            message.data['body'],
            message.data['distance'],
            message.data['record_id'],
            message.data['request_id']
        );
        run = false;
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('Message clicked!');
        showAlertDialog(
            message.data['title'],
            message.data['body'],
            message.data['distance'],
            message.data['record_id'],
            message.data['request_id']
        );
        run = false;
      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      run=false;
    }

  }
  holdNotification(message){
    _message = message;
  }
  handleAppLifecycleState() {
    AppLifecycleState _lastLifecyleState;
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      print('SystemChannels> $msg');
      switch (msg) {
        case "AppLifecycleState.paused":
          _lastLifecyleState = AppLifecycleState.paused;
          print("AppLifecycleState.paused");
          break;
        case "AppLifecycleState.inactive":
          _lastLifecyleState = AppLifecycleState.inactive;
          break;
        case "AppLifecycleState.resumed":
          //await Future.delayed(const Duration(seconds: 1), (){});
          _lastLifecyleState = AppLifecycleState.resumed;
          print("AppLifecycleState.resumed");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.reload();
          String notification_time = await prefs.getString('notification_time')??'';
          String title = await prefs.getString('title')??'';
          String body = await prefs.getString('body')??'';
          String distance = await prefs.getString('distance')??'';
          String record_id = await prefs.getString('record_id')??'';
          String request_id = await prefs.getString('request_id')??'';
          print(notification_time);
          print(title);
          print(body);
          print(distance);
          print(record_id);
          showAlertDialog(title, body, distance, record_id, request_id);

          break;
        default:
      }
    });
  }
  setContext(BuildContext context){
    _context=context;
  }

  getToken(){
    //return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }


  showAlertDialog(title, body, distance, record_id, request_id) {
    //BuildContext context = _context!;
    BuildContext context = _scaffoldKey.currentContext!;
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
                  color: Colors.purple,
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
                                    image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/sonocare-51b1c.appspot.com/o/dummy.PNG?alt=media&token=226c2bed-8be5-41a8-aac1-e6b2bbd098fc"),
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            //Todo: add loading...
                            Text(title, style: TextStyle(
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
              showAboutPatient(context, body,
                  distance,
                  record_id),
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
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GoingToPatientScreen(title:title, body:body, distance:distance, record_id:record_id, request_id:request_id)),
                        );
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
  showAboutPatient(context, body, distance, record_id){
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
          Expanded(child: Text(body, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, height: 1.3, wordSpacing: 1.3, letterSpacing: 1.1),))
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
          Expanded(child: Text(distance, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, letterSpacing: 1.1),))
        ],),
      ),
    ],);
  }

}