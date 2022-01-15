import 'dart:convert';
import 'dart:io';

import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/state_model.dart';
import 'package:doctor_v2/nurse_data/model/userModel.dart';
import 'package:doctor_v2/nurse_data/repository/state_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class StateProvider with ChangeNotifier {
  StateRepo stateRepo = StateRepo(remoteClient: RemoteClient());

  late UserInfoModel _userInfoModel;

  UserInfoModel get userInfoModel => _userInfoModel;

  List<StateModel> states = [];
  List<LGAModel> lga = [];

  int? selectedState;
  int? selectedLGA;

  initialization() async {
  }

  Future<ResponseModelNurse> getStates() async {
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await stateRepo.getStates();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      for( var i = 0 ; i < data['getAllState'].length; i++ ) {
        states.add(StateModel.fromJson(data['getAllState'][i]));
      }
      _responseModel = ResponseModelNurse(true, 'successful');
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModelNurse(false, _errorMessage);
    }
    notifyListeners();
    return _responseModel;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModelNurse> getLGAs(int stateID) async {
    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await stateRepo.getLGA(stateID);
    print(apiResponse);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var data = jsonDecode(apiResponse.response!.body);
      for( var i = 0 ; i < data['LGA'].length; i++ ) {
        states.add(StateModel.fromJson(data['LGA'][i]));
      }
      print(states);
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
