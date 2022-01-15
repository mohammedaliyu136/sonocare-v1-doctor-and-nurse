import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:provider/provider.dart';

class MedicalInformation extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _degreeController = TextEditingController();
  final _medicalController = TextEditingController();
  final _backingInfoController = TextEditingController();
  bool _autoValidate = false;

  MedicalInformation({required this.nextButton});
  Function() nextButton;
  List<String> gender = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            _degreeController.text = authProvider.verificationModelDoctor.degreeCert;
            _medicalController.text = authProvider.verificationModelDoctor.medicalLicence;
            _backingInfoController.text = authProvider.verificationModelDoctor.backingInformation;
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 30.0),
                child: Text('Medical Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
              ),
              //dropDownInput(icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Specialty', list: gender, dropDownValue: '', label: 'Specialty',),
              textField(label: 'Upload Degree Certificate', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Degree certificate', controller: _degreeController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Upload Nigerian Medical License', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select State', controller: _medicalController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Upload Backing Information', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Enter Referer', controller: _backingInfoController, validator: (){}, onChanged: (){}),
              SizedBox(height: 20,),
              normalButton(
                button_text: 'Next',
                fontSize: 20,
                primaryColor: ColorResources.COLOR_WHITE,
                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                onTap: ()async{
                  await authProvider.verificationModelDoctor.setMedicalInformation(degreeCertificate:_degreeController.text, nigerianMedicalLicense:_medicalController.text, backingInformation:_backingInfoController.text);
                  nextButton();
                },
              )
            ],),
          );
        }
      ),
    );
  }
}
