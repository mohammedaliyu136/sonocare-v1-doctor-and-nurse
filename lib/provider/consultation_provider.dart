import 'dart:convert';
import 'dart:io';

import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/profile_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/service_fee_model.dart';
import 'package:doctor_v2/data/model/userModel.dart';
import 'package:doctor_v2/data/repository/consultation_repo.dart';
import 'package:doctor_v2/data/repository/profile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConsultationProvider with ChangeNotifier {

  late ConsultationRepo consultationRepo;

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    this.consultationRepo = ConsultationRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
  }

  ConsultationProvider(){
    initialization();
  }

  Future<ResponseModel> setConsultationFee(BuildContext context,String token, ServiceFeeModel serviceFeeModel,) async {
    ResponseModel _responseModel;
    ApiResponse apiResponse = await consultationRepo.setConsultationFee(token: token, serviceFeeModel: serviceFeeModel,);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body);
      _responseModel = ResponseModel(true, responseBody['message']);
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


}
