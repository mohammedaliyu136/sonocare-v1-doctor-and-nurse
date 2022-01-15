import 'package:doctor_v2/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemoteClient {
  RemoteClient();
  String BASE_URL = AppConstants.BASE_URL;

  Future<http.Response> get(String uri,) async {
    var url = Uri.parse(BASE_URL+uri);
    var response = await http.get(url).timeout(Duration(seconds: 30));
    return response;
  }

  Future<http.Response> post(String uri, {data}) async {
    print(BASE_URL+uri);
    var url = Uri.parse(BASE_URL+uri);
    var response = await http.post(url, body: data).timeout(Duration(seconds: 30));
    return response;
  }

  Future<http.Response> put(String uri, {data}) async {
    var url = Uri.parse(BASE_URL+uri);
    var response = await http.put(url, body: data).timeout(Duration(seconds: 30));
    return response;
  }


}