import 'dart:convert';
import 'dart:io';

import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/profile_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/userModel.dart';
import 'package:doctor_v2/data/repository/profile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {

  late ProfileRepo profileRepo;


  late UserInfoModel _userInfoModel;
  late ProfileDoctorModel _profileDoctorModel;

  UserInfoModel get userInfoModel => _userInfoModel;
  ProfileDoctorModel get profileDoctorModel => _profileDoctorModel;

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    this.profileRepo = ProfileRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
  }

  Future<ResponseModel> getUserInfo(BuildContext context, int user_id) async {
    ResponseModel _responseModel;
    ApiResponse apiResponse = await profileRepo.getUserInfo(user_id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body);
      //String token = responseBody['token'];
      var userJsonObj = responseBody['NurseProfile'];

      print(userJsonObj);

      _profileDoctorModel = ProfileDoctorModel.fromJson(userJsonObj);
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<ResponseModel> updateUserInfo(ProfileDoctorModel profileDoctorModel, String token) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    var profileRepo = ProfileRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    ResponseModel _responseModel;
    ApiResponse apiResponse = await profileRepo.updateProfile(profileDoctorModel, token);
    print(apiResponse);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      //_loginErrorMessage = errorMessage;
      _responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }


}
