import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/profile_model.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({required this.remoteClient, required this.sharedPreferences});


  Future<ApiResponse> getUserInfo(user_id) async {
    try {
      final response = await remoteClient.get('${AppConstants.CUSTOMER_INFO_URI_NURSE}?nurse_id=$user_id',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }
  Future<ApiResponse> updateProfile(ProfileDoctorModel profileDoctorModel, String token) async {
    try {
      print('start updating profile');
      print(profileDoctorModel.toJson());
      final response = await remoteClient.post('${AppConstants.CUSTOMER_INFO_NURSE_UPDATE}${token}',
        data: profileDoctorModel.toJson()
      );
      print('end updating profile');
      print(response.statusCode);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  /*
  Future<http.StreamedResponse> updateProfile(ProfileDoctorModel profileDoctorModel, PickedFile data, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.UPDATE_PROFILE_URI_DOCTOR}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    File _file = File(data.path);
    request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));

    request.fields.addAll(profileDoctorModel.toJson());
    http.StreamedResponse response = await request.send();
    return response;
  }
*/


  /*
  Future<http.StreamedResponse> updateProfile2(UserInfoModel userInfoModel, PickedFile data, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.UPDATE_PROFILE_URI}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    File _file = File(data.path);
    request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));

    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'f_name': userInfoModel.fName, 'l_name': userInfoModel.lName, 'email': userInfoModel.email
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }
  */

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

}