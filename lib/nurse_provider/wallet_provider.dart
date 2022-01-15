import 'dart:convert';

import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/account_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/transaction_model.dart';
import 'package:doctor_v2/nurse_data/repository/wallet_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NurseWalletProvider with ChangeNotifier{
  List<NurseTransactionModel> transactions = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> getTransactions(BuildContext context,String token) async {
    print('---------------------908');
    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    NurseWalletRepo walletRepo = NurseWalletRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ApiResponse apiResponse = await walletRepo.getTransactions(token: token);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      transactions = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        transactions.add(NurseTransactionModel.fromJson(responseBody[i]));
      }
      _responseModel = ResponseModel(true, 'success');
      _isLoading = false;
      notifyListeners();
    } else {
      String _errorMessage;
      print("_errorMessage");
      _responseModel = ResponseModel(false, "_errorMessage");
    }
    _responseModel = ResponseModel(false, 'error');
    _isLoading = false;
    notifyListeners();
    return _responseModel;
  }

  Future<ResponseModel> setAccount(String token, AccountInfoModel accountInfoModel) async {
    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    NurseWalletRepo walletRepo = NurseWalletRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ApiResponse apiResponse = await walletRepo.updateAccount(token: token, accountInfo: accountInfoModel);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      String responseBody = jsonDecode(apiResponse.response!.body)['message'];
      _responseModel = ResponseModel(true, responseBody);
      _isLoading = false;
      notifyListeners();
    } else {
      _responseModel = ResponseModel(false, 'error');
      _isLoading = false;
      notifyListeners();
    }
    return _responseModel;
  }

  Future<ResponseModel> withDrawFunds(String token, String amount) async {
    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    NurseWalletRepo walletRepo = NurseWalletRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);

    ApiResponse apiResponse = await walletRepo.withDrawFunds(token: token, amount: amount);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      String responseMessage = jsonDecode(apiResponse.response!.body)['message'];
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      transactions = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        transactions.add(NurseTransactionModel.fromJson(responseBody[i]));
      }
      _responseModel = ResponseModel(true, responseMessage);
      _isLoading = false;
      notifyListeners();
    } else {
      _responseModel = ResponseModel(false, 'error');
      _isLoading = false;
      notifyListeners();
    }
    return _responseModel;
  }
}