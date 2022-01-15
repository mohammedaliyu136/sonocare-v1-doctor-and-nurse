import 'package:doctor_v2/data/model/profile_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/package/gender/view.dart';
import 'package:doctor_v2/package/provider/form_provider.dart';
import 'package:doctor_v2/package/state/view.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/provider/profile_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/profile_setup/upload_image.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetUPScreen extends StatefulWidget {
  ProfileSetUPScreen({this.upDateProfile=false});
  bool upDateProfile;

  @override
  _ProfileSetUPScreenState createState() {
    return _ProfileSetUPScreenState();
  }
}

/*
class _ProfileSetUPScreenState extends State<ProfileSetUPScreen> {
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
    return null;
  }
}
*/


class _ProfileSetUPScreenState extends State<ProfileSetUPScreen> {
  _ProfileSetUPScreenState();
  bool _loading = false;
  bool loadedDate = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();

  final _stateController = TextEditingController();
  final _lgaController = TextEditingController();
  final _imageController = TextEditingController();

  String date_of_birth = '';
  String country = '';
  String state = '';

  bool term_and_condition = false;

  int? _value = 42;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _loadData(BuildContext context) async {
    if(!loadedDate){

      _firstNameController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.firstName;
      _lastNameController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.lastName;
      _otherNameController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.otherName;
      _addressController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.address;
      _emailController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.email;
      _phoneNumberController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.phoneNumber;

      _stateController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.stateID;
      _lgaController.text = Provider.of<AuthProvider>(context, listen: false).userInfoModel!.lgaID;
      setState(() {
        loadedDate = true;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    _loadData(context);
    // TODO: implement build
    return Stack(
      children: [
        DarkBackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Profile'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Consumer<FormProvider>(
              builder: (context, formProvider, child) {
              return Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    print('=================');
                    print('https://sonocare.app'+authProvider.userInfoModel!.image);
                    //print(int.parse(authProvider.userInfoModel!.stateID));
                    //print(int.parse(authProvider.userInfoModel!.lgaID));
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('Profile', style: TextStyle(fontSize: 32, color: Colors.white),),
                          ),
                          */
                          Expanded(
                            child: ListView(
                              children: [
                                /*
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex:2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:28.0, bottom: 28),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Colors.green,
                                            image: DecorationImage(
                                              image: NetworkImage('https://sonocare.app'+authProvider.userInfoModel!.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: normalButton(
                                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                                          button_text: 'Update Image',
                                          primaryColor: ColorResources.COLOR_WHITE,
                                          fontSize: 16,
                                          onTap: () async {}),
                                    )
                                  ],
                                ),
                                */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => UploadImageScreen()),
                                        );
                                      },
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(200)),
                                          color: Colors.grey,

                                          image: DecorationImage(
                                            image: NetworkImage('https://sonocare.app'+authProvider.userInfoModel!.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(300)),
                                                  color: ColorResources.COLOR_PURPLE_MID,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Icon(Icons.camera_alt, size: 30, color: Colors.white,),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                                  child: textField(hintText: 'Enter your First Name', label:'First Name', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _firstNameController, validator: (){}, onChanged: (){},),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Enter your Last Name', label:'Last Name', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _lastNameController, validator: (){}, onChanged: (){}),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Enter your Other Name', label:'Other Name', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _otherNameController, validator: (){}, onChanged: (){}),
                                ),
                                SizedBox(height: 15,),
                                /*
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Enter your Email', label:'Email', icon: Icon(Icons.mail, color: Colors.white,), controller: _emailController, validator: (){}, onChanged: (){}),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Enter your Phone Number', label:'Phone Number', icon: Icon(Icons.call, color: Colors.white,), controller: _phoneNumberController, validator: (){}, onChanged: (){}),
                                ),
                                SizedBox(height: 20,),
                                */
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Enter your Address', label:'Address', icon: Icon(Icons.location_on, color: Colors.white,), controller: _addressController, validator: (){}, onChanged: (){}),
                                ),
                                /*
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Enter your Date of Birth', label:'Date of Birth', icon: Icon(Icons.date_range, color: Colors.white), controller: _emailController, validator: (){},),
                                ),
                                SizedBox(height: 15,),
                                */
                    //-----------------------
                    /*
                                Consumer<StateProvider>(
                                    builder: (context, stateProvider, child) {
                                    return dropDownField(selected:0, icon: Icon(Icons.account_balance_sharp, color: Colors.white,), statesModel: stateProvider.states, label: 'Select State',);
                                  }
                                ),
                                SizedBox(height: 20,),
                                Consumer<StateProvider>(
                                    builder: (context, stateProvider, child) {
                                    return dropDownFieldLGA(selected:0, icon: Icon(Icons.account_balance_sharp, color: Colors.white,), LGAsModel: stateProvider.lga, label: 'Select LGA',);
                                  }
                                ),
                                SizedBox(height: 20,),
                                */
                                //-------------------

                                /*
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(Icons.account_balance_sharp),
                                    ),
                                    SizedBox(width: 13,child: Container(color: Colors.transparent,), height: 45,),
                                    SizedBox(width: 1,child: Container(color: Colors.white,), height: 45,),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0, bottom: 0),
                                        child: new DropdownButton(
                                          value: _value,
                                          items: <DropdownMenuItem<int>>[
                                            new DropdownMenuItem(
                                              child: new Text('Foo', style: TextStyle(color: Colors.white),),
                                              value: 0,
                                            ),
                                            new DropdownMenuItem(
                                              child: new Text('Bar', style: TextStyle(color: Colors.white),),
                                              value: 42,
                                            ),
                                          ],
                                          onChanged: (int? value) {
                                            setState(() {
                                              _value = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/

                      /*
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton(items: new List.generate(20, (int index){
                                          return new DropdownMenuItem(child: new Container(
                                            child: new Text ("Item#$index"),
                                            //width: 200.0, //200.0 to 100.0
                                          ));
                                        })
                                            , onChanged: null),
                                      ),
                                    ],
                                  )
                                  //textField(hintText: 'Select your Country', label:'Country', icon: Icon(Icons.flag, color: Colors.white), controller: _emailController, validator: (){},),
                                ),*/
                                SizedBox(height: 15,),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GenderView(selectedName: authProvider.userInfoModel!.gender.isEmpty?'Male':'${authProvider.userInfoModel!.gender[0].toUpperCase()}${authProvider.userInfoModel!.gender.substring(1)}', profile: true,),
                                ),
                                SizedBox(height: 15,),
                                //int.parse(Provider.of<AuthProvider>(context, listen: false).userInfoModel!.stateID)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: StateView(selectedState: authProvider.userInfoModel!.stateID.isEmpty?-1:int.parse(authProvider.userInfoModel!.stateID), selectedLGA: -1,),
                                ),
                                /*
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Select your State', label:'State', icon: Icon(Icons.account_balance_sharp, color: Colors.white), controller: _stateController, validator: (){}, onChanged: () {  },),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Select your LGA', label:'LGA', icon: Icon(Icons.account_balance_sharp, color: Colors.white), controller: _lgaController, validator: (){}, onChanged: () {  },),
                                ),*/
                                SizedBox(height: 15,),
                                /*
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: textField(hintText: 'Upload Image', label:'Image', icon: Icon(Icons.image, color: Colors.white), controller: _imageController, validator: (){}, onChanged: (){}),
                                ),
                                SizedBox(height: 15,),
                                */
                                if(_loading)Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                                ),
                                if(!_loading)Padding(
                                  padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(child: normalButton(
                                        backgroundColor: ColorResources.COLOR_PURPLE_MID,
                                        button_text: 'Update Profile',
                                        primaryColor: ColorResources.COLOR_WHITE,
                                        fontSize: 16,
                                        onTap: () async {
                                          if(_firstNameController.text.isEmpty){showCustomSnackBar('Please enter your first Name', context, isError: true); return true;}
                                          if(_lastNameController.text.isEmpty){showCustomSnackBar('Please enter your last Name', context, isError: true); return true;}
                                          if(_otherNameController.text.isEmpty){showCustomSnackBar('Please enter your other Name', context, isError: true); return true;}
                                          if(_addressController.text.isEmpty){showCustomSnackBar('Please enter your address', context, isError: true); return true;}
                                          if(formProvider.selectedState.id==-1){showCustomSnackBar('Please enter your state', context, isError: true); return true;}
                                          if(formProvider.selectedLGA.id==-1){showCustomSnackBar('Please enter your LGA', context, isError: true); return true;}
                                          /*
                                          ProfileDoctorModel profileModelNurse = ProfileDoctorModel(
                                              id: 1,//authProvider.userInfoModel!.id,
                                              firstName: _firstNameController.text,
                                              otherName: _otherNameController.text,
                                              lastName: _lastNameController.text,
                                              address: _addressController.text,
                                              //language: '',
                                              lgaID: formProvider.selectedLGA.id,
                                              gender: 'male',
                                              stateID: formProvider.selectedState.id);

                                          */
                                          print(_firstNameController.text);
                                          print(_lastNameController.text);
                                          print(_otherNameController.text);
                                          print(_addressController.text);
                                          print(formProvider.gender??Provider.of<AuthProvider>(context, listen: false).userInfoModel!.gender);
                                          print(formProvider.selectedState!.title);
                                          print(formProvider.selectedState!.id);
                                          print(formProvider.selectedLGA.id==-1?Provider.of<AuthProvider>(context, listen: false).userInfoModel!.lgaID:formProvider.selectedLGA.id);
                                          setState(() {
                                            _loading=true;
                                          });
                                          int lgaID = 0;
                                          if(formProvider.selectedLGA.id==-1){
                                            //lgaID = int.parse(Provider.of<AuthProvider>(context, listen: false).userInfoModel!.lgaID);
                                          }else{
                                            lgaID = formProvider.selectedLGA.id;
                                          }
                                          print('----777 ${lgaID}');

                                          setState(() {
                                            _loading=true;
                                          });
                                          if(widget.upDateProfile){
                                            print('update');
                                            ProfileDoctorModel profileModelNurse = ProfileDoctorModel(
                                                id: 1,//authProvider.userInfoModel!.id,
                                                firstName: _firstNameController.text,
                                                otherName: _otherNameController.text,
                                                lastName: _lastNameController.text,
                                                address: _addressController.text,
                                                //language: '',
                                                lgaID: formProvider.selectedLGA.id==-1?int.parse(authProvider.userInfoModel!.lgaID):formProvider.selectedLGA.id,
                                                gender: formProvider.gender??authProvider.userInfoModel!.gender,
                                                stateID: formProvider.selectedState.id==-1?int.parse(authProvider.userInfoModel!.stateID):formProvider.selectedState.id);

                                            String token = Provider.of<AuthProvider>(context, listen: false).token;
                                            print(profileModelNurse.toJson());
                                            await Provider.of<ProfileProvider>(context, listen: false).updateUserInfo(profileModelNurse, token).then((ResponseModel responseModel) async {
                                              if(responseModel.isSuccess){
                                                await Provider.of<AuthProvider>(context, listen: false).updateUser(
                                                    firstName:_firstNameController.text, lastName:_lastNameController.text, otherName:_otherNameController.text,
                                                    address:_addressController.text,
                                                    //stateID:Provider.of<AuthProvider>(context, listen: false).userInfoModel!.stateID,//formProvider.selectedState.id,
                                                    //lgaID:Provider.of<AuthProvider>(context, listen: false).userInfoModel!.lgaID//lgaID

                                                    lgaID: formProvider.selectedLGA.id==-1?int.parse(authProvider.userInfoModel!.lgaID):formProvider.selectedLGA.id,
                                                    gender: formProvider.gender??authProvider.userInfoModel!.gender,
                                                    stateID: formProvider.selectedState.id==-1?int.parse(authProvider.userInfoModel!.stateID):formProvider.selectedState.id
                                                );
                                                setState(() {
                                                  _loading=false;
                                                });
                                                Navigator.pop(context);
                                              }
                                            });
                                          }else{
                                            print('setUp');
                                            ProfileDoctorModel profileModelNurse = ProfileDoctorModel(
                                                id: 1,//authProvider.userInfoModel!.id,
                                                firstName: _firstNameController.text,
                                                otherName: _otherNameController.text,
                                                lastName: _lastNameController.text,
                                                address: _addressController.text,
                                                //language: '',
                                                lgaID: formProvider.selectedLGA.id==-1?1:formProvider.selectedLGA.id,
                                                gender: formProvider.gender??'male',
                                                stateID: formProvider.selectedState.id==-1?1:formProvider.selectedState.id);

                                            setState(() {
                                              _loading=true;
                                            });
                                            String token = Provider.of<AuthProvider>(context, listen: false).token;
                                            print(profileModelNurse.toJson());
                                            await Provider.of<ProfileProvider>(context, listen: false).updateUserInfo(profileModelNurse, token).then((ResponseModel responseModel) async {
                                              if(responseModel.isSuccess){
                                                Provider.of<AuthProvider>(context, listen: false).updateUser(
                                                    firstName:_firstNameController.text, lastName:_lastNameController.text, otherName:_otherNameController.text,
                                                    address:_addressController.text,
                                                    //stateID:Provider.of<AuthProvider>(context, listen: false).userInfoModel!.stateID,//formProvider.selectedState.id,
                                                    //lgaID:Provider.of<AuthProvider>(context, listen: false).userInfoModel!.lgaID//lgaID


                                                    lgaID: formProvider.selectedLGA.id==-1?int.parse(authProvider.userInfoModel!.lgaID):formProvider.selectedLGA.id,
                                                    gender: formProvider.gender??authProvider.userInfoModel!.gender,
                                                    stateID: formProvider.selectedState.id==-1?int.parse(authProvider.userInfoModel!.stateID):formProvider.selectedState.id
                                                );
                                                setState(() {
                                                  _loading=false;
                                                });

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                                                );
                                              }
                                            });
                                          }

                                          },
                                      )),
                                    ],
                                  ),
                                ),
                              ],),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
            }
          ),
        ),
      ],
    );
  }
}
