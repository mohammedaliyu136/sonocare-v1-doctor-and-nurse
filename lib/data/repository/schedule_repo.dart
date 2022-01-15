
import 'dart:convert';
import 'dart:io';
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/scheduleModel.dart';
import 'package:doctor_v2/data/model/service_fee_model.dart';
import 'package:doctor_v2/data/model/signupModel.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleRepo {
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;

  ScheduleRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> getSchedule({required String token, day}) async {
    print(AppConstants.GET_SCHEDULE);
    Response response = await remoteClient.post(
      AppConstants.GET_SCHEDULE+token,
      data:ScheduleModel(date: '', id: day, time: '', day: '').toJsonn()//jsonDecode(json.encode(body))
    );
    print(response);
    print(response.statusCode);
    print('-------------------------');
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
  Future<ApiResponse> setSchedule({required String token, time, day, dates_id}) async {
    print(AppConstants.SET_SCHEDULE);
    Response response = await remoteClient.post(
      AppConstants.SET_SCHEDULE+token,
      data: {
        "dates_id":dates_id,
        "time":time,
        "day":day
      }
      //ScheduleModel(day: '', time: '', id: '', date: '').toJsonCreateSchedule(dates_id: 1, time: time, day: day),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['message']);
    }
  }
  Future<ApiResponse> updateSchedule({required ScheduleModel scheduleModel, required String token}) async {
    print(AppConstants.UPDATE_SCHEDULE);
    Response response = await remoteClient.post(
      AppConstants.UPDATE_SCHEDULE+token,
      data: scheduleModel.toJson(),
    );
    print(response.statusCode);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
  Future<ApiResponse> deleteSchedule({required ScheduleModel scheduleModel, required String token}) async {
    print(AppConstants.UPDATE_SCHEDULE);
    Response response = await remoteClient.post(
      AppConstants.DELETE_SCHEDULE+token,
      data: scheduleModel.toJson(),
    );
    print(response.statusCode);
    if(response.statusCode==200){
      return ApiResponse.withSuccess(response);
    }else{
      return ApiResponse.withError(jsonDecode(response.body)['error']);
    }
  }
}