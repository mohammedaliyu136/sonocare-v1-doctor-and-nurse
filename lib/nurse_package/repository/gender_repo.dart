
import 'package:doctor_v2/nurse_package/model/country_model.dart';

class CountryRepository{
  List<Map<String, dynamic>> _countries = [
    {"name": 'Male', "code": 'm'},
    {"name": 'Female', "code": 'f'},
  ];

  List<Map<String, dynamic>> getAll() => _countries;

  List<String>? getCountries() => _countries
      .map((map) => CountryModel.fromJson(map))
      .map((item) => item.name)
      .toList();
}