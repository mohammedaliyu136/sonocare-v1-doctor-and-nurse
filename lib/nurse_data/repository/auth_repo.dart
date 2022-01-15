import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/signupModel.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AuthRepo {
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> login({required String email, required String password}) async {
    print(AppConstants.LOGIN_URI_NURSE);
    Response response = await remoteClient.post(
      AppConstants.LOGIN_URI_NURSE,
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
    print(AppConstants.LOGIN_URI_NURSE);
    Response response = await remoteClient.post(
      AppConstants.LOGIN_URI_NURSE,
      data: {"email": email, "password": password},
    );
    if(response.statusCode==400){
      return ApiResponse.withSuccess(response);
    }else{
      String err = jsonDecode(response.body)['message']??jsonDecode(response.body)['error'];
      return ApiResponse.withError(err);
    }
  }

  Future<ApiResponse> registration(SignUpModelNurse signUpModel) async {
    print(signUpModel.toJson());
    print(        AppConstants.REGISTER_USER_NURSE
    );
    try {
      Response response = await remoteClient.post(
        AppConstants.REGISTER_USER_NURSE, data: signUpModel.toJson(),
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

  Future<ApiResponse> getStates() async {
    try {
      final response = await remoteClient.get(AppConstants.STATE_LIST_URI,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  Future<Response> uploadProfileImage(File? profileImage, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}/api/nuseupdateimage?token=${token}'));
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

  Future<ApiResponse> emailVerification({required String email, required String email_verification_code}) async {
    print(AppConstants.DOCTOR_EMAIL_VERIFICATION);//+'?doctor_id=$doctor_id&email_verification_code=$email_verification_code');
    print('000000000000');
    print(email);
    print(email_verification_code);
    try {
      Response response = await remoteClient.post(
        AppConstants.DOCTOR_EMAIL_VERIFICATION,//+'?doctor_id=$doctor_id&email_verification_code=$email_verification_code',
        data: {"email": email, "token": email_verification_code},
      );
      print(email_verification_code);
      print(response.statusCode);
      print(response.body);
      if(jsonDecode(response.body)['message']!="Invalid Email Verification code"){
        print(response.statusCode);
        print(response.body);
        return ApiResponse.withSuccess(response);
      }else{
        return ApiResponse.withError(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError('Can\'t login Something went wrong');
    }
  }

  Future<ApiResponse> getNurseService() async {
    try {
      final response = await remoteClient.get(AppConstants.NURSE_SERVICE_LIST_URI,);
      print('-------------');
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
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
      final response = await remoteClient.get(AppConstants.NURSE_TYPE_LIST_URI,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

}