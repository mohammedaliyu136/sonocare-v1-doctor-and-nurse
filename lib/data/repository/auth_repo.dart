
import 'dart:convert';
import 'dart:io';
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/signupModel.dart';
import 'package:doctor_v2/data/model/util_models.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> login({required String email, required String password}) async {
    print(AppConstants.LOGIN_URI_DOCTOR);
    Response response = await remoteClient.post(
      AppConstants.LOGIN_URI_DOCTOR,
      data: {"email": email, "password": password},
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      String err = jsonDecode(response.body)['message']??jsonDecode(response.body)['error'];
      return ApiResponse.withError(err);
    }
  }
  Future<ApiResponse> loginNotVerified({required String email, required String password}) async {
    print(AppConstants.LOGIN_URI_DOCTOR);
    Response response = await remoteClient.post(
      AppConstants.LOGIN_URI_DOCTOR,
      data: {"email": email, "password": password},
    );
    if(response.statusCode==400){
      return ApiResponse.withSuccess(response);
    }else{
      String err = jsonDecode(response.body)['message']??jsonDecode(response.body)['error'];
      return ApiResponse.withError(err);
    }
  }

  Future<ApiResponse> registration(SignUpModel signUpModel) async {
    print(signUpModel.toJson());
    print(        AppConstants.REGISTER_USER_DOCTOR
    );
    try {
      Response response = await remoteClient.post(
        AppConstants.REGISTER_USER_DOCTOR, data: signUpModel.toJson(),
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==201){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> checkEmail({email, accountType}) async {
    try {
      Response response = await remoteClient.post(
        '/api/${accountType}/resetpass', data: {"email":email},
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> resetPassword({email, accountType, otp, password}) async {
    try {
      Response response = await remoteClient.post(
        '/api/${accountType}/setpass', data: {
        "otp":otp,
        "email":email,
        "password":password
      },
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> getStates() async {
    try {
      final response = await remoteClient.get(AppConstants.STATE_LIST_URI,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  Future<ApiResponse> emailVerification({required String email, required String email_verification_code}) async {
    print(AppConstants.DOCTOR_EMAIL_VERIFICATION);//+'?doctor_id=$doctor_id&email_verification_code=$email_verification_code');
    try {
      Response response = await remoteClient.post(
        AppConstants.DOCTOR_EMAIL_VERIFICATION,//+'?doctor_id=$doctor_id&email_verification_code=$email_verification_code',
        data: {"email": email, "email_verification_code": email_verification_code},
      );
      if(jsonDecode(response.body)['message']!="Invalid Email Verification code"){
        print(response.statusCode);
        print(response.body);
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(jsonDecode(response.body)['message']);
      }
      print(response.statusCode);
      print(response.headers);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError('Can\'t login Something went wrong');
    }
  }

  Future<Response> uploadProfileImage(XFile? profileImage, String token) async {

    print(token);
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}/api/doctorupdateimage?token=${token}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    File _file = File(profileImage!.path);
    request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      //'about': step['about']
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    print("response.statusCode");
    print(response.statusCode);
    var response12 = await http.Response.fromStream(response);
    print(response12.body);
    return response12;
  }

  Future<ApiResponse> getServicePreferences() async {
    try {
      final response = await remoteClient.get(AppConstants.SERVICE_PREFERENCE_LIST_URI,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  Future<ApiResponse> getNurseType() async {
    try {
      final response = await remoteClient.get('/api/nurse_type',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  Future<ApiResponse> getDoctorType() async {
    try {
      final response = await remoteClient.get('/api/doctor_type',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }
  Future<ApiResponse> getConsultationType() async {
    try {
      final response = await remoteClient.get('/api/preferences',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }
  Future<ApiResponse> getConsultationFee(token) async {
    try {
      final response = await remoteClient.get('/api/getConsultationFee?token=${token}',);
      print(response);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }
  Future<ApiResponse> setConsultationFee(token, ConsultationFee consultationFee) async {
    try {
      final response = await remoteClient.post('/api/setConsultationFee?token=${token}',
          data: {
            "consultation_fee":consultationFee.price,
            "type":consultationFee.servicesType
          }
      );
      print(response);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  /*
  // for forgot password
  Future<ApiResponse> forgetPassword(String email) async {
    try {
      Response response = await dioClient.post(AppConstants.FORGET_PASSWORD_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyToken(String email, String token) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_TOKEN_URI, data: {"email": email, "reset_token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String resetToken, String password, String confirmPassword) async {
    try {
      Response response = await dioClient.post(
        AppConstants.RESET_PASSWORD_URI,
        data: {"_method": "put", "reset_token": resetToken, "password": password, "confirm_password": confirmPassword},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for verify phone number
  Future<ApiResponse> checkEmail(String email) async {
    try {
      Response response = await dioClient.post(AppConstants.CHECK_EMAIL_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(String email, String token) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_EMAIL_URI, data: {"email": email, "token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    if(!kIsWeb) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    }
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.CART_LIST);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    await sharedPreferences.remove(AppConstants.SEARCH_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }
  */
}