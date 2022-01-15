import 'dart:io';
import 'dart:typed_data';
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/profile_model.dart';
import 'package:doctor_v2/data/model/vitalSignModel.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabTestRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  LabTestRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> getLabTestCategory() async {
    try {
      final response = await remoteClient.get(AppConstants.LAB_TEST_CATEGORY);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('');
    }
  }
  Future<ApiResponse> getSubLabTestCategory(id) async {
    try {
      final response = await remoteClient.post(
          AppConstants.SUB_LAB_TEST_CATEGORY,
           data: {
             "category_id":id
           }
      );//,data: _fields);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('');
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

}