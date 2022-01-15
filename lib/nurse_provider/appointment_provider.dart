import 'dart:convert';
import 'dart:io';

import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/appointment_model.dart';
import 'package:doctor_v2/nurse_data/model/profile_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/service_fee_model.dart';
import 'package:doctor_v2/nurse_data/model/userModel.dart';
import 'package:doctor_v2/nurse_data/model/vital_sign_model.dart';
import 'package:doctor_v2/nurse_data/repository/appointment_repo.dart';
import 'package:doctor_v2/nurse_data/repository/consultation_repo.dart';
import 'package:doctor_v2/nurse_data/repository/profile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentNurseProvider with ChangeNotifier {

  late AppointmentRepo appointmentRepo;
  late PatientModel _patientModel;
  List<AppointmentModel> appointments = [];
  List<AppointmentModel> pendingAppointments = [];
  AppointmentModel? appointment;

  PatientModel get patientModel => _patientModel;

  AppointmentNurseProvider(){
    initialization();
  }

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    appointmentRepo = AppointmentRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    print(appointmentRepo);
  }

  setSelectedAppointment(_appointment){
    appointment=_appointment;
    notifyListeners();
  }

  ResponseModelNurse getRequests(BuildContext context,String token, status) {
    ResponseModelNurse _responseModel;
    _responseModel = ResponseModelNurse(true, 'success');
    return _responseModel;
  }
  Future<ResponseModelNurse> getAppointments(BuildContext context,String token, status) async {
    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    AppointmentRepo appointmentRepoo = AppointmentRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ApiResponse apiResponse = await appointmentRepoo.getAppointments(token: token);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      appointments = [];
      pendingAppointments = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        pendingAppointments.add(AppointmentModel.fromJson(responseBody[i]));
        if(responseBody[i]['status']=='0'){
          //pendingAppointments.add(AppointmentModel.fromJson(responseBody[i]));
        }else{
          //appointments.add(AppointmentModel.fromJson(responseBody[i]));
        }
      }
      _responseModel = ResponseModelNurse(true, 'success');
      _isLoading = false;
      notifyListeners();
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
    _responseModel = ResponseModelNurse(false, 'error');
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }

  Future<ResponseModelNurse> getPatientDetail(BuildContext context, patient_id) async {
    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await appointmentRepo.getPatientDetail(patient_id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body);
      print(responseBody.length);
      _patientModel = PatientModel.fromJson(responseBody['data']);
      for( var i = 0 ; i < responseBody['vitalsign'].length; i++ ) {
        //print(responseBody['vitalsign'][i]);
        _patientModel.vitals.add(VitalSignModel.fromJson(responseBody['vitalsign'][i]));
      }
      _responseModel = ResponseModelNurse(true, 'success');
      _isLoading = false;
      notifyListeners();
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
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }
  Future<ResponseModelNurse> getAppointmentDetail(BuildContext context, appointmentID, token, index) async {
    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await appointmentRepo.getAppointmentDetail(appointmentID, token);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body);
      appointments[index].setAppointmentDateTime(responseBody['data'][0]['date'], responseBody['data'][0]['time'], responseBody['data'][0]['day']);
      _responseModel = ResponseModelNurse(true, 'success');
      _isLoading = false;
      notifyListeners();
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
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }
  Future<ResponseModelNurse> acceptVitalSignAppointments(BuildContext context,String token, String appointment_id) async {
    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await appointmentRepo.acceptVitalSignAppointments(token: token, appointment_id:appointment_id);
    print('---------------------0000');
    print(apiResponse.response!.statusCode);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 400) {
      /*
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      for( var i = 0 ; i < pendingAppointments.length; i++ ) {
        if(pendingAppointments[i].id==appointment_id){
          pendingAppointments.removeAt(i);
        }
      }*/
      _responseModel = ResponseModelNurse(true, 'success');
      _isLoading = false;
      notifyListeners();
    } else {
      String _errorMessage = '000000';
      print(_errorMessage);
      _responseModel = ResponseModelNurse(false, _errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }
  Future<ResponseModelNurse> declineAppointment(BuildContext context,String token, String appointment_id) async {
    _isLoading = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await appointmentRepo.declineAppointments(token: token, appointment_id:appointment_id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      for( var i = 0 ; i < pendingAppointments.length; i++ ) {
        if(pendingAppointments[i].id==appointment_id){
          pendingAppointments.removeAt(i);
        }
      }
      _responseModel = ResponseModelNurse(true, 'success');
      _isLoading = false;
      notifyListeners();
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
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;


}
