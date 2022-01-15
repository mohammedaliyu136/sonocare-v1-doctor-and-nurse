import 'package:doctor_v2/package/provider/form_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderView extends StatefulWidget {
  String selectedName = '';
  bool profile = false;
  GenderView({Key? key, required this.selectedName, this.profile=false});

  @override
  _GenderViewState createState() {
    return _GenderViewState(this.selectedName);
  }
}

class _GenderViewState extends State<GenderView> {
  String var_selectedName = '';
  _GenderViewState(this.var_selectedName);
  List<String> _gender = ["Select gender"];
  String _selectedGender = "Select gender";


  @override
  void initState() {
    _gender = ['Male', 'Female'];
    if(var_selectedName!=''){
      print("------------------9009");
      setState(() {
        _selectedGender = var_selectedName;
      });
    }else{
      setState(() {
        _selectedGender = 'Male';
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
      _selectedGender = value;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        if(!widget.profile)Consumer<FormProvider>(
            builder: (context, genderProvider, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(color: Colors.transparent),
                items: _gender.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem, style: TextStyle(color: Colors.black),),
                  );
                }).toList(),
                onChanged: (value){
                  _onSelectedState(value!);
                  genderProvider.setGender(value);
                },
                value: _selectedGender,
              ),
            );
          }
        ),
        if(widget.profile)Padding(
          padding: const EdgeInsets.symmetric(horizontal:0.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.person, color: Colors.white,),
                  ),
                  SizedBox(width: 1,child: Container(color: Colors.white,), height: 64,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gender', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                          Consumer<FormProvider>(
                              builder: (context, genderProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                    underline: Container(color: Colors.transparent),
                                    items: _gender.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem, style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                    onChanged: (value){
                                      _onSelectedState(value!);
                                      genderProvider.setGender(value);
                                    },
                                    value: _selectedGender,
                                  ),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
            ],
          ),
        ),
      ],
    );
  }
}