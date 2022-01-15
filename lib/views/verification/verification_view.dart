import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/otp/widgets/not_approved.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/views/verification2/line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form_verification_provider.dart';
import 'model/verificationModel.dart';
import 'steps/step01.dart';
import 'steps/step02.dart';
import 'steps/step03.dart';
import 'steps/step04.dart';
import 'verification_provider.dart';

class VerificationView extends StatefulWidget {
  VerificationView({Key? key}) : super(key: key);

  @override
  _VerificationViewState createState() {
    return _VerificationViewState();
  }
}

class _VerificationViewState extends State<VerificationView> {
  int step = 1;
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
    //Provider.of<AuthProvider>(context, listen: false).getDoctorType();

    return Stack(
      children: [
        BackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 20.0),
            child: Text('Verification', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
          ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Consumer<FormVerificationProvider>(
              builder: (context, formVerificationProvider, child) {
              return Consumer<VerificationProvider>(
                  builder: (context, verificationProvider, child) {
                    if(verificationProvider.isUploading){
                      return Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Column(children: [
                            Text('Uploading Verification Information', style: TextStyle(fontSize: 18, color: Colors.white),)
                          ],)
                        ],),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Column(children: [
                            verificationProvider.isUploadingPersonalInfo?CircularProgressIndicator():verificationProvider.isDoneUploadingPersonalInfo?Icon(Icons.check_circle, color: Colors.green, size: 30,):Icon(Icons.check_circle, color: Colors.grey, size: 30,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Personal Information', style: TextStyle(color: Colors.white),),
                            )
                          ],)
                        ],),
                          SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Column(children: [
                            verificationProvider.isUploadingBusinessInfo?CircularProgressIndicator():verificationProvider.isDoneUploadingBusinessInfo?Icon(Icons.check_circle, color: Colors.green, size: 30,):Icon(Icons.check_circle, color: Colors.grey, size: 30,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Work Details', style: TextStyle(color: Colors.white),),
                            )
                          ],)
                        ],),
                          SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Column(children: [
                            verificationProvider.isUploadingMedicalInfo?CircularProgressIndicator():verificationProvider.isDoneUploadingMedicalInfo?Icon(Icons.check_circle, color: Colors.green, size: 30,):Icon(Icons.check_circle, color: Colors.grey, size: 30,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Medical Information', style: TextStyle(color: Colors.white),),
                            )
                          ],)
                        ],),
                          SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Column(children: [
                            verificationProvider.isUploadingPersonalInfo2?CircularProgressIndicator():verificationProvider.isDoneUploadingPersonalInfo2?Icon(Icons.check_circle, color: Colors.green, size: 30,):Icon(Icons.check_circle, color: Colors.grey, size: 30,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Company Information', style: TextStyle(color: Colors.white),),
                            )
                          ],)
                        ],),
                      ],);
                    }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 45,
                            color: step==1?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                            child: Center(child: Text("Step 1", style: TextStyle(fontWeight: FontWeight.w800, color: step==1?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK, fontSize: 12),)),
                          ),
                          CustomPaint(
                            painter: TrianglePainter(
                              strokeColor: step==1?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                              strokeWidth: 10,
                              paintingStyle: PaintingStyle.fill,
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 30,
                            width: 45,
                            color: step==2?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                            child: Center(child: Text("Step 2", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: step==2?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK,),)),
                          ),
                          CustomPaint(
                            painter: TrianglePainter(
                              strokeColor: step==2?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                              strokeWidth: 10,
                              paintingStyle: PaintingStyle.fill,
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 30,
                            width: 45,
                            color: step==3?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                            child: Center(child: Text("Step 3", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: step==3?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK),)),
                          ),
                          CustomPaint(
                            painter: TrianglePainter(
                              strokeColor: step==3?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                              strokeWidth: 10,
                              paintingStyle: PaintingStyle.fill,
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            height: 30,
                            width: 45,
                            color: step==4?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                            child: Center(child: Text("Step 4", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: step==4?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK),)),
                          ),
                          CustomPaint(
                            painter: TrianglePainter(
                              strokeColor: step==4?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
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
                      SizedBox(height: 20,),
                      if(step==1)Step01(),
                      if(step==2)Step02(),
                      if(step==3)Step03(),
                      if(step==4)Step04(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: normalButton(
                          button_text: step!=4?'Next':'Upload',
                          fontSize: 20,
                          primaryColor: ColorResources.COLOR_WHITE,
                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                          onTap: ()async{
                            if(step!=4){
                              if(step==1){
                                VerificationModel verificationModel = formVerificationProvider.step1Verified(context);
                                if(verificationModel.verified){
                                  formVerificationProvider.getAllStates();
                                  setState(() {
                                    step+=1;
                                  });
                                }
                                //dialog(context: context, text: 'Verification Pending for Dr. Prince David!', success: false);
                              }
                              if(step==2){
                                VerificationModel verificationModel = formVerificationProvider.step2Verified(context);
                                if(verificationModel.verified){
                                  setState(() {
                                    step+=1;
                                  });
                                }
                              }
                              if(step==3){
                                VerificationModel verificationModel = formVerificationProvider.step3Verified(context);
                                if(verificationModel.verified){
                                  setState(() {
                                    step+=1;
                                  });
                                }
                              }
                            }else{
                              print('finished');
                              VerificationModel verificationModel = formVerificationProvider.step4Verified(context);
                              if(verificationModel.verified){
                                String token = Provider.of<AuthProvider>(context, listen: false).token;
                                verificationProvider.setToken(token);
                                print('token: ${token}');
                                print(formVerificationProvider.getStep1(Provider.of<AuthProvider>(context, listen: false).doctorTypeList[0].title));
                                print(formVerificationProvider.getStep2());
                                print(formVerificationProvider.getStep3());
                                print(formVerificationProvider.getStep4());

                                await verificationProvider.startUpload(
                                    step1: formVerificationProvider.getStep1(Provider.of<AuthProvider>(context, listen: false).doctorTypeList[0].title),
                                    step2: formVerificationProvider.getStep2(),
                                    step3: formVerificationProvider.getStep3(),
                                    step4: formVerificationProvider.getStep4(),

                                    passport: formVerificationProvider.passport,
                                    idCard: formVerificationProvider.idCard,
                                    degreeCertificate: formVerificationProvider.degreeCertificate,
                                    nigerianMedicalCertificate: formVerificationProvider.nigeriaMedicalLicense,
                                    specialistDoc: formVerificationProvider.specialistDocuments,
                                ).then((response){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NotApprovedScreen()),
                                  );
                                });

                              }
                            }
                          },
                        ),
                      )
                    ],),
                  );
                }
              );
            }
          ),),
      ],
    );
  }
}