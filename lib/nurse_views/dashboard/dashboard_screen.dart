import 'dart:async';

import 'package:doctor_v2/nurse_package/provider/form_provider.dart';
import 'package:doctor_v2/nurse_provider/app_provider.dart';
import 'package:doctor_v2/nurse_provider/appointment_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_provider/schedule_provider.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/calling/calling.dart';
import 'package:doctor_v2/nurse_views/dashboard/chat_list.dart';
import 'package:doctor_v2/nurse_views/dashboard/settings_screen.dart';
import 'package:doctor_v2/nurse_views/invoice/invoice.dart';
import 'package:doctor_v2/nurse_views/message/message.dart';
import 'package:doctor_v2/nurse_views/my_patient_screen/my_patient_screen.dart';
import 'package:doctor_v2/nurse_views/pending_appointment/pending_appointment_screen.dart';
import 'package:doctor_v2/nurse_views/profile_setup/profile_setup.dart';
import 'package:doctor_v2/nurse_views/reviews/reviews.dart';
import 'package:doctor_v2/nurse_views/schedule_timing/schedule_timing_screen.dart';
import 'package:doctor_v2/nurse_views/service_preference/service_reference_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/nurse_views/wallet/wallet_screen.dart';
import 'package:doctor_v2/nurse_views/withdraw/withdraw.dart';
import 'package:doctor_v2/views/welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'widgets/lg_container.dart';
import 'widgets/sm_container.dart';
class DashboardNurseScreen extends StatefulWidget {
  DashboardNurseScreen({Key? key}) : super(key: key);

  @override
  _DashboardNurseScreenState createState() {
    return _DashboardNurseScreenState();
  }
}

class _DashboardNurseScreenState extends State<DashboardNurseScreen> {
  int index = 0;
  late DatabaseReference _vitalRef;
  late StreamSubscription<Event> _vitalSubscription;

  late StreamSubscription<Event> _counterSubscription;
  late DatabaseReference _counterRef;


  @override
  void initState() {
    super.initState();
    /*
    _vitalRef = FirebaseDatabase.instance.reference().child('sonocare-51b1c-default-rtdb');

    _vitalSubscription = _vitalRef.onValue.listen((Event event) {
      print(event.snapshot.value ?? 0);
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      print(error);
    });
    */

    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        print(event.snapshot.value ?? 0);
      });
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        BackGround(),
        Consumer<NurseAuthProvider>(
            builder: (context, authProvider, child) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              key: Provider.of<AppProviderNurse>(context, listen: false).scaffoldKey,
              appBar: AppBar(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 4,),
                    Text('Hello,', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),),
                    SizedBox(height: 4,),
                    Text('${authProvider.userInfoModel!.firstName}', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),)
                    //Text('${Provider.of<AuthProvider>(context, listen: false).userInfoModel!.firstName}', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),)
                  ],),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        Provider.of<FormProviderNurse>(context, listen: false).getStates(selectedState: -1, selectedLGA: -1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileSetUPNurseScreen(upDateProfile:true)),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 57,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            image:DecorationImage(
                              fit:BoxFit.fill,
                              image: NetworkImage(AppConstants.BASE_URL+authProvider.userInfoModel!.image),                            )
                        ),
                      ),
                    ),
                  )
                ],
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_PURPLE_MID,
                          borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(470, 150.0)),
                          //borderRadius: BorderRadius.only(bottomRight: Radius.circular(100), bottomLeft: Radius.circular(100))
                          //shape: BoxShape.circle,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  image:DecorationImage(
                                    fit:BoxFit.fill,
                                    image: NetworkImage(AppConstants.BASE_URL+authProvider.userInfoModel!.image),                                  )

                              ),
                            ),
                            SizedBox(width: 10,),
                            Text('${authProvider.userInfoModel!.firstName}',  style: TextStyle(fontSize: 20, color: ColorResources.COLOR_WHITE),)

                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60, top: 0, bottom: 0),
                        title: const Text('PROFILE'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileSetUPNurseScreen()),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('MY PATIENTS'), //My Patients
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyPatientsScreen()),
                          );
                        },
                      ),
                      /*
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('WITHDRAWALS'),//Withdrawals
                        onTap: () {
                          //WithdrawScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WithdrawScreen()),
                          );
                        },
                      ),
                      */
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('WALLET'),//Wallet
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WalletScreen()),
                          );
                        },
                      ),
                      Divider(),
                      /*
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('Schedule Timings'),
                        onTap: () {
                          //WithdrawScreen
                          String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                          Provider.of<ScheduleProvider>(context, listen: false).getSchedules(context, token, day: DateTime.now().weekday.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScheduleTimingScreen()),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('Invoices'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InvoiceScreen()),
                          );
                        },
                      ),
                      Divider(),
                       */
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('REVIEWS'),//Reviews
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewsScreen()),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('MESSAGES'),//Message
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessageScreen()),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('SETTINGS'),//Profile Settings
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 60),
                        title: const Text('LOGOUT'),//Logout
                        onTap: () async {
                          await authProvider.logout();
                          //Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()),
                            ModalRoute.withName('/'),
                          );
                        },
                      ),
                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
              body: index==0?Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18, top: 10, bottom: 60),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(child: normalButton(
                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                          button_text: 'Update Profile',
                          primaryColor: ColorResources.COLOR_WHITE,
                          fontSize: 16,
                          onTap: (){
                            int stateId = authProvider.userInfoModel!.stateID==null?-1:int.parse(Provider.of<NurseAuthProvider>(context, listen: false).userInfoModel!.stateID);
                            int lgaId = authProvider.userInfoModel!.lgaID==null?-1:int.parse(Provider.of<NurseAuthProvider>(context, listen: false).userInfoModel!.lgaID);
                            Provider.of<FormProviderNurse>(context, listen: false).getStates(selectedState: stateId, selectedLGA: lgaId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileSetUPNurseScreen(upDateProfile:true)),
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: LGConatiner(heading: 'Set Preference', body: 'Schedule a consultation with a doctor',),
                    onTap: (){
                      Provider.of<NurseAuthProvider>(context, listen: false).getNurseService();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServicePreferenceScreen()),
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    child: LGConatiner(heading: 'Appointment', body: 'You have no bookings at the moment', imageUrl: 'assets/icons/appointment_icon.png'),
                    onTap: (){
                      print('get appointments');
                      String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                      print(token);
                      Provider.of<AppointmentNurseProvider>(context, listen: false).getAppointments(context, token, '0');
                      //Provider.of<AppointmentNurseProvider>(context, listen: false).getRequests(context, token, '0');

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PendingAppointmentScreen()),
                      );

                    },
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 55,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        /*
                        GestureDetector(onTap: ()async{
                          tz.initializeTimeZones();
                          String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
                          tz.setLocalLocation(tz.getLocation(timeZoneName));

                          final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                          FlutterLocalNotificationsPlugin();

                          await flutterLocalNotificationsPlugin.zonedSchedule(
                              0,
                              'scheduled title',
                              'scheduled body',
                              tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
                              const NotificationDetails(
                                  android: AndroidNotificationDetails('your channel id',
                                      'your channel name', 'your channel description')),
                              androidAllowWhileIdle: true,
                              uiLocalNotificationDateInterpretation:
                              UILocalNotificationDateInterpretation.absoluteTime);
                        },
                          child: SMConatiner(title:  'Total Patient'),),
                      */
                      SMConatiner(title:  'Total Patient'),
                      SMConatiner(title:  'Today\'s Patient'),
                      SMConatiner(title:  'Hospital Patient'),
                    ],),
                  ),
                  /*
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      print('get appointments');
                      String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                      Provider.of<AppointmentProvider>(context, listen: false).getAppointments(context, token, '1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPatientsScreen()),
                      );
                    },
                    child: LGConatiner(heading: 'Consultation', body: 'You have no bookings at the moment', bgColorTXT:'colored', imageUrl: 'assets/icons/consultation_icon.png'),
                  ),*/
                  SizedBox(height: 30,),
                ],),
              ):
                index==1?ChatListScreenDash():
              //index==1?Center(child: Text('Messages', style: TextStyle(fontSize: 50, color: Colors.white),)):
              //Center(child: Text('Settings', style: TextStyle(fontSize: 50, color: Colors.white),)),
              SettingsScreenDash(),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Colors.green,
                iconSize: 40,
                currentIndex: index,
                onTap: (current_index){
                  setState(() {
                    index=current_index;
                  });
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: index==0?
                      Image.asset("assets/icons/home_icon.png", height: 40, width: 40)
                          :Image.asset("assets/icons/home_icon_light.png", height: 40, width: 40),
                      label: 'ss',
                      backgroundColor: Colors.green
                  ),
                  BottomNavigationBarItem(
                    icon: index==1?
                    Image.asset("assets/icons/chat_icon.png", height: 40, width: 40)
                        :Image.asset("assets/icons/chat_icon_light.png", height: 40, width: 40),
                    label: 'aa',
                  ),
                  BottomNavigationBarItem(
                    icon: index==2?
                    Image.asset("assets/icons/settings_icon.png", height: 40, width: 40)
                        :Image.asset("assets/icons/settings_icon_light.png", height: 40, width: 40),
                    label: 'qq',
                  ),
                ],
              ),
            );
          }
        ),
        /*
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_PURPLE_DEEP,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Icon(Icons.home, color: Colors.white,),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_PURPLE_DEEP,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Icon(Icons.chat, color: Colors.white,),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_PURPLE_DEEP,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Icon(Icons.settings, color: Colors.white,),
                ),
            ],),
          ),
        )
        */
      ],
    );
  }
}
