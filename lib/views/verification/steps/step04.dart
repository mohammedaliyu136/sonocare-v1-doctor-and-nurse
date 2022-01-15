import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


import '../form_verification_provider.dart';

class Step04 extends StatelessWidget {
  Step04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<FormVerificationProvider>(
        builder: (context, formVerificationProvider, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 20.0),
            child: Text('Professional/Work Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
          ),
          textField(label: 'Hospital / Company / Organisation', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Company \/ Organisation', controller: formVerificationProvider.companyOrganisationController, validator: (){}, onChanged: (){}),
          SizedBox(height: 15,),
          GestureDetector(
              onTap: ()=>DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1960, 1, 1),
                  maxTime: DateTime.now(),
                  theme: DatePickerTheme(
                      headerColor: ColorResources.COLOR_PURPLE_DEEP,
                      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                      itemStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle:
                      TextStyle(color: Colors.white, fontSize: 16)),
                  onChanged: (date) {
                     List<String> datearray = date.toString().split(' ')[0].split('-');
                     String dateStr = datearray[2]+'/'+datearray[1]+'/'+datearray[0];
                    print(dateStr);
                    formVerificationProvider.setFromDate(dateStr);
                  }, onConfirm: (date) {
                    List<String> datearray = date.toString().split(' ')[0].split('-');
                    String dateStr = datearray[2]+'/'+datearray[1]+'/'+datearray[0];
                    print(dateStr);
                    formVerificationProvider.setFromDate(dateStr);
                  }, currentTime: DateTime.now(), locale: LocaleType.en),
              child: textField(label: 'From', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter date you started', controller: formVerificationProvider.fromController, validator: (){}, onChanged: (){}, enable: false,)),
          SizedBox(height: 15,),
          GestureDetector(
              onTap: ()=>DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1960, 1, 1),
                  maxTime: DateTime.now(),
                  theme: DatePickerTheme(
                      headerColor: ColorResources.COLOR_PURPLE_DEEP,
                      backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                      itemStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle:
                      TextStyle(color: Colors.white, fontSize: 16)),
                  onChanged: (date) {
                    List<String> datearray = date.toString().split(' ')[0].split('-');
                    String dateStr = datearray[2]+'/'+datearray[1]+'/'+datearray[0];
                    print(dateStr);
                    formVerificationProvider.setToDate(dateStr);
                  }, onConfirm: (date) {
                    List<String> datearray = date.toString().split(' ')[0].split('-');
                    String dateStr = datearray[2]+'/'+datearray[1]+'/'+datearray[0];
                    print(dateStr);
                    formVerificationProvider.setToDate(dateStr);
                  }, currentTime: DateTime.now(), locale: LocaleType.en),
              child: textField(label: 'To', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Leave as is you still work here', controller: formVerificationProvider.toController, validator: (){}, onChanged: (){}, enable: false,)),
          SizedBox(height: 15,),
          Row(children: [
          Theme(
          data: ThemeData(unselectedWidgetColor: ColorResources.COLOR_WHITE,),
          child: Checkbox(
              activeColor: ColorResources.COLOR_PURPLE_MID,
              value: formVerificationProvider.iCurrentlyWorkHere, onChanged: (val)=>formVerificationProvider.setICurrentlyWorkHere(val)),),
            //Checkbox(value: formVerificationProvider.iCurrentlyWorkHere, onChanged: (val)=>formVerificationProvider.setICurrentlyWorkHere(val)),
            GestureDetector(child: Text('I Currently Work Here', style: TextStyle(color: Colors.white, fontSize: 16),), onTap: ()=>formVerificationProvider.setICurrentlyWorkHere(!formVerificationProvider.iCurrentlyWorkHere),)
          ],),
        ],);
      }
    );
  }
}
