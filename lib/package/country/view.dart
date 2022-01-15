import 'package:doctor_v2/package/provider/form_provider.dart';
import 'package:doctor_v2/package/repository/country_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryView extends StatefulWidget {
  String selectedName = '';
  CountryView({Key? key, required this.selectedName});

  @override
  _CountryViewState createState() {
    return _CountryViewState(this.selectedName);
  }
}

class _CountryViewState extends State<CountryView> {
  String var_selectedName = '';
  _CountryViewState(this.var_selectedName);
  List<String> _country = ["Choose a Country"];
  String _selectedCountry = "Choose a Country";

  CountryRepository repo = CountryRepository();

  @override
  void initState() {
    //_country = List.from(_country)..addAll(repo.getCountries()??null);
    if(var_selectedName!=''){
      print("------------------9009");
      setState(() {
        _selectedCountry = var_selectedName;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSelectedState(String value) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<FormProvider>(
        builder: (context, countryProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:0.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.location_on, color: Colors.white,),
                  ),
                  SizedBox(width: 1,child: Container(color: Colors.white,), height: 64,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Country', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                          DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(color: Colors.transparent),
                            items: _country.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem, style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (value){
                              _onSelectedState(value!);
                              countryProvider.setCountry(value);
                              },
                            value: _selectedCountry,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
            ],
          ),
        );
      }
    );
  }
}