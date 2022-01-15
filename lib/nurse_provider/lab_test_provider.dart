//LabTestProvider

import 'dart:convert';

import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/lab_test_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/repository/lab_test_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabTestProvider with ChangeNotifier {

  late LabTestRepo labTestRepo;

  List<LabTestModel> labTests = [];
  List<SubLabTestModel> subLabTests = [];

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    this.labTestRepo = LabTestRepo(
        remoteClient: remoteClient, sharedPreferences: sharedPreferences);
  }


  bool _isLoadingMainList = false;
  bool _isLoadingSubList = false;

  bool get isLoadingMainList => _isLoadingMainList;
  bool get isLoadingSubList => _isLoadingSubList;

  Future<ResponseModelNurse> getLabTestCategory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    LabTestRepo labTestRepo = LabTestRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    _isLoadingMainList = true;
    notifyListeners();
    ResponseModelNurse _responseModel;

    ApiResponse apiResponse = await labTestRepo.getLabTestCategory();
    print(apiResponse);
    _isLoadingMainList = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      labTests = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        labTests.add(LabTestModel.fromJson(responseBody[i]));
      }
      _responseModel = ResponseModelNurse(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      //_loginErrorMessage = errorMessage;
      _responseModel = ResponseModelNurse(false, errorMessage);
    }
    notifyListeners();
    return _responseModel;
  }
  Future<ResponseModelNurse> getSubLabTestCategory(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    LabTestRepo labTestRepo = LabTestRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    _isLoadingSubList = true;
    notifyListeners();
    ResponseModelNurse _responseModel;

    ApiResponse apiResponse = await labTestRepo.getSubLabTestCategory(id);
    print(apiResponse);
    _isLoadingSubList = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      subLabTests = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        subLabTests.add(SubLabTestModel.fromJson(responseBody[i]));
      }
      _responseModel = ResponseModelNurse(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      //_loginErrorMessage = errorMessage;
      _responseModel = ResponseModelNurse(false, errorMessage);
    }
    notifyListeners();
    return _responseModel;
  }

}