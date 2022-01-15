import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';

getState_v1() async {
  var url = Uri.parse('https://sonocare.app/api/getAllState');
  var response = await http.get(url);
  //var states = jsonDecode(response.body)['getAllState'].map((val)=>val['title']).toList();
  List<StateModelPAC> states = [];
  for (var i = 0; i < jsonDecode(response.body)['getAllState'].length; i++) {
    //StateModel.fromJson(jsonDecode(response.body)['getAllState'][i]);
    states.add(StateModelPAC.fromJson(jsonDecode(response.body)['getAllState'][i]));
  }
  return states;
}