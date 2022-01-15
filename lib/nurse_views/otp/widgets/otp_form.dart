import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/nurse_views/verification/verification_view.dart';
//import 'package:doctor_v2/views/verification/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'not_approved.dart';

class OtpFormNurse extends StatefulWidget {
  String email = "";
  String password = "";
  OtpFormNurse({
    Key? key, required this.email, required this.password
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpFormNurse> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  /*
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;
   */

  final _pin1Controller = TextEditingController();
  final _pin2Controller = TextEditingController();
  final _pin3Controller = TextEditingController();
  final _pin4Controller = TextEditingController();
  /*
  final _pin5Controller = TextEditingController();
  final _pin6Controller = TextEditingController();
  */

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    /*
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
     */
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    /*
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();

     */

    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();
    /*
    _pin5Controller.dispose();
    _pin6Controller.dispose();

     */
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NurseAuthProvider>(
        builder: (context, authProvider, child) {
        return Form(
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30,
                    child: TextFormField(
                      controller: _pin1Controller,
                      autofocus: true,
                      obscureText: true,
                      style: TextStyle(fontSize: 34, color: ColorResources.COLOR_WHITE),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      //decoration: otpInputDecoration,
                      decoration: InputDecoration(
                        fillColor: ColorResources.COLOR_WHITE,
                        hoverColor: ColorResources.COLOR_WHITE,
                        hintText: "",
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white),
                        ),
                      ),
                      onChanged: (value) {
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: TextFormField(
                      controller: _pin2Controller,
                      focusNode: pin2FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 34, color: ColorResources.COLOR_WHITE),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      //decoration: otpInputDecoration,
                      decoration: InputDecoration(
                        hintText: "",
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white),
                        ),
                      ),
                      onChanged: (value) => nextField(value, pin3FocusNode),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: TextFormField(
                      controller: _pin3Controller,
                      focusNode: pin3FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 34, color: ColorResources.COLOR_WHITE),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      //decoration: otpInputDecoration,
                      decoration: InputDecoration(
                        hintText: "",
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white),
                        ),
                      ),
                      onChanged: (value) => nextField(value, pin4FocusNode),
                    ),
                  ),

                  SizedBox(
                    width: 30,
                    child: TextFormField(
                      controller: _pin4Controller,
                      focusNode: pin4FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 34, color: ColorResources.COLOR_WHITE),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      //decoration: otpInputDecoration,
                      decoration: InputDecoration(
                        hintText: "",
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white),
                        ),
                      ),
                      onChanged: (value){
                        if (value.length == 1) {
                          pin4FocusNode!.unfocus();
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ),
                  /*
                  SizedBox(
                    width: 30,
                    child: TextFormField(
                      controller: _pin5Controller,
                      focusNode: pin5FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 34, color: ColorResources.COLOR_WHITE),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      //decoration: otpInputDecoration,
                      decoration: InputDecoration(
                        hintText: "",
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white),
                        ),
                      ),
                      onChanged: (value) => nextField(value, pin6FocusNode),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: TextFormField(
                      controller: _pin6Controller,
                      focusNode: pin6FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 34, color: ColorResources.COLOR_WHITE),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      //decoration: otpInputDecoration,
                      decoration: InputDecoration(
                        hintText: "",
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid, color: Colors.white),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          pin6FocusNode!.unfocus();
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ),
                  */
                ],
              ),

              SizedBox(height: 60),
              if(authProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
              if(!authProvider.isLoading)normalButton(
                primaryColor: ColorResources.COLOR_WHITE,
                fontSize: 16,
                button_text: 'Submit',
                backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                onTap: (){
                  print(widget.email);
                  //String email_verification_code = '${_pin1Controller.text}${_pin2Controller.text}${_pin3Controller.text}${_pin4Controller.text}${_pin5Controller.text}${_pin6Controller.text}';
                  String email_verification_code = '${_pin1Controller.text}${_pin2Controller.text}${_pin3Controller.text}${_pin4Controller.text}';
                  print('888888888');
                  authProvider.email_verification(email_verification_code: email_verification_code, email: widget.email).then((ResponseModelNurse responseModel){
                    if(responseModel.isSuccess){
                      showCustomSnackBar(responseModel.message, context, isError: false);
                      print('0000');
                      print(widget.email);
                      print(widget.password);
                      authProvider.loginNotVerified(widget.email, widget.password).then((ResponseModelNurse responseModel){
                        if(responseModel.isSuccess){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VerificationView()),
                          );
                        }
                      });
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotApprovedScreen(email: widget.email, password: widget.password,)),
                      );
                      */
                    }else{
                      showCustomSnackBar(responseModel.message, context, isError: true);
                    }
                  });
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerificationScreen()),
                  );
                  */
                },
              ),
            ],
          ),
        );
      }
    );
  }
}