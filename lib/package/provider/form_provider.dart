import 'dart:convert';
import 'dart:io';

import 'package:doctor_v2/package/model/specialty_model.dart';
import 'package:doctor_v2/package/model/state_model.dart';
import 'package:doctor_v2/package/repository/state_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormProvider with ChangeNotifier {
  StateRepository repo = StateRepository();
  String? gender;
  String? country;
  String? state;
  String? lga;
  SpecialtyModel? specialty;

  String? referredBy;

  List<StateModelPAC> get states => _states;
  List<LgaModelPAC> get lgas => _lgas;
  StateModelPAC get selectedState => _selectedState;
  LgaModelPAC get selectedLGA => _selectedLGA;

  bool stateLoading = false;
  bool lgaLoading = false;
  List<StateModelPAC> _states = [StateModelPAC(id: -1, title: "Choose a state")];
  List<LgaModelPAC> _lgas = [LgaModelPAC(title: "Choose ..", id: -1)];//[LgaModelPAC(title: "Choose ..", id: -1)];
  StateModelPAC _selectedState = StateModelPAC(id: -1, title: "Choose a state");
  LgaModelPAC _selectedLGA = LgaModelPAC(title: "Choose ..", id: -1);

  StateModelPAC? selectedState2;

  getStates({selectedState=-1, selectedLGA=-1}) async {
    stateLoading =true;
    if(_states.length<2){
      List<StateModelPAC> response = await repo.getState_v1();
      print(response);
      _states=[StateModelPAC(id: -1, title: "Choose a state")];
      _states = List.from(_states)..addAll(response);
      if(selectedState!=-1){
        for( var i = 0 ; i < _states.length; i++ ) {
          if(_states[i].id==_selectedState){
            _selectedState = _states[i];
            List<LgaModelPAC> response = await repo.getLGA_v1(_states[i].id);
            _lgas=[LgaModelPAC(title: "Choose ..", id: -1)];
            _lgas = List.from(_lgas)..addAll(response);
            print('----56-${_lgas.length}');
          }
        }
      }
      if(selectedLGA!=-1){
        print('----56-${_lgas.length}');
        for( var i = 0 ; i < _lgas.length; i++ ) {
          if(_lgas[i].id==selectedLGA){
            _selectedLGA = _lgas[i];
            print('----56-${_selectedLGA.title}');
          }
        }
      }
    }
    if(selectedState>-1){
      _selectedState = _states[selectedState];
      print('----------------');
      print(_selectedState);
    }
    stateLoading =false;
    notifyListeners();
  }

  onSelectedState(StateModelPAC stateModelPAC,) async {
    //_lgas = [LgaModelPAC(title: "Choose ..", id: -1)];
    _selectedState = stateModelPAC;
    lgaLoading=true;
    notifyListeners();
    List<LgaModelPAC> response = await repo.getLGA_v1(stateModelPAC.id);
    _lgas=[LgaModelPAC(title: "Choose ..", id: -1)];
    _lgas = List.from(_lgas)..addAll(response);
    if(_lgas.isNotEmpty){
      _selectedLGA = _lgas[0];
    }

    lgaLoading=false;
    notifyListeners();
  }

  selectState(StateModelPAC stateName){
    selectedState2 = stateName;
    notifyListeners();
  }

  onSelectedLGA(LgaModelPAC lgaModelPAC) {
    //setState(() => _selectedLGA = value);
    _selectedLGA = lgaModelPAC;
    notifyListeners();
  }

  setReferredBy(referred){
    this.referredBy=referredBy;
    notifyListeners();
  }
  setGender(gender){
    this.gender = gender;
    notifyListeners();
  }
  setCountry(country){
    this.country = country;
    notifyListeners();
  }
  setState(state){
    this.state = state;
    notifyListeners();
  }
  setLGA(lga){
    this.lga = lga;
    notifyListeners();
  }
  setSpecialty(specialty){
    this.specialty = specialty;
    notifyListeners();
  }

}
