import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:doctor_v2/nurse_data/data_source/api_response.dart';
import 'package:doctor_v2/nurse_data/data_source/remote.dart';
import 'package:doctor_v2/nurse_data/model/prescription_model.dart';
import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  PrescriptionRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> setPrescription(PrescriptionModel prescriptionModel, token) async {
    try {
      final response = await remoteClient.post(AppConstants.SET_PRESCRIPTION+token, data: prescriptionModel.toJson());//,data: _fields);
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