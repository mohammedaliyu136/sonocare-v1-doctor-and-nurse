import 'dart:convert';
import 'dart:io';

import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/appointment_model.dart';
import 'package:doctor_v2/nurse_data/model/profile_model.dart';
import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/scheduleModel.dart';
import 'package:doctor_v2/nurse_data/model/service_fee_model.dart';
import 'package:doctor_v2/nurse_data/model/userModel.dart';
import 'package:doctor_v2/nurse_data/model/vital_sign_model.dart';
import 'package:doctor_v2/nurse_data/repository/appointment_repo.dart';
import 'package:doctor_v2/nurse_data/repository/consultation_repo.dart';
import 'package:doctor_v2/nurse_data/repository/profile_repo.dart';
import 'package:doctor_v2/nurse_data/repository/schedule_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleProvider with ChangeNotifier {

  late ScheduleRepo scheduleRepo;
  List<ScheduleModel> _schedules = [];
  List<ScheduleModel> _schedulesOriginal = [];
  int _selectedWeekDayIndex = 0;
  get selectedWeekDayIndex => _selectedWeekDayIndex;

  String _morningEvening = "morning";
  get morningEvening => _morningEvening;

  String _dateId = '1';
  get dateId => _dateId;

  List<ScheduleModel> get schedules => _schedules;

  initialization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    this.scheduleRepo = ScheduleRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
  }

  ScheduleProvider(){
    initialization();
  }
  filterSchedules(day){
    print(day);
    print(_schedulesOriginal.length);
    print(_schedules.length);
    _schedules=[];
    for( var i = 0 ; i < _schedulesOriginal.length; i++ ) {
      if(day==_schedulesOriginal[i].day.toLowerCase()){
        _schedules.add(_schedulesOriginal[i]);
      }
    }
    _morningEvening=day.toLowerCase();
    notifyListeners();
  }
  Future<ResponseModelNurse> getSchedules(BuildContext context,String token, {day='1', index=0}) async {
    _isLoading = true;
    _morningEvening = 'morning';
    _selectedWeekDayIndex=index;
    _dateId=day;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    ScheduleRepo scheduleRepoo = ScheduleRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await scheduleRepoo.getSchedule(token: token, day: day);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      print(apiResponse.response!.body);
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      print(responseBody);
      _schedules = [];
      _schedulesOriginal = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        ScheduleModel schedule = ScheduleModel(
            date: responseBody[i]['date'], day: responseBody[i]['day'],
            time: responseBody[i]['time'], id: responseBody[i]['id']);

        _schedulesOriginal.add(schedule);

        print(schedule.day);
        if('morning'==schedule.day.toLowerCase()){
          _schedules.add(schedule);
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

  Future<ResponseModelNurse> createSchedule(BuildContext context,String token, time, day) async {
    _isLoadingSetTime = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await scheduleRepo.setSchedule(token: token, time:time, day:day, dates_id:_dateId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      _responseModel = ResponseModelNurse(true, 'success');
      _schedules.add(ScheduleModel(
          date: '12-12-2021', day: day,
          time: time, id: '1'));
      notifyListeners();
      _isLoadingSetTime = false;
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
    _isLoadingSetTime = false;
    notifyListeners();
    return _responseModel;
  }
  Future<ResponseModelNurse> deleteSchedule(BuildContext context,String token, ScheduleModel scheduleModel) async {
    _isLoadingSetTime = true;
    notifyListeners();
    ResponseModelNurse _responseModel;
    ApiResponse apiResponse = await scheduleRepo.deleteSchedule(token: token, scheduleModel:scheduleModel);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      _responseModel = ResponseModelNurse(true, 'success');
      notifyListeners();
      _isLoadingSetTime = false;
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
    _isLoadingSetTime = false;
    notifyListeners();
    return _responseModel;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isLoadingSetTime = false;
  bool get isLoadingSetTime => _isLoadingSetTime;


}
