import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_package/provider/form_provider.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_utill/images.dart';
import 'package:doctor_v2/nurse_views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/nurse_views/otp/otp_screen.dart';
import 'package:doctor_v2/nurse_views/profile_setup/profile_setup.dart';
import 'package:doctor_v2/nurse_views/register/register.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/nurse_views/verification/verification_view.dart';
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
                  Text('Forgot Password?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: 20,),
                  if(authProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                  if(!authProvider.isLoading)Padding(
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
                                authProvider.login(_emailController.text, _passwordController.text).then((ResponseModelNurse responseModel){
                                  if(responseModel.isSuccess){
                                    showCustomSnackBar(responseModel.message, context, isError: false);
                                    print('===================');
                                    print(authProvider.userInfoModel!.gender.isEmpty);
                                    if(authProvider.userInfoModel!.gender.isEmpty){
                                      Provider.of<FormProviderNurse>(context, listen: false).getStates(selectedState: -1, selectedLGA: -1);
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
                                    /*
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                                    );
                                    */
                                    //-------------
                                    /*
                                    if(authProvider.userInfoModel!.emailVerificationStatus == '1'){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                                      );
                                    }else{

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OTPScreen(email: '', password: '',)),
                                      );

                                    }*/

                                  }else{
                                    showCustomSnackBar(responseModel.message, context, isError: true);
                                  }
                                });
                              }else{
                                showCustomSnackBar('Invalid email address', context, isError: true);
                              }
                              /*
                              print('090090909');
                              authProvider.login(_emailController.text, _passwordController.text).then((ResponseModel responseModel){
                                if(responseModel.isSuccess){
                                  showCustomSnackBar(responseModel.message, context, isError: false);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                                  );
                                }else{
                                  showCustomSnackBar(responseModel.message, context, isError: true);
                                }
                              });
                              */
                              /*
                              if (_key.currentState!.validate()) {
                                _controller.login(_emailController.text, _passwordController.text);
                              } else {
                                setState(() {
                                  _autoValidate = true;
                                });
                              }
                              */
                            }
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      authProvider.getServicePreferences();
                      authProvider.getNurseService();
                      authProvider.getNurseType();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterNurseScreen()),
                      );
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
        ),
      ),
    ],
  );
  }

  _onLoginButtonPressed(){}
  }
