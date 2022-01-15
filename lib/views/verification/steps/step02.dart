import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/views/verification/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../form_verification_provider.dart';

class Step02 extends StatelessWidget {
  Step02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<FormVerificationProvider>(
        builder: (context, formVerificationProvider, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 20.0),
            child: Text('Business Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
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
                          Text('Country', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                          DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                              items: formVerificationProvider.countries.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem, style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (value){
                                formVerificationProvider.setCountry(value!);
                              },
                              value: formVerificationProvider.countryController.text==''?'Nigeria':formVerificationProvider.countryController.text
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
          Column(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('State', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                          if(!formVerificationProvider.isLoading)DropdownButton<StateModelPAC>(
                            isExpanded: true,
                            dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                            underline: Container(color: Colors.transparent),
                            items: formVerificationProvider.states.map((StateModelPAC dropDownStringItem) {
                              return DropdownMenuItem<StateModelPAC>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem.title, style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (value){
                              formVerificationProvider.selectState(value!);
                            },
                            value: formVerificationProvider.selectedState??formVerificationProvider.states[0],
                          ),
                          if(formVerificationProvider.isLoading)Row(children: [Text('Loading States', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
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
          textField(label: 'Referred By', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter referred By', controller: formVerificationProvider.referredByController, validator: (){}, onChanged: (){}),
          SizedBox(height: 15,),
          GestureDetector(
              onTap: ()=>formVerificationProvider.takeIDCard(),
              child: textField(label: 'ID Card', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select ID Card', controller: formVerificationProvider.idCardController, validator: (){}, onChanged: (){}, enable: false,)),
        ],);
      }
    );
  }
}
