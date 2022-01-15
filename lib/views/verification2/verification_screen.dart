import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:flutter/material.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/utill/images.dart';
import 'package:provider/provider.dart';
import "dart:math";

import 'line.dart';
import 'steps/step_1.dart';
import 'steps/step_2.dart';
import 'steps/step_3.dart';
import 'steps/step_4.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen();

  @override
  _VerificationScreenState createState() {
    return _VerificationScreenState();
  }
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool step_1 = true;
  bool step_2 = false;
  bool step_3 = false;
  bool step_4 = false;

  nextStep({stepName}){
    if(stepName=='step_1'){
      setState(() {
        step_1 = true;
        step_2 = false;
        step_3 = false;
        step_4 = false;
      });
    }else if(stepName=='step_2'){
      setState(() {
        step_1 = false;
        step_2 = true;
        step_3 = false;
        step_4 = false;
      });
    }else if(stepName=='step_3'){
      setState(() {
        step_1 = false;
        step_2 = false;
        step_3 = true;
        step_4 = false;
      });
    }else if(stepName=='step_4'){
      setState(() {
        step_1 = false;
        step_2 = false;
        step_3 = false;
        step_4 = true;
      });
    }
  }

  previousStep({stepName}){
    if(stepName=='step_1'){
      setState(() {
        step_1 = true;
        step_2 = false;
        step_3 = false;
        step_4 = false;
      });
    }else if(stepName=='step_2'){
      setState(() {
        step_1 = true;
        step_2 = false;
        step_3 = false;
        step_4 = false;
      });
    }else if(stepName=='step_3'){
      setState(() {
        step_1 = false;
        step_2 = true;
        step_3 = false;
        step_4 = false;
      });
    }else if(stepName=='step_4'){
      setState(() {
        step_1 = false;
        step_2 = false;
        step_3 = true;
        step_4 = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
              //authProvider.startVerification("1");
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 40.0, bottom: 8.0),
                    child: Text('Verification', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: ()=>nextStep(stepName: 'step_1'),
                        child: Container(
                          height: 30,
                          width: 45,
                          color: step_1?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          child: Center(child: Text("Step 1", style: TextStyle(fontWeight: FontWeight.w800, color: step_1?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK, fontSize: 12),)),
                        ),
                      ),
                      CustomPaint(
                        painter: TrianglePainter(
                          strokeColor: step_1?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: ()=>nextStep(stepName: 'step_2'),
                        child: Container(
                          height: 30,
                          width: 45,
                          color: step_2?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          child: Center(child: Text("Step 2", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: step_2?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK,),)),
                        ),
                      ),
                      CustomPaint(
                        painter: TrianglePainter(
                          strokeColor: step_2?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: ()=>nextStep(stepName: 'step_3'),
                        child: Container(
                          height: 30,
                          width: 45,
                          color: step_3?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          child: Center(child: Text("Step 3", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: step_3?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK),)),
                        ),
                      ),
                      CustomPaint(
                        painter: TrianglePainter(
                          strokeColor: step_3?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: ()=>nextStep(stepName: 'step_4'),
                        child: Container(
                          height: 30,
                          width: 45,
                          color: step_4?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          child: Center(child: Text("Step 4", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: step_4?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK),)),
                        ),
                      ),
                      CustomPaint(
                        painter: TrianglePainter(
                          strokeColor: step_4?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],),

                      step_1? Expanded(child: PersonalInformation(nextButton: ()=>nextStep(stepName: 'step_2')))
                    : step_2? Expanded(child: BusinessInformation(nextButton: ()=>nextStep(stepName: 'step_3')))
                    : step_3? Expanded(child: MedicalInformation(nextButton: ()=>nextStep(stepName: 'step_4')))
                    : step_4? Expanded(child: CompanyInformation())
                    :         Expanded(child: Container()),
                ],),
              );
            }
          ),
        ),
      ],
    );
  }
}
