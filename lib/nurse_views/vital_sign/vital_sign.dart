import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/vitalSignModel.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_provider/vital_sign_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VitalSign extends StatelessWidget {
  String vitalSignId;
  VitalSign({Key? key, required this.vitalSignId}) : super(key: key);
  final bloodPressureController = TextEditingController();
  final temperatureController = TextEditingController();
  final pulseRateController = TextEditingController();
  final respirationController = TextEditingController();
  final sp02Controller = TextEditingController();
  final bodyMassIndexController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Vital Sign'),
          elevation: 0,
          leading: GestureDetector(
              onTap: ()=>Navigator.pop(context),
              child: Image.asset('assets/icons/back-arrow_icon.png')),
        ),
        body: Consumer<VitalSignNurseProvider>(
            builder: (context, vitalSignProvider, child) {
            return SafeArea(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(children: [
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Blood pressure (BP)', style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(height: 8,),
                  Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(flex:8,child: TextField(textAlign: TextAlign.end, controller: bloodPressureController,)),
                          Expanded(flex:2,child: Container(child: Text('mmHg'),))
                        ],
                      )),
                    SizedBox(height: 10,),
                ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Temperature (T)', style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(height: 8,),
                  Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(flex:8,child: TextField(textAlign: TextAlign.end, controller: temperatureController,)),
                          Expanded(flex:2,child: Container(child: Text('C'),))
                        ],
                      )),
                    SizedBox(height: 10,),
                ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Pulse rate (PR)', style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(height: 8,),
                  Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(flex:8,child: TextField(textAlign: TextAlign.end, controller: pulseRateController)),
                          Expanded(flex:2,child: Container(child: Text('bpm'),))
                        ],
                      )),
                    SizedBox(height: 10,),
                ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Respiration rate (RR)', style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(height: 8,),
                  Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(flex:8,child: TextField(textAlign: TextAlign.end, controller: respirationController,)),
                          Expanded(flex:2,child: Container(child: Text(''),))
                        ],
                      )),
                    SizedBox(height: 10,),
                ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Sp02', style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(height: 8,),
                  Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(flex:8,child: TextField(textAlign: TextAlign.end, controller: sp02Controller,)),
                          Expanded(flex:2,child: Container(child: Text('%'),))
                        ],
                      )),
                    SizedBox(height: 10,),
                ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Body mass index (BMI)', style: TextStyle(color: Colors.white, fontSize: 18),),
                  SizedBox(height: 8,),
                  Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(flex:8,child: TextField(textAlign: TextAlign.end, controller: bodyMassIndexController,)),
                          Expanded(flex:2,child: Container(child: Text(''),))
                        ],
                      )),
                    SizedBox(height: 10,),
                ],),
              SizedBox(height: 20,),
                if(vitalSignProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                if(!vitalSignProvider.isLoading)Row(
                children: [
                  Expanded(
                    child: normalButton(
                      backgroundColor: ColorResources.COLOR_PURPLE_MID,
                      button_text: 'Submit',
                      primaryColor: ColorResources.COLOR_WHITE,
                      fontSize: 16, onTap: () {
                      String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                      vitalSignProvider.updateVitalSign(
                          token,
                          VitalSignModel(
                              vitalSignId: int.parse(this.vitalSignId),
                              bloodPressure: bloodPressureController.text,
                              temperature: temperatureController.text,
                              pulseRate: pulseRateController.text,
                              respiration: respirationController.text,
                              sp02: sp02Controller.text,
                              bodyMassIdex: bodyMassIndexController.text
                          )
                      ).then((ResponseModelNurse responseModel){
                        if(responseModel.isSuccess){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => DashboardNurseScreen()),
                            ModalRoute.withName('/'),
                          );
                        }else{
                          showCustomSnackBar('Something went wrong', context, isError: true);
                        }
                      });

                    },
                    ),
                  ),
                ],
              )
              ],),
            ),);
          }
        ),
      )
    ],);
  }
}
