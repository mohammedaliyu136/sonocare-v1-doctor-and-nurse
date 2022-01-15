import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:provider/provider.dart';

class BusinessInformation extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _referrerController = TextEditingController();
  final _indentityController = TextEditingController();
  bool _autoValidate = false;
  BusinessInformation({required this.nextButton});
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
            _countryController.text = authProvider.verificationModelDoctor.country;
            _referrerController.text = authProvider.verificationModelDoctor.referedBy;
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 30.0),
                child: Text('Business Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
              ),
              //dropDownInput(icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Specialty', list: gender, dropDownValue: '', label: 'Specialty',),
              textField(label: 'Country', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Select Country', controller: _countryController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Select State', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Select State', controller: _stateController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Referred by?', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Referer', controller: _referrerController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'Upload Identity Card', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Upload...', controller: _indentityController, validator: (){}, onChanged: (){}),
              SizedBox(height: 20,),
              normalButton(
                button_text: 'Next',
                fontSize: 20,
                primaryColor: ColorResources.COLOR_WHITE,
                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                onTap: ()async{
                  await authProvider.verificationModelDoctor.setBusinessInformation(country: _countryController.text,
                      state: _stateController.text, referredBy: _referrerController.text, identityCard: _indentityController.text);
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
