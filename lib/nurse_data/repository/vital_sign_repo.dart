import 'dart:io';
import 'dart:typed_data';
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/profile_model.dart';
import 'package:doctor_v2/nurse_data/model/vitalSignModel.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VitalSignRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  VitalSignRepo({required this.remoteClient, required this.sharedPreferences});


  Future<ApiResponse> getUserInfo(user_id) async {
    try {
      final response = await remoteClient.get('${AppConstants.CUSTOMER_INFO_URI_NURSE}?nurse_id=$user_id',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }

  Future<ApiResponse> updateVitalSign(String token, VitalSignModel vitalSignModel, ) async {

    //Map<String, String>
    /*
    var _fields = Map();
    _fields = {
      'id': userInfoModel.id, 'first_name': userInfoModel.firstName, 'last_name': userInfoModel.lastName,'other_name': userInfoModel.otherName, 'email':userInfoModel.email//'phone': userInfoModel.phone
    };
    */
    try {
      print(vitalSignModel.toJson());
      //?vitalsign_id=${vitalSignModel.vitalSignId}&blood_group=AA&temprature=${vitalSignModel.temperature}&pulse_rate=${vitalSignModel.pulseRate}&respiration=${vitalSignModel.respiration}&sp02=${vitalSignModel.sp02}&body_mass=${vitalSignModel.bodyMassIdex}
      final response = await remoteClient.post(
          AppConstants.UPDATE_VITAL_SIGN+'?token=$token',
          //'&blood_group=AA&temprature=${vitalSignModel.temperature}&pulse_rate=${vitalSignModel.pulseRate}&respiration=${vitalSignModel.respiration}&sp02=${vitalSignModel.sp02}&body_mass=${vitalSignModel.bodyMassIdex}',
        /*
          data: {
          "blood_group":vitalSignModel.bloodPressure,
          "temprature":vitalSignModel.temperature,
          "pulse_rate":vitalSignModel.pulseRate,
          "respiration":vitalSignModel.respiration,
          "vitalsign_id":26,//int.parse(vitalSignModel.vitalSignId),
          "sp02":vitalSignModel.sp02,
          "body_mass":vitalSignModel.bodyMassIdex
        }*/
        data: vitalSignModel.toJson()
      );//,data: _fields);
      print(response.statusCode);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e);
      return ApiResponse.withError('');
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

}