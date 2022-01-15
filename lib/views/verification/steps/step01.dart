import 'package:doctor_v2/data/model/util_models.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/ui_kits/language_dropdown.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
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
  DoctorType selectedDoctorTypeLocal = DoctorType(id: '', title: '');
  List<String> selected = [];
  List<String> selectedSpecialtyCode = [];

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
    return Consumer<FormVerificationProvider>(
        builder: (context, formVerificationProvider, child) {
        return Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
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
                //textField(label: 'Speciality', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Speciality', controller: formVerificationProvider.specialityController, validator: (){}, onChanged: (){}),
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
                          SizedBox(width: 1,child: Container(color: Colors.white,), height: 64,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                              child: Stack(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Specialty', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                  if(!authProvider.loadingDoctorType)Padding(
                                    padding: const EdgeInsets.only(top:10.0),
                                    child: DropdownButton<DoctorType>(
                                      isExpanded: true,
                                      dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                      underline: Container(color: Colors.transparent),
                                      items: authProvider.doctorTypeList.map((DoctorType nurseType) {
                                        return DropdownMenuItem<DoctorType>(
                                          value: nurseType,
                                          child: Text(nurseType.title.trim(), style: TextStyle(color: Colors.white),),
                                        );
                                      }).toList(),
                                      onChanged: (value){
                                        formVerificationProvider.selectSpecialty(value!);
                                        setState(() {
                                          selectedDoctorTypeLocal = value;
                                        });
                                      },
                                      //value: formVerificationProvider.selectedNurseType.id,
                                      //value: formVerificationProvider.selectedDoctorType.id==''?authProvider.doctorTypeList[0]:formVerificationProvider.selectedDoctorType,
                                      value: selectedDoctorTypeLocal.id==''?authProvider.doctorTypeList[0]:selectedDoctorTypeLocal,
                                      //value: authProvider.doctorTypeList[0],
                                    ),
                                  ),
                                  if(authProvider.loadingDoctorType)Padding(
                                    padding: const EdgeInsets.only(top:30.0),
                                    child: Row(children: [Text('Loading Doctor Type', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
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
                textField(label: 'MCDN Number', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter MCDN Number', controller: formVerificationProvider.mcdnNumberController, validator: (){}, onChanged: (){}),
                //SizedBox(height: 15,),
                //textField(label: 'other Language', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter other Language', controller: formVerificationProvider.otherLanguageController, validator: (){}, onChanged: (){}),
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
                                  Text('Specialty code', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: LanguageDropDownMultiSelect(
                                      onChanged: (List<String> x) {
                                        setState(() {
                                          selectedSpecialtyCode =x;
                                          formVerificationProvider.specialityCodeController.text=selectedSpecialtyCode.join(',');
                                          print(selectedSpecialtyCode.join(', '));
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
                                      //options: ['English' , 'Hausa' , 'Igbo' , 'Yoruba'],
                                      options: [
                                        'MBBS',
                                        'MBChB',
                                        'FWACS',
                                        'FWACP',
                                        'FRSC',
                                        'FRCP (UK)',
                                        'FRCOG',
                                        'FRACS',
                                        'FRACP',
                                        'FRACGP',
                                        'MRCP',
                                        'MGO',
                                        'MPH',
                                        'DRACOG',
                                        'DRCOG'
                                      ],
                                      selectedValues: selectedSpecialtyCode,
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
                SizedBox(height: 15,),
                textField(label: 'Specialty code', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Specialty code', controller: formVerificationProvider.specialityCodeController, validator: (){}, onChanged: (){}),
                GestureDetector(
                    onTap: ()=>formVerificationProvider.takePassport(),
                    child: textField(label: 'Passport', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select Passport', controller: formVerificationProvider.passportController, validator: (){}, onChanged: (){},enable: false,)),
              ],),
            );
          }
        );
      }
    );
  }
}
