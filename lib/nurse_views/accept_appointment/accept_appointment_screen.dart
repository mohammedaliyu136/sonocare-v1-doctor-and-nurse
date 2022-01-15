import 'dart:convert';

import 'package:doctor_v2/nurse_data/model/appointment_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_provider/appointment_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
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
    return Consumer<AppointmentNurseProvider>(
        builder: (context, appointmentProvider, child) {
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
              Expanded(child: Text(widget.appointment.getAppointmentDateTimeSTR(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, letterSpacing: 1.1),))
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
    );
  }
  showVitals(BuildContext context){
    return Consumer<AppointmentNurseProvider>(
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
              Expanded(
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
                    ],))
            ],),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                this.isShowVial = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top:30.0, bottom: 8, left: 15, right: 15),
              child: Row(children: [
                Text('Patient details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ColorResources.COLOR_PURPLE_MID, letterSpacing: 1.1),),
                SizedBox(width: 15,),
                Image.asset('assets/icons/go_arrow.png')
              ],),
            ),
          ),
        ],);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    print('----------------------');
    print(widget.appointment.status);
    // TODO: implement build
    return Stack(children: [
      /*
      Container(
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10),
          gradient: new LinearGradient(
              colors: [
                ColorResources.COLOR_PURPLE_DEEP_O,
                ColorResources.COLOR_PURPLE_MID,
              ],
              begin: const FractionalOffset(1.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Spacer(),
          Row(
            children: [
              Image.asset(Images.scope),
            ],
          ),
        ],),
      ),*/
      BackGround(),
      Consumer<NurseAuthProvider>(
          builder: (context, authProvider, child) {
          return Consumer<AppointmentNurseProvider>(
              builder: (context, appointmentProvider, child) {
                if(appointmentProvider.isLoading){
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(child: Text('Loading...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: ColorResources.COLOR_WHITE),),));
                }else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
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
                                                  image: NetworkImage(AppConstants.BASE_URL+widget.appointment.image),
                                                )
                                            ),
                                            /*
                                            child: Image.network(
                                              AppConstants.BASE_URL+widget.appointment.image,// appointmentProvider.pendingAppointments[index]!.image,
                                              fit: BoxFit.fitHeight,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) return child;

                                                //return Center(child: Text('Loading...'));
                                                return CircularProgressIndicator();
                                                // You can use LinearProgressIndicator or CircularProgressIndicator instead
                                              },
                                              errorBuilder: (context, error, stackTrace) =>
                                              //Text('Some errors occurred!'),
                                              Image.asset("assets/dummy/profile_dummy.png"),
                                            ),
                                            */
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
                        showAboutPatient(context),
                        //if(isShowVial)showVitals(context),

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Expanded(child: normalButton(
                                button_text: 'Decline',
                                fontSize: 14,
                                primaryColor: ColorResources.COLOR_WHITE,
                                backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                                onTap: () {
                                  String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                                  appointmentProvider.declineAppointment(context, token, widget.appointment.id.toString()).then((ResponseModelNurse response){
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

                                  String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                                  appointmentProvider.acceptVitalSignAppointments(context, token, widget.appointment.id.toString()).then((ResponseModelNurse response){
                                    if(response.isSuccess){
                                      /*
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => GoingToPatientScreen(appointment:widget.appointment)),
                                      );
                                      */
                                    }else{
                                      print(response.message);
                                    }
                                  });

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
