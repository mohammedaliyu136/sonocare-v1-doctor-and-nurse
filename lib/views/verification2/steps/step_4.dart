import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:provider/provider.dart';

class CompanyInformation extends StatefulWidget {
  CompanyInformation({Key? key}) : super(key: key);

  @override
  _CompanyInformationState createState() {
    return _CompanyInformationState();
  }
}

class _CompanyInformationState extends State<CompanyInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  bool _autoValidate = false;

  List<String> gender = [
    'Male',
    'Female',
  ];
  dialog({context,bool success = false, text}){
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(success?'Verification\nSuccessful!':text, style: TextStyle(height:1.3,fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            ),
            SizedBox(height: 20,),
            normalButton(
              button_text: success?'Done':'Update Profile',
              fontSize: 20,
              primaryColor: ColorResources.COLOR_WHITE,
              backgroundColor: ColorResources.COLOR_PURPLE_MID,
              onTap: (){
                if(!success){
                  Navigator.pop(context);
                  dialog(context: context, text: 'Verification Pending for Dr. Prince David!', success: true);
                }else{
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                }
              },
            ),
            !success?Row(
              children: [
                Expanded(child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Not Now', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: ColorResources.COLOR_PURPLE_MID),))),
              ],
            ):Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            _companyController.text = authProvider.verificationModelDoctor.companyOrganisation;
            _fromController.text = authProvider.verificationModelDoctor.workingFrom;
            _toController.text = authProvider.verificationModelDoctor.workingTo;
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 30.0),
                child: Text('Personal Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
              ),
              //dropDownInput(icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Specialty', list: gender, dropDownValue: '', label: 'Specialty',),
              textField(label: 'Company/Organisation', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Degree certificate', controller: _companyController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'From', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select State', controller: _fromController, validator: (){}, onChanged: (){}),
              SizedBox(height: 10,),
              textField(label: 'To', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Enter Referer', controller: _toController, validator: (){}, onChanged: (){}),
              SizedBox(height: 20,),
              normalButton(
                button_text: 'Finish',
                fontSize: 20,
                primaryColor: ColorResources.COLOR_WHITE,
                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                onTap: ()async{
                  //country,                                dynamic state,                                dynamic referredBy,
                  await authProvider.verificationModelDoctor.setPersonal2Information(company: _companyController.text, from: _fromController.text, to: _toController.text);
                  authProvider.verifyDoctor();
                  dialog(context: context, text: 'Verification Pending for Dr. Prince David!', success: false);
                },
              )
            ],),
          );
        }
      ),
    );
  }
}
