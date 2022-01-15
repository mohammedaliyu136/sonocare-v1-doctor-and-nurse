import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/prescription_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/vitalSignModel.dart';
import 'package:doctor_v2/data/repository/prescription_repo.dart';
import 'package:doctor_v2/data/repository/vital_sign_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionProvider with ChangeNotifier {

  late PrescriptionRepo prescriptionRepo;

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    this.prescriptionRepo = PrescriptionRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
  }


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> setPrescription(PrescriptionModel prescriptionModel, token) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    PrescriptionRepo prescriptionRepo = PrescriptionRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;

    print('-------------');
    print(prescriptionModel.toJson());
    print('-------------');

    ApiResponse apiResponse = await prescriptionRepo.setPrescription(prescriptionModel, token);
    print(apiResponse);
    _isLoading = false;
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
    notifyListeners();
    return _responseModel;
  }

}