import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateRepo{
  final RemoteClient remoteClient;
  //final SharedPreferences sharedPreferences;
  StateRepo({required this.remoteClient});


  Future<ApiResponse> getStates() async {
    try {
      final response = await remoteClient.get(AppConstants.STATE_LIST_URI,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }
  Future<ApiResponse> getLGA(int stateID) async {
    try {
      final response = await remoteClient.post(AppConstants.LGA_LIST_URI,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('error');
    }
  }
}