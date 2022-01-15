import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/accept_appointment/accept_appointment_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
//my_patient_screen
class WithdrawScreen extends StatelessWidget {
  WithdrawScreen();
  TextEditingController _amountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Withdraw'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: ListView(children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: textField(obscureText: false, hintText: 'Enter your Amount', label:'Amount', icon: Icon(Icons.mail_outline, color: Colors.white), controller: _amountController, validator: (){}, onChanged: (){}),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                  children: [
                    Expanded(child: normalButton(
                        backgroundColor: ColorResources.COLOR_PURPLE_MID,
                        button_text: 'Withdraw',
                        primaryColor: ColorResources.COLOR_WHITE,
                        fontSize: 16,
                        onTap: (){}))]),
            )
          ]))
        ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PURPLE_DEEP,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(Icons.home, color: Colors.white,),
              ),
              SizedBox(width: 10,),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PURPLE_DEEP,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(Icons.chat, color: Colors.white,),
              ),
              SizedBox(width: 10,),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PURPLE_DEEP,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(Icons.settings, color: Colors.white,),
              ),
            ],),
        ),
      )
    ],);
  }
}
