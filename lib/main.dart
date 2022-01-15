import 'dart:async';

import 'package:doctor_v2/nurse_package/provider/form_provider.dart';
import 'package:doctor_v2/nurse_provider/app_provider.dart';
import 'package:doctor_v2/nurse_provider/appointment_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_provider/map_provider.dart';
import 'package:doctor_v2/nurse_provider/profile_provider.dart';
import 'package:doctor_v2/nurse_provider/service_preference_provider.dart';
import 'package:doctor_v2/nurse_provider/vital_sign_provider.dart';
import 'package:doctor_v2/nurse_provider/wallet_provider.dart';
import 'package:doctor_v2/nurse_views/going_patient/dash.dart';
import 'package:doctor_v2/nurse_views/going_patient/going_to_patient_screen.dart';
import 'package:doctor_v2/nurse_views/otp/otp_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/verification/form_verification_provider.dart';
import 'package:doctor_v2/nurse_views/verification/verification_provider.dart';
import 'package:doctor_v2/nurse_views/verification/verification_view.dart';
import 'package:doctor_v2/provider/app_provider.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/provider/profile_provider.dart';
import 'package:doctor_v2/provider/reviews_provider.dart';
import 'package:doctor_v2/provider/state_provider.dart';
import 'package:doctor_v2/provider/vital_sign_provider.dart';
import 'package:doctor_v2/provider/wallet_provider.dart';
import 'package:doctor_v2/views/profile_setup/upload_image.dart';
import 'package:doctor_v2/views/welcome/splash_screen.dart';
import 'package:doctor_v2/views/welcome/welcome_screen.dart';
import 'package:doctor_v2/z_ex/realtime_time.dart';
import 'package:doctor_v2/z_ex/tabb.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nurse_data/model/appointment_model.dart';
import 'nurse_utill/color_resources.dart';
import 'nurse_views/ui_kits/normalButton.dart';
import 'package/provider/form_provider.dart';
import 'provider/appointment_provider.dart';
import 'provider/consultation_provider.dart';
import 'provider/lab_test_provider.dart';
import 'provider/prescription_provider.dart';
import 'provider/schedule_provider.dart';
import 'views/login/login.dart';
import 'views/otp/otp_screen.dart';
import 'views/otp/widgets/not_approved.dart';
import 'views/verification/form_verification_provider.dart';
import 'views/verification/verification_provider.dart';
import 'views/vital_sign/vital_sign.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  saveNot(message);
  alertSound();
}

saveNot(message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('notification_time', message.sentTime.toString());
  await prefs.setString("title", message.data['title']);
  await prefs.setString("body", message.data['body']);
  await prefs.setString("distance", message.data['distance']);
  await prefs.setString("record_id", message.data['record_id']);
  await prefs.setString("request_id", message.data['request_id']);
}

alertSound() async {
  int counter = 0;
  /*
  Timer mytimer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
    FlutterBeep.playSysSound(iOSSoundIDs.SMSReceived);
  });
  */
  AudioPlayer player = AudioPlayer();
  await player.setAsset('assets/sound/the_Purge_Siren_2.mp3');
  player.setLoopMode(LoopMode.one);
  player.play();

  Timer mytimer = Timer.periodic(Duration(seconds: 10), (timer) {
    player.stop();
  });

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging;
  messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value){
    print('(*)(*)(*)(*)');
    print(value);
  });
  //runApp(MyApp());
  runApp(
      MultiProvider(
        providers: [
          //ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(create: (context) => AppProvider()),
          ChangeNotifierProvider(create: (context) => StateProvider()),
          ChangeNotifierProvider(create: (context) => VitalSignProvider()),
          ChangeNotifierProvider(create: (context) => ConsultationProvider()),
          ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ChangeNotifierProvider(create: (context) => ScheduleProvider()),
          ChangeNotifierProvider(create: (context) => FormProvider()),

          ChangeNotifierProvider(create: (context) => FormProviderNurse()),

          ChangeNotifierProvider(create: (context) => VerificationProvider()),
          ChangeNotifierProvider(create: (context) => VerificationNurseProvider()),
          ChangeNotifierProvider(create: (context) => FormVerificationProvider()),
          ChangeNotifierProvider(create: (context) => FormVerificationNurseProvider()),
          ChangeNotifierProvider(create: (context) => PrescriptionProvider()),
          ChangeNotifierProvider(create: (context) => LabTestProvider()),

          ChangeNotifierProvider(create: (context) => NurseAuthProvider()),
          ChangeNotifierProvider(create: (context) => ProfileNurseProvider()),
          ChangeNotifierProvider(create: (context) => AppointmentNurseProvider()),

          ChangeNotifierProvider(create: (context) => AppProviderNurse()),
          ChangeNotifierProvider(create: (context) => MapNurseProvider()),
          ChangeNotifierProvider(create: (context) => VitalSignNurseProvider()),

          ChangeNotifierProvider(create: (context) => ReviewsProvider()),

          ChangeNotifierProvider(create: (context) => WalletProvider()),
          ChangeNotifierProvider(create: (context) => NurseWalletProvider()),
          ChangeNotifierProvider(create: (context) => NurseServicePreferenceProvider()),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'SonoCare Partner',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen()//WelcomeScreen()//OTPScreen(password: '123456', email: 'abdu12345@mail.com',)//MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}