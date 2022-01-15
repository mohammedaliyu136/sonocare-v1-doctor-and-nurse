import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/repository/service_preference_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NurseServicePreferenceProvider with ChangeNotifier{
  // /api/nursesetfee?token=
  late ServicePreferenceRepo servicePreferenceRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModelNurse> setServicePreference(int serviceID, String serviceFee, token) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    ServicePreferenceRepo servicePreferenceRepo = ServicePreferenceRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;

    ApiResponse apiResponse = await servicePreferenceRepo.setServiceFee(serviceID, serviceFee, token);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

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