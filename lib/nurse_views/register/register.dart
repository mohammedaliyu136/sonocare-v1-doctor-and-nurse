import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/signupModel.dart';
import 'package:doctor_v2/nurse_data/model/util_models.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_utill/images.dart';
import 'package:doctor_v2/nurse_views/otp/otp_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterNurseScreen extends StatefulWidget {
  RegisterNurseScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterNurseScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _specializationController = TextEditingController();
  final _nurseServicesController = TextEditingController();
  final _servicePreferenceController = TextEditingController();
  final _nurseTypeController = TextEditingController();

  NurseService selectedNurseService = NurseService(id: '', title: '');
  NurseType selectedNurseType = NurseType(id: '', title: '');
  ServicePref selectedServicePref = ServicePref(id: '', type: '');

  String nurseTypeID = '0';
  String servicePrefID = '0';
  bool term_and_condition = false;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        BackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer<NurseAuthProvider>(
              builder: (context, authProvider, child) {
              return ListView(
                children: [
                  SizedBox(height: 0,),
                  Image.asset(Images.main_logo_sm, height: 200, fit: BoxFit.contain,),
                  SizedBox(height: 0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(hintText: 'Enter your First Name', label:'First Name', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _firstNameController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(hintText: 'Enter your Last Name', label:'Last Name', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _lastNameController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(hintText: 'Enter your Other Name', label:'Other Name', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _otherNameController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(hintText: 'Enter your Email', label:'Email', icon: Icon(Icons.mail, color: Colors.white,), controller: _emailController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(hintText: 'Enter your Phone Number', label:'Phone Number', icon: Icon(Icons.call, color: Colors.white,), controller: _phoneNumberController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(hintText: 'Enter your Address', label:'Address', icon: Icon(Icons.location_on, color: Colors.white,), controller: _addressController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(obscureText: true, hintText: 'Enter your Password', label:'Password', icon: Icon(Icons.lock, color: Colors.white), controller: _passwordController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: textField(obscureText: true, hintText: 'Enter your Password again', label:'Confirm Password', icon: Icon(Icons.lock, color: Colors.white), controller: _passwordConfirmationController, validator: (){}, onChanged: (){}),
                  ),
                  SizedBox(height: 10,),
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
                            //Text(authProvider.nurseServicesList.length.toString()),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                                child: Stack(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nurse Service', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                    if(!authProvider.loadingNurseServices)Padding(
                                      padding: const EdgeInsets.only(top:10.0),
                                      child: DropdownButton<NurseService>(
                                        isExpanded: true,
                                        dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                        underline: Container(color: Colors.transparent),
                                        items: authProvider.nurseServicesList.map((NurseService nurseService) {
                                          return DropdownMenuItem<NurseService>(
                                            value: nurseService,
                                            child: Text(nurseService.title.trim(), style: TextStyle(color: Colors.white),),
                                          );
                                        }).toList(),
                                        onChanged: (value){
                                          //authProvider.selectState(value!);
                                          setState(() {
                                            _nurseServicesController.text=value!.id;
                                            selectedNurseService=value!;
                                          });
                                        },
                                        value: selectedNurseService.id==''?authProvider.nurseServicesList[0]:selectedNurseService,
                                      ),
                                    ),
                                    if(authProvider.loadingNurseServices)Padding(
                                      padding: const EdgeInsets.only(top:30.0),
                                      child: Row(children: [Text('Loading Nurse Services', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
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
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Service Preferences', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                    if(!authProvider.isLoading)Padding(
                                      padding: const EdgeInsets.only(top:10.0),
                                      child: DropdownButton<ServicePref>(
                                        isExpanded: true,
                                        dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                        underline: Container(color: Colors.transparent),
                                        items: authProvider.servicePreferencesList.map((ServicePref servicePreferences) {
                                          return DropdownMenuItem<ServicePref>(
                                            value: servicePreferences,
                                            child: Text(servicePreferences.type.trim(), style: TextStyle(color: Colors.white),),
                                          );
                                        }).toList(),
                                        onChanged: (value){
                                          //authProvider.selectState(value!);
                                          setState(() {
                                            selectedServicePref=value!;
                                          });
                                        },
                                        //value: selectedServicePref,
                                        value: selectedServicePref.id==''?authProvider.servicePreferencesList[0]:selectedServicePref,

                                      ),
                                    ),
                                    if(authProvider.loadingServicePreferences)Padding(
                                      padding: const EdgeInsets.only(top:30.0),
                                      child: Row(children: [Text('Loading Nurse Services', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
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
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nurse Type', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
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
                                          //authProvider.selectState(value!);
                                          setState(() {
                                            selectedNurseType=value!;
                                          });
                                        },
                                        //value: selectedNurseType,
                                        value: selectedNurseType.id==''?authProvider.nurseTypeList[0]:selectedNurseType,

                                      ),
                                    ),
                                    if(authProvider.loadingNurseType)Padding(
                                      padding: const EdgeInsets.only(top:30.0),
                                      child: Row(children: [Text('Loading Nurse Type', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
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
                  Row(
                    children: [
                      Checkbox(value: term_and_condition, onChanged: (bool? value) {setState(() {term_and_condition=value!;});}, fillColor: MaterialStateProperty.all(ColorResources.COLOR_PURPLE_MID),),
                      //SizedBox(width: 10,),
                      GestureDetector(
                          onTap: (){setState(() {term_and_condition=!term_and_condition;});},
                          child: Text('I accept the Terms and Conditions', textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 14),)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  if(authProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                  if(!authProvider.isLoading)Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(child: normalButton(
                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                          button_text: 'Sign Up',
                          primaryColor: ColorResources.COLOR_WHITE,
                          fontSize: 16,
                          onTap: (){
                            if(term_and_condition){
                              if(_firstNameController.text.isEmpty){showCustomSnackBar('Please enter your first Name', context, isError: true); return true;}
                              if(_lastNameController.text.isEmpty){showCustomSnackBar('Please enter your last Name', context, isError: true); return true;}
                              if(_otherNameController.text.isEmpty){showCustomSnackBar('Please enter your other Name', context, isError: true); return true;}
                              if(_emailController.text.isEmpty){showCustomSnackBar('Please enter your email', context, isError: true); return true;}
                              if(_phoneNumberController.text.isEmpty){showCustomSnackBar('Please enter your Phone Number', context, isError: true); return true;}
                              if(_addressController.text.isEmpty){showCustomSnackBar('Please enter your Address', context, isError: true); return true;}
                              if(_passwordController.text.isEmpty){showCustomSnackBar('Please enter your password', context, isError: true); return true;}
                              if(_passwordConfirmationController.text.isEmpty){showCustomSnackBar('Please confirm your password', context, isError: true); return true;}
                              if(_passwordConfirmationController.text != _passwordController.text){showCustomSnackBar('Password did not match', context, isError: true); return true;}

                              SignUpModelNurse signUpModel = SignUpModelNurse(
                                  email: _emailController.text, address: _addressController.text,
                                  firstName: _firstNameController.text, phoneNumber: _phoneNumberController.text,
                                  password: _passwordController.text, otherName: _otherNameController.text, lastName: _lastNameController.text,
                                  nurseType: selectedNurseType.title.isEmpty?authProvider.nurseTypeList[0].title:selectedNurseType.title,
                                  nurseService: selectedNurseService.id.isEmpty?authProvider.nurseServicesList[0].id:selectedNurseService.id,
                                  hospitalID: '1',
                                  servicePref: selectedServicePref.id.isEmpty?authProvider.servicePreferencesList[0].id:selectedServicePref.id//_specializationController.text
                              );


                              authProvider.registration(signUpModel).then((ResponseModelNurse responseModel){
                                if(responseModel.isSuccess){
                                  showCustomSnackBar(responseModel.message, context, isError: false);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => OTPNurseScreen(email: _emailController.text, password: _passwordController.text,)),
                                  );
                                }else{
                                  showCustomSnackBar(responseModel.message, context, isError: true);
                                }
                              });

                            }else{
                              showCustomSnackBar('Please accept the terms and conditions', context, isError: true);
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Already have an account? Sign In', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
                    ),
                  ),
                  SizedBox(height: 20,),

                ],);
            }
          ),
        ),
      ],
    );
  }
}
