
import 'dart:convert';
import 'dart:io';
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/service_fee_model.dart';
import 'package:doctor_v2/data/model/signupModel.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultationRepo {
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;

  ConsultationRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> setConsultationFee({required ServiceFeeModel serviceFeeModel, required String token}) async {
    print(AppConstants.SET_CONSULTATION_FEE);
    Response response = await remoteClient.post(
      AppConstants.SET_CONSULTATION_FEE+token,
      data: serviceFeeModel.toJson(),
    );
    print(response.statusCode);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
}