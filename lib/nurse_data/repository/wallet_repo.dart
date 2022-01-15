//NurseWalletRepo
//WalletRepo
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/account_model.dart';
import 'package:doctor_v2/data/model/transaction_model.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NurseWalletRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  NurseWalletRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> getTransactions({String token = ''}) async {
    ///api/doctransactions
    print('---------------------908');
    try {
      final response = await remoteClient.get(AppConstants.GET_TRANSACTION_HISTORY+'?token=${token}');//,data: _fields);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(e.toString());
    }
  }
  Future<ApiResponse> updateAccount({String token = '',required AccountInfoModel accountInfo}) async {
    ///api/doctransactions
    print('---------------------908 nn');
    try {
      final response = await remoteClient.post(AppConstants.NURSE_UPDATE_ACCOUNT_INFO+'${token}', data: accountInfo.toJson());//,data: _fields);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(e.toString());
    }
  }

  Future<ApiResponse> withDrawFunds({String token = '',required String amount}) async {
    ///api/doctransactions
    print('---------------------909');
    try {
      final response = await remoteClient.post(AppConstants.NURSE_WITHDRAW_FUNDS+'${token}', data: {"amount":amount});//,data: _fields);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(e.toString());
    }
  }

}