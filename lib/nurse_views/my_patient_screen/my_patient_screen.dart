import 'package:doctor_v2/nurse_provider/appointment_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/accept_appointment/accept_appointment_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPatientsScreen extends StatelessWidget {
  MyPatientsScreen();

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
            title: Text('My Appointment'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Consumer<AppointmentNurseProvider>(
              builder: (context, appointmentProvider, child) {
                print('-------------------');
                print(appointmentProvider.appointments.length);
                if(appointmentProvider.isLoading){
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(child: Text('Loading...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: ColorResources.COLOR_WHITE),),));
                }else{
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: textFieldNotStyled(),
                      ),
                      Column(
                        children: List.generate(appointmentProvider.appointments.length, (index) {
                          return GestureDetector(
                            onTap: (){
                              String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                              Provider.of<AppointmentNurseProvider>(context, listen: false).getAppointmentDetail(context, appointmentProvider.appointments[index].id,token, index);
                              Provider.of<AppointmentNurseProvider>(context, listen: false).getPatientDetail(context, appointmentProvider.appointments[index].patientID);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AcceptAppointmentScreen(appointment:appointmentProvider.appointments[index])),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(100)),
                                          image:DecorationImage(
                                            fit:BoxFit.fill,
                                            image: AssetImage("assets/dummy/profile_dummy.png"),
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(appointmentProvider.appointments[index].patientName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(appointmentProvider.appointments[index].getDate(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                            SizedBox(width: 20,),
                                            Text(appointmentProvider.appointments[index].getTime(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                          ],
                                        ),
                                      ],)
                                  ],),
                                ),
                              ),
                            ),
                          );
                        }),),
                      /*
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          Container(height: 50, width: 50, color: Colors.grey,),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          Container(height: 50, width: 50, color: Colors.grey,),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          Container(height: 50, width: 50, color: Colors.grey,),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          Container(height: 50, width: 50, color: Colors.grey,),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          Container(height: 50, width: 50, color: Colors.grey,),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                        ],),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          Container(height: 50, width: 50, color: Colors.grey,),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                        ],),
                      ),
                    ),
                  ),
                  */
                    ],),
                  );
                }
              }
          ),
        ),
      ),
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
    ],);
  }
}
