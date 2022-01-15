import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/login/login.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/normalButton.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() {
    return _ForgetPasswordScreenState();
  }
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> accountTypeList = ['doctor', 'nurse'];
  String selectedAccount = 'doctor';

  bool checkedEmail = false;
  bool isLoading = false;

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  validate(){
    if(_emailController.text.isEmpty){
      showCustomSnackBar('Email can not be empty', context, isError: true);
      return false;
    }
    if(_emailController.text.split('@').length!=2){
      showCustomSnackBar('Email is not valid', context, isError: true);
      return false;
    }
    if(checkedEmail){
      if(_otpController.text.isEmpty){
        showCustomSnackBar('OTP can not be empty', context, isError: true);
        return false;
      }
      if(_passwordController.text.isEmpty){
        showCustomSnackBar('Password can not be empty', context, isError: true);
        return false;
      }
      if(_passwordConfirmationController.text.isEmpty){
        showCustomSnackBar('Password Confirmation can not be empty', context, isError: true);
        return false;
      }
      if(_passwordController.text != _passwordConfirmationController.text){
        showCustomSnackBar('Password did not match', context, isError: true);
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Reset Password'),
          elevation: 0,
          leading: GestureDetector(
              onTap: ()=>Navigator.pop(context),
              child: Image.asset('assets/icons/back-arrow_icon.png')),
        ),
        body: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
            return ListView(children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              children: [
                                Text('Account Type', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                    underline: Container(color: Colors.transparent),
                                    items: accountTypeList.map((String accountType) {
                                      return DropdownMenuItem<String>(
                                        value: accountType,
                                        child: Text(accountType, style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                    onChanged: (value){
                                      setState(() {
                                        selectedAccount = value!;
                                        checkedEmail = false;
                                      });
                                    },
                                    value: selectedAccount,
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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textField(hintText: 'Enter your Email', label:'Email', icon: Icon(Icons.mail, color: Colors.white,), controller: _emailController, validator: (){}, onChanged: (){}, enable: !checkedEmail,),
              ),
              SizedBox(height: 20,),
              if(checkedEmail)Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textField(hintText: 'Enter the OTP sent to your phone / email', label:'OTP', icon: Icon(Icons.code, color: Colors.transparent,), controller: _otpController, validator: (){}, onChanged: (){},),
              ),
              if(checkedEmail)SizedBox(height: 20,),
              if(checkedEmail)Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textField(hintText: 'Enter your Password', label:'Password', icon: Icon(Icons.lock, color: Colors.white,), controller: _passwordController, validator: (){}, onChanged: (){},),
              ),
              if(checkedEmail)SizedBox(height: 20,),
              if(checkedEmail)Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textField(hintText: 'Enter your Password Confirmation', label:'Password Confirmation', icon: Icon(Icons.lock, color: Colors.white,), controller: _passwordConfirmationController, validator: (){}, onChanged: (){},),
              ),
              if(checkedEmail)SizedBox(height: 40,),
              if(isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
              if(!isLoading)Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: normalButton(
                    backgroundColor: ColorResources.COLOR_PURPLE_MID,
                    button_text: !checkedEmail?'Check Email':'Reset Password',
                    primaryColor: ColorResources.COLOR_WHITE,
                    fontSize: 16,
                    onTap: () async {
                      /*
                      authProvider.checkEmail(_emailController.text, selectedAccount).then((ResponseModel responseModel){
                        if(responseModel.isSuccess){
                          setState(() {

                          });
                        }
                      });
                      */
                      bool res = validate();
                      if(res){
                        if(!checkedEmail){
                          setState(() {
                            isLoading = true;
                          });
                          authProvider.checkEmail(_emailController.text, selectedAccount).then((ResponseModel responseModel){
                            if(responseModel.isSuccess){
                              //responseModel.message
                              setState(() {
                                checkedEmail = true;
                                isLoading=false;
                              });
                              showCustomSnackBar(responseModel.message, context, isError: false);
                            }
                          });
                        }else{
                          setState(() {
                            isLoading = true;
                          });
                          authProvider.resetPassword(_emailController.text, selectedAccount, _otpController.text, _passwordController.text).then((ResponseModel responseModel){
                            if(responseModel.isSuccess){
                              //responseModel.message
                              setState(() {
                                checkedEmail = true;
                                isLoading=false;
                              });
                              showCustomSnackBar(responseModel.message, context, isError: false);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => LoginScreen(email: _emailController.text, password: _passwordController.text,)),
                                ModalRoute.withName('/'),
                              );
                            }
                          });
                        }
                        //await Future.delayed(const Duration(seconds: 5));

                      }

                    }),
              )
            ],);
          }
        ),
      )
    ],);
  }
}
