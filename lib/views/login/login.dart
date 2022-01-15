import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_package/provider/form_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/nurse_views/profile_setup/profile_setup.dart';
import 'package:doctor_v2/package/provider/form_provider.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/utill/images.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/forget_password/forget_password.dart';
import 'package:doctor_v2/views/otp/otp_screen.dart';
import 'package:doctor_v2/views/profile_setup/profile_setup.dart';
import 'package:doctor_v2/views/register/register.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/views/verification/verification_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  String email = "";
  String password = "";
  LoginScreen({this.email="", this.password=""});
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<LoginScreen> {
  //final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  List<String> accountTypeList = ['Doctor', 'Nurse'];
  String selectedAccount = 'Doctor';


  @override
  Widget build(BuildContext context) {
  // TODO: implement build
    if(widget.email.isNotEmpty){
      _emailController.text=widget.email;
      _passwordController.text=widget.password;
    }
    //_emailController.text='allphonesblog@gmail.com';
    //_emailController.text='mohammedddaliyu136@gmail.com';
    //_emailController.text='alamin123456@gmail.com';
    //_emailController.text='allphonesblog@gmail.com';
    //_passwordController.text='123456';
  return Stack(
    children: [
      /*
            Obx(() {
              return
            }),
            */
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<NurseAuthProvider>(
            builder: (context, nurseAuthProvider, child) {
            return Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                return Form(
                  key: _key,
                  autovalidateMode:
                  _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      SizedBox(height: 0,),
                      Image.asset(Images.main_logo_sm, height: 200, fit: BoxFit.contain,),
                      SizedBox(height: 0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: textField(hintText: 'Enter your Email', label:'Email', icon: Icon(Icons.mail, color: Colors.white,), controller: _emailController, validator: (){}, onChanged: (){},),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: textField(obscureText: true, hintText: 'Enter your Password', label:'Password', icon: Icon(Icons.lock, color: Colors.white), controller: _passwordController, validator: (){}, onChanged: (){}),
                      ),
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
                                              });;
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
                      SizedBox(height: 10,),
                      GestureDetector(
                          onTap: (){
                            print('forget password');
                            //ForgetPasswordScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('Forgot Password?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
                          )),
                      SizedBox(height: 10,),
                      if(selectedAccount=='Doctor')if(authProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                      if(selectedAccount=='Doctor')if(!authProvider.isLoading)Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(child: normalButton(
                                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                                button_text: 'Log in',
                                primaryColor: ColorResources.COLOR_WHITE,
                                fontSize: 16,
                                onTap: () async {
                                  if(_emailController.text.split('@').length==2){
                                    print('090090909');
                                    if(selectedAccount=='Doctor'){
                                      authProvider.login(_emailController.text, _passwordController.text).then((ResponseModel responseModel){
                                        if(responseModel.isSuccess){
                                          //showCustomSnackBar(responseModel.message, context, isError: false);
                                          print('===================');
                                          print(authProvider.userInfoModel!.gender.isEmpty);
                                          if(authProvider.userInfoModel!.gender.isEmpty){
                                            Provider.of<FormProvider>(context, listen: false).getStates(selectedState: -1, selectedLGA: -1);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileSetUPScreen()),
                                            );
                                          }else{
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DashboardScreen()),
                                            );
                                          }
                                        }else{
                                          showCustomSnackBar(responseModel.message, context, isError: true);
                                        }
                                      });
                                    }else{
                                      print('000000');
                                      nurseAuthProvider.login(_emailController.text, _passwordController.text).then((ResponseModelNurse responseModel){
                                        if(responseModel.isSuccess){
                                          //showCustomSnackBar(responseModel.message, context, isError: false);
                                          print('===================');
                                          print(nurseAuthProvider.userInfoModel!.stateID.isEmpty);
                                          if(nurseAuthProvider.userInfoModel!.stateID.isEmpty){
                                            int stateId = -1;
                                            int lgaId = -1;
                                            Provider.of<FormProviderNurse>(context, listen: false).getStates(selectedState: stateId, selectedLGA: lgaId);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileSetUPNurseScreen()),
                                            );
                                          }else{
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DashboardNurseScreen()),
                                            );
                                          }

                                        }else{
                                          showCustomSnackBar(responseModel.message, context, isError: true);
                                        }
                                      });
                                    }
                                  }else{
                                    showCustomSnackBar('Invalid email address', context, isError: true);
                                  }
                                }
                            )),
                          ],
                        ),
                      ),

                      if(selectedAccount!='Doctor')if(nurseAuthProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                      if(selectedAccount!='Doctor')if(!nurseAuthProvider.isLoading)Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(child: normalButton(
                                backgroundColor: ColorResources.COLOR_PURPLE_MID,
                                button_text: 'Log in',
                                primaryColor: ColorResources.COLOR_WHITE,
                                fontSize: 16,
                                onTap: () async {
                                  if(_emailController.text.split('@').length==2){
                                    print('090090909');
                                    if(selectedAccount=='Doctor'){
                                      authProvider.login(_emailController.text, _passwordController.text).then((ResponseModel responseModel){
                                        if(responseModel.isSuccess){
                                          //showCustomSnackBar(responseModel.message, context, isError: false);
                                          print('===================');
                                          print(authProvider.userInfoModel!.gender.isEmpty);
                                          if(authProvider.userInfoModel!.gender.isEmpty){
                                            Provider.of<FormProvider>(context, listen: false).getStates(selectedState: -1, selectedLGA: -1);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileSetUPScreen()),
                                            );
                                          }else{
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DashboardScreen()),
                                            );
                                          }
                                        }else{
                                          showCustomSnackBar(responseModel.message, context, isError: true);
                                        }
                                      });
                                    }else{
                                      print('000000');
                                      nurseAuthProvider.login(_emailController.text, _passwordController.text).then((ResponseModelNurse responseModel){
                                        if(responseModel.isSuccess){
                                          //showCustomSnackBar(responseModel.message, context, isError: false);

                                          print('===================');
                                          print(nurseAuthProvider.userInfoModel!.stateID.isEmpty);
                                          if(nurseAuthProvider.userInfoModel!.stateID.isEmpty){
                                            int stateId = -1;
                                            int lgaId = -1;
                                            Provider.of<FormProviderNurse>(context, listen: false).getStates(selectedState: stateId, selectedLGA: lgaId);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProfileSetUPNurseScreen()),
                                            );
                                          }else{
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => DashboardNurseScreen()),
                                            );
                                          }
                                        }else{
                                          showCustomSnackBar(responseModel.message, context, isError: true);
                                        }
                                      });
                                    }
                                  }else{
                                    showCustomSnackBar('Invalid email address', context, isError: true);
                                  }
                                }
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Provider.of<AuthProvider>(context, listen: false).getServicePreferences();
                          Provider.of<AuthProvider>(context, listen: false).getDoctorType();
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text('Don\'t have an account? Sign Up', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
                        ),
                      ),
                      SizedBox(height: 40,),

                    ],),
                );
              }
            );
          }
        ),
      ),
    ],
  );
  }

  _onLoginButtonPressed(){}
  }
