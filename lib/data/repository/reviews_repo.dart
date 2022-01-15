//ReviewsRepo
import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewsRepo{
  final RemoteClient remoteClient;
  final SharedPreferences sharedPreferences;
  ReviewsRepo({required this.remoteClient, required this.sharedPreferences});

  Future<ApiResponse> getReviews({token, account}) async {
    try {
      //String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc29ub2NhcmUuYXBwXC9hcGlcL2RvY3RvcmxvZ2luIiwiaWF0IjoxNjQwMjQxNjI5LCJleHAiOjIyNDAyNDE2MjksIm5iZiI6MTY0MDI0MTYyOSwianRpIjoiOWdDcE4xV3JpaHh4ZlFRSCIsInN1YiI6NDgsInBydiI6IjdmNzA2MmMzZDlkOTdhMjg3YjZkY2Y2NTkzNWFkNmRkZjJhNzI0N2YifQ.Vi7yMFNiyXH2avp7tHTYVSHAZye9Z5gVKSIAKp3mmJk';
      //String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc29ub2NhcmUuYXBwXC9hcGlcL251cnNlbG9naW4iLCJpYXQiOjE2NDAxMDEwNzgsImV4cCI6MjI0MDEwMTA3OCwibmJmIjoxNjQwMTAxMDc4LCJqdGkiOiJZY3lNZlI1Q1FnOFVDbzhkIiwic3ViIjo1NCwicHJ2IjoiY2ExMmUyYTU0YWUwNjE2NjU2MTliODRkNGFlZDBiNjZhNjQ0MWEyOCJ9.Sz4EhwerIz28tLEp0Jhyt5kmCVDSXiLgHvJ6XhN6qD4';
      String url = '';
      if(account == 'doctor'){
        url = AppConstants.DOCTOR_GET_REVIEWS+token;
      }else{
        url = AppConstants.NURSE_GET_REVIEWS+token;
      }
      print(account);
      print(url);
      final response = await remoteClient.get(url);
      print(response.body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('');
    }
  }

}