import 'package:doctor_v2/nurse_package/model/specialty_model.dart';
import 'package:doctor_v2/nurse_package/provider/form_provider.dart';
import 'package:doctor_v2/nurse_package/repository/specialty_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecialtyView extends StatefulWidget {
  String selectedName = '';
  SpecialtyView({Key? key, required this.selectedName});

  @override
  _SpecialtyViewState createState() {
    return _SpecialtyViewState(this.selectedName);
  }
}

class _SpecialtyViewState extends State<SpecialtyView> {
  String var_selectedName = '';
  _SpecialtyViewState(this.var_selectedName);
  List<SpecialtyModel> _specialties = [];
  SpecialtyModel? _selectedSpecialty;// = SpecialtyModel(title: "Choose a Specialty", id: '');

  SpecialtyRepository repo = SpecialtyRepository();

  @override
  void initState() {
    _specialties = List.from(_specialties)..addAll(repo.getSpecialties());
    if(var_selectedName!=''){
      print("------------------9009");
      setState(() {
        //_selectedSpecialty = var_selectedName;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSelectedState(SpecialtyModel value) {
    setState(() {
      _selectedSpecialty = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<FormProviderNurse>(
        builder: (context, specialtyProvider, child) {
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
                          Text('Specialty', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                          DropdownButton<SpecialtyModel>(
                            isExpanded: true,
                            underline: Container(color: Colors.transparent),
                            items: _specialties.map((SpecialtyModel dropDownStringItem) {
                              return DropdownMenuItem<SpecialtyModel>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem.title, style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (value){
                              _onSelectedState(value!);
                              specialtyProvider.setSpecialty(value);
                              },
                              value: _selectedSpecialty?? _specialties[0],
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