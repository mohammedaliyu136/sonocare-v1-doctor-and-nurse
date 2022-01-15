import 'dart:convert';

import 'package:doctor_v2/data/model/appointment_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/provider/appointment_provider.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/calling/calling.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/doctor_patient_options/doctor_patient_options_screen.dart';
import 'package:doctor_v2/views/prescription/prescription_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class AcceptAppointmentScreen extends StatefulWidget {
  AppointmentModel appointment;
  bool accepted;
  AcceptAppointmentScreen({Key? key, required AppointmentModel this.appointment, this.accepted = false}) : super(key: key);

  @override
  _AcceptAppointmentScreenState createState() {
    return _AcceptAppointmentScreenState();
  }
}

class _AcceptAppointmentScreenState extends State<AcceptAppointmentScreen> {
  bool isShowVial = false;
  String subPage = 'infor';
  bool gettingToken = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showAboutPatient(context){
    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
        return Column(children: [
          /*
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
          */
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
              Expanded(child: Text(widget.appointment.getAppointmentDateTimeSTR(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, letterSpacing: 1.1),))
            ],),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                //this.isShowVial = true;
                subPage='vital';
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top:30.0, bottom: 8, left: 15, right: 15),
              child: Row(children: [
                Text('Vital Signs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_WHITE, letterSpacing: 1.1),),
                SizedBox(width: 15,),
                Image.asset('assets/icons/go_arrow.png')
              ],),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                //this.isShowVial = true;
                subPage='med_history';
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top:10.0, bottom: 8, left: 15, right: 15),
              child: Row(children: [
                Text('Medical History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_WHITE, letterSpacing: 1.1),),
                SizedBox(width: 15,),
                Image.asset('assets/icons/go_arrow.png')
              ],),
            ),
          ),
        ],);
      }
    );
  }
  showVitals(BuildContext context){
    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20),
            child: Row(
              children: [
                Text('Vital Signs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
            child: Row(children: [
              Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Temperature', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Pulse rate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Respiration rate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Blood group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Sp02', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Body Mass Index', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('random', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Blood sugar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Height, weight and BMI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                    ],)),
              if(appointmentProvider.patientModel.vitals.length>0)Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.vitals[appointmentProvider.patientModel.vitals.length-1].temperature, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.vitals[appointmentProvider.patientModel.vitals.length-1].pulseRate, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.vitals[appointmentProvider.patientModel.vitals.length-1].respiration, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.vitals[appointmentProvider.patientModel.vitals.length-1].bloodGroup, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.vitals[appointmentProvider.patientModel.vitals.length-1].sp02, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.vitals[appointmentProvider.patientModel.vitals.length-1].bodyMass, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('-', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Normal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Average', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                    ],)
              ),
              if(appointmentProvider.patientModel.vitals.length==0)Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(' - ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                    ],)
              )
            ],),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                this.isShowVial = false;
                subPage='med_history';
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top:10.0, bottom: 8, left: 15, right: 15),
              child: Row(children: [
                Text('Patient details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_PURPLE_MID, letterSpacing: 1.1),),
                SizedBox(width: 15,),
                Image.asset('assets/icons/go_arrow.png')
              ],),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                this.isShowVial = false;
                subPage='med_history';
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top:10.0, bottom: 8, left: 15, right: 15),
              child: Row(children: [
                Text('Medical History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_PURPLE_MID, letterSpacing: 1.1),),
                SizedBox(width: 15,),
                Image.asset('assets/icons/go_arrow.png')
              ],),
            ),
          ),
        ],);
      }
    );
  }
  showMedicalHistory(BuildContext context){
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 20),
        child: Row(
          children: [
            Text('Medical History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('DOB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('Are You Hypertensive?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('Are You Diabetic?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('Are You Asthmatic?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('Have You Suffered Stroke?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('GenoType', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text('Blood Group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                ],)),
          Expanded(
              flex: 3,
              child: Consumer<AppointmentProvider>(
                  builder: (context, appointmentProvider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.gender, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.dob, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.check, size: 19,),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.check, size: 19,),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.check, size: 19,),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.check, size: 19,),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.genoType, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                      SizedBox(height: 1, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.5),),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(appointmentProvider.patientModel.bloodGroup, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                      ),
                    ],);
                }
              ))
        ],),
      ),
      GestureDetector(
        onTap: (){
          setState(() {
            this.isShowVial = false;
            subPage='infor';
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top:10.0, bottom: 8, left: 15, right: 15),
          child: Row(children: [
            Text('Patient details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_PURPLE_MID, letterSpacing: 1.1),),
            SizedBox(width: 15,),
            Image.asset('assets/icons/go_arrow.png')
          ],),
        ),
      ),
      GestureDetector(
        onTap: (){
          setState(() {
            this.isShowVial = false;
            subPage='vital';
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top:0.0, bottom: 8, left: 15, right: 15),
          child: Row(children: [
            Text('Vital Signs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_PURPLE_MID, letterSpacing: 1.1),),
            SizedBox(width: 15,),
            Image.asset('assets/icons/go_arrow.png')
          ],),
        ),
      ),
    ],);
  }

  @override
  Widget build(BuildContext context) {
    print('----------------------');
    print(widget.appointment.status);
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
          return Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
                if(appointmentProvider.isLoading){
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(child: Text('Loading...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: ColorResources.COLOR_WHITE),),));
                }else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(children: [
                        Stack(
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
                                                  //image: AssetImage("assets/dummy/profile_dummy.png"),
                                                  image: NetworkImage(AppConstants.BASE_URL+appointmentProvider.patientModel.image),
                                                )
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          //Todo: add loading...
                                          Text(appointmentProvider.patientModel.firstName+' '+appointmentProvider.patientModel.otherName+' '+appointmentProvider.patientModel.lastName, style: TextStyle(
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(children: [
                                    Image.asset('assets/icons/back-arrow_icon.png'),
                                  ],),
                                ),
                              ),
                            )
                          ],
                        ),
                        //if(!isShowVial)showAboutPatient(context),
                        //if(isShowVial)showVitals(context),
                        if(subPage=='infor')showAboutPatient(context),
                        if(subPage=='vital')showVitals(context),
                        if(subPage=='med_history')showMedicalHistory(context),

                        Spacer(),
                        if(widget.appointment.status=='0')Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Expanded(child: normalButton(
                                button_text: 'Decline',
                                fontSize: 14,
                                primaryColor: ColorResources.COLOR_WHITE,
                                backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                                onTap: () {
                                  String token = Provider.of<AuthProvider>(context, listen: false).token;
                                  appointmentProvider.declineAppointment(context, token, widget.appointment.id.toString()).then((ResponseModel response){
                                    if(response.isSuccess){
                                      Navigator.pop(context);
                                    }else{
                                      print(response.message);
                                    }
                                  });
                                },
                              )),
                              SizedBox(width: 30,),
                              Expanded(child: normalButton(
                                button_text: 'Accept',
                                fontSize: 14,
                                primaryColor: ColorResources.COLOR_WHITE,
                                backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                                onTap: () {
                                  setState(() {
                                    widget.accepted=true;
                                  });

                                  String token = Provider.of<AuthProvider>(context, listen: false).token;
                                  appointmentProvider.acceptAppointment(context, token, widget.appointment.id.toString()).then((ResponseModel response){
                                    if(response.isSuccess){
                                      //Navigator.pop(context);
                                      setState(() {
                                        widget.appointment.status='1';
                                      });
                                    }else{
                                      print(response.message);
                                    }
                                  });

                                },
                              )),
                            ],
                          ),
                        ),
                        if(widget.appointment.status=='1')if(!gettingToken)Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Expanded(child: normalButton(
                                button_text: 'Options',
                                fontSize: 14,
                                primaryColor: ColorResources.COLOR_WHITE,
                                backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                                onTap: () {
                                  appointmentProvider.setSelectedAppointment(widget.appointment);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DoctorPatientOptionsScreen()),
                                  );
                                  /*
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PrescriptionScreen(appointmentID: widget.appointment.id,)),
                                  );
                                  */
                                },
                              )),
                              SizedBox(width: 10,),
                              Expanded(child: normalButton(
                                button_text: 'Call Patient',
                                fontSize: 14,
                                primaryColor: ColorResources.COLOR_WHITE,
                                backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                                onTap: () {
                                  print('-----------900');
                                  setState(() {
                                    gettingToken=true;
                                  });

                                  //String channel = "doctor${authProvider.userInfoModel!.id}${widget.appointment.time.split(':').join("")}";
                                  String channel = "doctor${authProvider.userInfoModel!.id}";
                                  print(channel);
                                  String doc_uid = "${authProvider.userInfoModel!.id}";
                                  http.get(Uri.parse('https://sonocare-agora.herokuapp.com/access_token?channelName=${channel}')).then((value){
                                    setState(() {
                                      gettingToken=false;
                                    });
                                    String token = jsonDecode(value.body)['token'];
                                    print('00000000000000');
                                    print(channel);
                                    print(token);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CallingScreen(channel: channel, token: token, remoteUID: doc_uid,)),
                                    );

                                  });

                                  setState(() {
                                    gettingToken=false;
                                  });
                                  /*
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CallingScreen(channel: '', token: '', remoteUID: '',)),
                                  );
                                  */
                                },
                              )),
                            ],
                          ),
                        ),
                        if(widget.appointment.status=='2')Text('Appointment Rejected by You', style: TextStyle(color: Colors.white, fontSize: 20),),
                        if(gettingToken)Center(child: Text('Getting Authorisation for call, please wait...', style: TextStyle(color: Colors.white),))
                      ],),
                    ),
                  );
                }
            }
          );
        }
      ),
    ],);
  }
}
