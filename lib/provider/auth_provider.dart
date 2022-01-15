import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/signupModel.dart';
import 'package:doctor_v2/data/model/state_model.dart';
import 'package:doctor_v2/data/model/userModel.dart';
import 'package:doctor_v2/data/model/util_models.dart';
import 'package:doctor_v2/data/model/verificationModel.dart';
import 'package:doctor_v2/data/repository/auth_repo.dart';
import 'package:doctor_v2/data/repository/state_repo.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/welcome/welcome_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider with ChangeNotifier {
  late AuthRepo authRepo;
  late StateRepo stateRepo;

  VerificationModelDoctor verificationModelDoctor = VerificationModelDoctor(id:1);

  AuthProvider(){
    initialization();
  }
  // for registration section
  bool _isLoading = false;

  String imgUrl = "";

  List<StateModel> states = [];
  List<LGAModel> lga = [];

  bool get isLoading => _isLoading;

  UserInfoModel? userInfoModel;
  // for login section
  String _loginErrorMessage = '';
  String _email = '';
  String _password = '';
  String _token = '';
  get token => _token;

  String get loginErrorMessage => _loginErrorMessage;
  String get email => _email;
  String get password => _password;

  setEmail(email, password){
    _email = email;
    _password = password;
  }

  not()async{
    notifyListeners();
  }

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    this.authRepo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
  }

  updateUser({firstName, lastName, otherName, address, gender, stateID, lgaID}){
    userInfoModel!.updateProfile(firstName:firstName, lastName:lastName, otherName:otherName, address:address, gender:gender, stateID:stateID, lgaID:lgaID);
    userInfoModel!.firstName=firstName;
    notifyListeners();
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(email: email, password: password);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      print(apiResponse.response!.body);
      var responseBody = jsonDecode(apiResponse.response!.body);
      var userJsonObj = responseBody['user'];

      print(userJsonObj);

      userInfoModel = UserInfoModel.fromJson(userJsonObj);
      _token = responseBody['access_token'];
      saveUserDetail(userObject: userInfoModel!, token: _token);

      //_token = responseBody['token'];
      //print(token);
      //authRepo.saveUserToken(token);
      //await authRepo.updateToken();
      print('090909090990000');
      //print(token);
      responseModel = ResponseModel(true, 'Login Successful');
    } else {
      print(apiResponse.error);
      /*
      print(apiResponse.error);
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
      */
      _loginErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, _loginErrorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
  Future<ResponseModel> loginNotVerified(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.loginNotVerified(email: email, password: password);
    print(apiResponse.response!.statusCode);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 400) {
      print(apiResponse.response!.body);
      var responseBody = jsonDecode(apiResponse.response!.body);
      String message = responseBody['message'];

      //userInfoModel = UserInfoModel.fromJson(userJsonObj);
      //_token = responseBody['access_token'];
      _token = responseBody['token'];
      //print(token);
      //authRepo.saveUserToken(token);
      //await authRepo.updateToken();
      print('090909090990000');
      //print(token);
      responseModel = ResponseModel(true, 'Login Successful');
    } else {
      print(apiResponse.error);
      /*
      print(apiResponse.error);
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
      */
      _loginErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, _loginErrorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel> checkEmail(String email, String accountType) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.checkEmail(email: email, accountType: accountType);
    print(apiResponse.response!.statusCode);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      print(apiResponse.response!.body);
      var responseBody = jsonDecode(apiResponse.response!.body);
      String message = responseBody['message'];

      //userInfoModel = UserInfoModel.fromJson(userJsonObj);
      //_token = responseBody['access_token'];
      //print(token);
      //authRepo.saveUserToken(token);
      //await authRepo.updateToken();
      print('090909090990000');
      //print(token);
      responseModel = ResponseModel(true, message);
    } else {
      print(apiResponse.error);
      /*
      print(apiResponse.error);
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
      */
      _loginErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, _loginErrorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
  Future<ResponseModel> resetPassword(String email, String accountType, String otp, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.resetPassword(email: email, accountType: accountType, otp: otp, password: password);
    print(apiResponse.response!.statusCode);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      print(apiResponse.response!.body);
      var responseBody = jsonDecode(apiResponse.response!.body);
      String message = responseBody['message'];

      //userInfoModel = UserInfoModel.fromJson(userJsonObj);
      //_token = responseBody['access_token'];
      //print(token);
      //authRepo.saveUserToken(token);
      //await authRepo.updateToken();
      print('090909090990000');
      //print(token);
      responseModel = ResponseModel(true, message);
    } else {
      print(apiResponse.error);
      /*
      print(apiResponse.error);
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
      */
      _loginErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, _loginErrorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  String _registrationErrorMessage = '';

  String get registrationErrorMessage => _registrationErrorMessage;

  updateRegistrationErrorMessage(String message) {
    _registrationErrorMessage = message;
    notifyListeners();
  }

  Future<ResponseModel> uploadProfileImage(XFile profileImage, _token)async{
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    print('start uploading');
    Response apiResponse = await authRepo.uploadProfileImage(profileImage, _token);
    print(apiResponse!.statusCode);
    imgUrl = jsonDecode(apiResponse.body)['image'];
    userInfoModel!.image = jsonDecode(apiResponse.body)['image'];
    ResponseModel responseModel;
    if(apiResponse!.statusCode == 200){
      responseModel = ResponseModel(true, 'Updated Profile Image Successfully');
    }else{
      responseModel = ResponseModel(false, 'Something went wrong.');
    }

    /*
    if (apiResponse != null && apiResponse!.statusCode == 200) {
      responseModel = ResponseModel(true, 'Updated Successfully');
    } else {
      //_loginErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, "_loginErrorMessage");
    }*/
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    _registrationErrorMessage = '';
    setEmail(signUpModel.email, signUpModel.password);
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(signUpModel);
    ResponseModel responseModel;
    print('-------------------------');
    print(apiResponse.response);
    print('-------------------------');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 201) {
      var responseBody = jsonDecode(apiResponse.response!.body);
      print(responseBody);
      _email = responseBody['email'];
      //var userJsonObj = responseBody['user']; 99X5

      print('----------09909');
      //print(userJsonObj);

      //userInfoModel = UserInfoModel.fromJson(userJsonObj);
      //print(userInfoModel!.firstName+' '+userInfoModel!.otherName+' '+userInfoModel!.lastName);

      //Map map = apiResponse.response.data;
      //String token = map["token"];
      //authRepo.saveUserToken(token);
      //await authRepo.updateToken();
      responseModel = ResponseModel(true, 'Registration Successful');
      print('90090909090909 - 1');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        var errorResponse = apiResponse;
        //errorMessage = errorResponse;
      }
      print(apiResponse.error);
      //_registrationErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, apiResponse.error);
      print('90090909090909 - 2');
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> email_verification({email_verification_code, email}) async {
    _isLoading = true;
    _registrationErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.emailVerification(email_verification_code: email_verification_code, email: email);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body);
      //_token = responseBody['access_token'];
      //Map map = apiResponse.response.data;
      //String token = map["token"];
      //authRepo.saveUserToken(token);
      //await authRepo.updateToken();
      responseModel = ResponseModel(true, 'Email Verification Successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        var errorResponse = apiResponse;
        //errorMessage = errorResponse;
      }
      print(apiResponse.error);
      //_registrationErrorMessage = apiResponse.error;
      responseModel = ResponseModel(false, 'Email Verification Failed');
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> getStatehs(BuildContext context,) async {
    ResponseModel _responseModel;
    ApiResponse apiResponse = await stateRepo.getStates();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      for( var i = 0 ; i < data['getAllState'].length; i++ ) {
        states.add(StateModel.fromJson(data['getAllState'][i]));
      }
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    notifyListeners();
    return _responseModel;
  }

  startVerification(doctorID){
    if(this.verificationModelDoctor!=null){
      this.verificationModelDoctor = VerificationModelDoctor(id:doctorID);
    }
  }

  bool loadingServicePreferences = false;
  List<ServicePref> servicePreferencesList = [ServicePref(type: '',id: '')];
  Future<ResponseModel> getServicePreferences() async {
    loadingServicePreferences = true;
    servicePreferencesList = [ServicePref(type: '',id: '')];
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AuthRepo authRepoo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepoo.getServicePreferences();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      print(data);
      servicePreferencesList = [];
      for( var i = 0 ; i < data['data'].length; i++ ) {
        servicePreferencesList.add(ServicePref.fromJson(data['data'][i]));
      }
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    loadingServicePreferences = false;
    notifyListeners();
    return _responseModel;
  }

  bool loadingDoctorType = false;
  List<DoctorType> doctorTypeList = [DoctorType(id: '', title: '')];
  Future<ResponseModel> getDoctorType() async {
    loadingDoctorType = true;
    doctorTypeList = [DoctorType(id: '', title: '')];
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AuthRepo authRepoo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepoo.getDoctorType();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      doctorTypeList = [];
      for( var i = 0 ; i < data['data'].length; i++ ) {
        doctorTypeList.add(DoctorType.fromJson(data['data'][i]));
      }
      print(doctorTypeList);
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    loadingDoctorType = false;
    notifyListeners();
    return _responseModel;
  }

  bool loadingNurseType = false;
  List<NurseType> nurseTypeList = [NurseType(id: '', title: '')];
  Future<ResponseModel> getNurseType() async {
    loadingNurseType = true;
    nurseTypeList = [NurseType(id: '', title: '')];
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AuthRepo authRepoo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepoo.getNurseType();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      nurseTypeList = [];
      for( var i = 0 ; i < data['data'].length; i++ ) {
        nurseTypeList.add(NurseType.fromJson(data['data'][i]));
      }
      print(nurseTypeList);
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    loadingNurseType = false;
    notifyListeners();
    return _responseModel;
  }

  bool loadingConsultationType = false;
  List<ConsultationType> consultationTypeList = [ConsultationType(id: '', title: '')];
  Future<ResponseModel> getConsultationType() async {
    loadingConsultationType = true;
    consultationTypeList = [ConsultationType(id: '', title: '')];
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AuthRepo authRepoo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepoo.getConsultationType();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      consultationTypeList = [];
      for( var i = 0 ; i < data['data'].length; i++ ) {
        consultationTypeList.add(ConsultationType.fromJson(data['data'][i]));
      }
      print(consultationTypeList);
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    loadingConsultationType = false;
    notifyListeners();
    return _responseModel;
  }

  bool loadingConsultationFee = false;
  List<ConsultationFee> consultationFeeList = [ConsultationFee(id: '', servicesType: '', price: '')];
  Future<ResponseModel> getConsultationFee(token) async {
    loadingConsultationFee = true;
    consultationFeeList = [ConsultationFee(id: '', servicesType: '', price: '')];
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AuthRepo authRepoo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepoo.getConsultationFee(token);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      consultationFeeList = [];
      for( var i = 0 ; i < data['data'].length; i++ ) {
        print(data['data']);
        consultationFeeList.add(ConsultationFee.fromJson(data['data'][i]));
      }
      print(consultationFeeList);
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    loadingConsultationFee = false;
    notifyListeners();
    return _responseModel;
  }

  Future<ResponseModel> setConsultationFee(token, consultationFee) async {
    loadingConsultationFee = true;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AuthRepo authRepoo = AuthRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepoo.setConsultationFee(token, consultationFee);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }
    loadingConsultationFee = false;
    notifyListeners();
    return _responseModel;
  }

  verifyDoctor(){
    print('id: ${this.verificationModelDoctor.id}');
    print('gender: ${this.verificationModelDoctor.gender}');
    print('Specialty Code: ${this.verificationModelDoctor.specialityCode}');
    print('country: ${this.verificationModelDoctor.country}');
    print('referedBy: ${this.verificationModelDoctor.referedBy}');
    print('degreeCert: ${this.verificationModelDoctor.degreeCert}');
    print('medicalLicence: ${this.verificationModelDoctor.medicalLicence}');
    print('backingInformation: ${this.verificationModelDoctor.backingInformation}');
    print('companyOrganisation: ${this.verificationModelDoctor.companyOrganisation}');
    print('workingFrom: ${this.verificationModelDoctor.workingFrom}');
    print('workingTo: ${this.verificationModelDoctor.workingTo}');
  }

  saveUserDetail({required UserInfoModel userObject, required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userObjectSTR = json.encode(userObject);
    await prefs.setString('user_object', userObjectSTR);
    await prefs.setString('user_login_type', 'doctor');
    await prefs.setString('user_token', token);

    FirebaseMessaging.instance.getToken().then((value){
      CollectionReference fcmTokens = FirebaseFirestore.instance.collection('fcm_tokens');
      fcmTokens.add({
        'full_name': userObject.firstName+' '+userObject.lastName, // John Doe
        'token': value, // Stokes and Sons
      });
    });
  }
  getUserDetail({context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userObjectSTR = await prefs.getString('user_object')??'';
    this.userInfoModel = UserInfoModel.fromJson(json.decode(userObjectSTR));
    String tokenSTR = await prefs.getString('user_token')??'';
    this._token = tokenSTR;
    notifyListeners();

    if(tokenSTR.length>1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_object', '');
    await prefs.setString('user_login_type', '');
    await prefs.setString('user_token', '');
  }



}