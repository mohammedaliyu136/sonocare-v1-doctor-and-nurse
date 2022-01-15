//LabTestProvider

import 'dart:convert';

import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/model/lab_test_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/review_model.dart';
import 'package:doctor_v2/data/repository/lab_test_repo.dart';
import 'package:doctor_v2/data/repository/reviews_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewsProvider with ChangeNotifier {

  late ReviewsRepo reviewsRepo;

  List<ReviewModel> reviews = [];


  bool _isLoadingReviews = false;

  bool get isLoadingReviews => _isLoadingReviews;

  int totalReviews = 0;
  double totalRating = 0.0;

  Future<ResponseModel> getReviews({token, account}) async {
    double singleRatingComp = 0.0;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    ReviewsRepo reviewsRepo = ReviewsRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    _isLoadingReviews = true;
    notifyListeners();
    ResponseModel _responseModel;

    ApiResponse apiResponse = await reviewsRepo.getReviews(token:token, account:account);
    _isLoadingReviews = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var responseBody = jsonDecode(apiResponse.response!.body)['data'];
      print(responseBody.length);
      totalReviews = responseBody.length;
      reviews = [];
      for( var i = 0 ; i < responseBody.length; i++ ) {
        singleRatingComp += double.parse(responseBody[i]['rating']);
        reviews.add(ReviewModel.fromJson(responseBody[i]));
      }
      totalRating = singleRatingComp/totalReviews;
      _responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      //_loginErrorMessage = errorMessage;
      _responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return _responseModel;
  }
}