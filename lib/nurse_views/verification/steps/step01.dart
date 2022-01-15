import 'package:doctor_v2/nurse_data/model/util_models.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/views/ui_kits/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../form_verification_provider.dart';
class Step01 extends StatefulWidget {
  Step01({Key? key}) : super(key: key);

  @override
  _Step01State createState() {
    return _Step01State();
  }
}

class _Step01State extends State<Step01> {
  List<String> selected = [];
  List<String> selectedNursingSpecialty = [];
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
    return Consumer<FormVerificationNurseProvider>(
        builder: (context, formVerificationProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 20.0),
              child: Text('Personal Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.person, color: Colors.white,),
                    ),
                    SizedBox(width: 1,child: Container(color: Colors.white,), height: 64,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                            DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                              underline: Container(color: Colors.transparent),
                              items: ['Male', 'Female'].map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem, style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (value){
                                formVerificationProvider.setGender(value!);
                              },
                              value: formVerificationProvider.genderController.text==''?'Male':formVerificationProvider.genderController.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
              ],
            ),
            SizedBox(height: 15,),
            Consumer<NurseAuthProvider>(
                builder: (context, authProvider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.person, color: Colors.transparent,),
                          ),
                          SizedBox(width: 1,child: Container(color: Colors.white,), height: 64,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                              child: Stack(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nursing Category', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                  if(!authProvider.isLoading)Padding(
                                    padding: const EdgeInsets.only(top:10.0),
                                    child: DropdownButton<NurseType>(
                                      isExpanded: true,
                                      dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                      underline: Container(color: Colors.transparent),
                                      items: authProvider.nurseTypeList.map((NurseType nurseType) {
                                        return DropdownMenuItem<NurseType>(
                                          value: nurseType,
                                          child: Text(nurseType.title.trim(), style: TextStyle(color: Colors.white),),
                                        );
                                      }).toList(),
                                      onChanged: (value){
                                        formVerificationProvider.selectSpecialty(value!);
                                      },
                                      //value: formVerificationProvider.selectedNurseType.id,
                                      value: formVerificationProvider.selectedNurseType.id==''?authProvider.nurseTypeList[0]:formVerificationProvider.selectedNurseType,
                                    ),
                                  ),
                                  if(authProvider.loadingNurseType)Padding(
                                    padding: const EdgeInsets.only(top:30.0),
                                    child: Row(children: [Text('Loading Nursing Category', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
                    ],
                  ),
                );
              }
            ),
            //textField(label: 'Speciality', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Speciality', controller: formVerificationProvider.specialityController, validator: (){}, onChanged: (){}),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.person, color: Colors.transparent,),
                      ),
                      SizedBox(width: 1,child: Container(color: Colors.white,), height: 61,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                          child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Language Spoken', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.only(top:0.0),
                                child: LanguageDropDownMultiSelect(
                                  onChanged: (List<String> x) {
                                    setState(() {
                                      selected =x;
                                      formVerificationProvider.languageSpokenController.text=selected.join(',');
                                      print(selected.join(', '));
                                    });
                                  },
                                  decoration: InputDecoration(
                                    //border: OutlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 10,
                                    ),
                                  ),
                                  options: ['English' , 'Hausa' , 'Igbo' , 'Yoruba'],
                                  selectedValues: selected,
                                  whenEmpty: 'Select Something',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
                ],
              ),
            ),
            //textField(label: 'Language Spoken', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Language Spoken', controller: formVerificationProvider.languageSpokenController, validator: (){}, onChanged: (){}),
            SizedBox(height: 15,),
            textField(label: 'NWCN or CHRPRBN  license number', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter license number', controller: formVerificationProvider.mcdnNumberController, validator: (){}, onChanged: (){}),
            SizedBox(height: 15,),
            //textField(label: 'Specialty code', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Specialty code', controller: formVerificationProvider.specialityCodeController, validator: (){}, onChanged: (){}),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.person, color: Colors.transparent,),
                      ),
                      SizedBox(width: 1,child: Container(color: Colors.white,), height: 61,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                          child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nursing Specialty', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.only(top:0.0),
                                child: LanguageDropDownMultiSelect(
                                  onChanged: (List<String> x) {
                                    setState(() {
                                      selected =x;
                                      formVerificationProvider.specialityCodeController.text=selectedNursingSpecialty.join(',');
                                    });
                                  },
                                  decoration: InputDecoration(
                                    //border: OutlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 10,
                                    ),
                                  ),
                                  options: [
                                    'Licensed Practical Nurse',
                                    'Registered Nurse (RN)',
                                    'Clinical Nurse Specialist (CNS)',
                                    'Critical Care Nurse',
                                    'Emergency Nurse',
                                    'Family Nurse Practitioner',
                                    'Geriatric Nurse',
                                    'Mental Health Nurse',
                                    'Perioperative Nurse',
                                    'Nurse Midwife',
                                    'Oncology Nurse',
                                    'Orthopedic Nurse',
                                    'Pediatric nurse',
                                    'Public Health Nurse'
                                  ],
                                  selectedValues: selectedNursingSpecialty,
                                  whenEmpty: 'Select Something',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
                ],
              ),
            ),
            SizedBox(height: 15,),
            //textField(label: 'other Language', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter other Language', controller: formVerificationProvider.otherLanguageController, validator: (){}, onChanged: (){}),
            //SizedBox(height: 15,),
            GestureDetector(
                onTap: ()=>formVerificationProvider.takePassport(),
                child: textField(label: 'Passport', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select Passport', controller: formVerificationProvider.passportController, validator: (){}, onChanged: (){},enable: false,)),
          ],),
        );
      }
    );
  }
}
