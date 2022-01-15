import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentRepo {
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;

  AppointmentRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> getAppointments({required String token}) async {
    print(AppConstants.GET_APPOINTMENTS);
    Response response = await remoteClient.post(
      AppConstants.GET_APPOINTMENTS+token,
      data: {
        "status":"all"
      }
      //data: serviceFeeModel.toJson(),
    );
    print('=================');
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
  Future<ApiResponse> acceptVitalSignAppointments({required String token, required String appointment_id}) async {
    print(AppConstants.ACCEPT_VITAL_SIGN_APPOINTMENTS);
    Response response = await remoteClient.post(
      AppConstants.ACCEPT_VITAL_SIGN_APPOINTMENTS+token,
      data: {"vital_sign_id": "14"},
    );
    print(response.statusCode);
    print(response.body);
    print('0-0-00-0-0');
    if(response.statusCode==400){
      return ApiResponse.withSuccess(response);
    }
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
  Future<ApiResponse> declineAppointments({required String token, required String appointment_id}) async {
    print(AppConstants.DECLINE_APPOINTMENTS);
    Response response = await remoteClient.post(
      AppConstants.DECLINE_APPOINTMENTS+token,
      data: {
        'id':appointment_id,
        "r_date":"01/02/2020",
        "r_time":"10:20AM",
        "r_day":"Morning"
      },
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
  Future<ApiResponse> getAppointmentDetail(appointmentID, token) async {
    print(AppConstants.GET_APPOINTMENT_DETAIL);
    Response response = await remoteClient.post(
      AppConstants.GET_APPOINTMENT_DETAIL+token,
      data: {
        'appointment_id':appointmentID
      },
      //data: serviceFeeModel.toJson(),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
  Future<ApiResponse> getPatientDetail(patient_id) async {
    print(AppConstants.GET_PATIENT_DETAIL);
    Response response = await remoteClient.post(
      AppConstants.GET_PATIENT_DETAIL,
      data: {
        'patient_id':patient_id
      },
      //data: serviceFeeModel.toJson(),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
}