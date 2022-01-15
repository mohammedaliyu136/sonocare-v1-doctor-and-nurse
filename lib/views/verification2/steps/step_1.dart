import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _genderController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _languageController = TextEditingController();
  final _mcdnController = TextEditingController();
  final _specialtyCodeController = TextEditingController();
  final _passportController = TextEditingController();
  bool _autoValidate = false;
  PersonalInformation({required this.nextButton});
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
            _genderController.text = authProvider.verificationModelDoctor.gender;
            //_specialtyController.text = authProvider.verificationModelDoctor.specialityCode;
            _languageController.text = authProvider.verificationModelDoctor.language;
            _mcdnController.text = authProvider.verificationModelDoctor.medicalLicence;
            _specialtyCodeController.text = authProvider.verificationModelDoctor.specialityCode;
            _passportController.text = authProvider.verificationModelDoctor.picture;
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 30.0),
                child: Text('Personal Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
              ),
              //dropDownInput(icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Specialty', list: gender, dropDownValue: '', label: 'Specialty',),
              textField(label: 'Gender', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), hintText: 'Select Gender', controller: _genderController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Specialty', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Select Specialty', controller: _specialtyController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Language Spoken', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Select Language Spoken', controller: _languageController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'MCDN Number Reg Cart', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter MCDN Number Reg', controller: _mcdnController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Specialty Code', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Specialty Code', controller: _specialtyCodeController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Upload Passport', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Upload...', controller: _passportController, validator: (){}, onChanged: (){}),
              SizedBox(height: 20,),
              normalButton(
                button_text: 'Next',
                fontSize: 20,
                primaryColor: ColorResources.COLOR_WHITE,
                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                onTap: ()async{
                  await authProvider.verificationModelDoctor.setPersonalInformation(
                      gender:_genderController.text, specialty:_specialtyController.text,language:_languageController.text,
                      otherLanguage:'',MCDNNumberRegCert:_mcdnController.text,specialityCode:_specialtyCodeController.text,passport:_passportController.text
                  );
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
