// ServicePreferenceRepo
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePreferenceRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  ServicePreferenceRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> setServiceFee(int serviceID, String serviceFee, token) async {
    try {
      final response = await remoteClient.post(
          AppConstants.SET_SERVICE_FEE_NURSE+token,
          data: {
            "fee":serviceFee
          }
      );//,data: _fields);
      print('-----------------0');
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('');
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

}