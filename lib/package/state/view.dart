import 'package:doctor_v2/data/model/state_model.dart';
import 'package:doctor_v2/package/model/state_model.dart';
import 'package:doctor_v2/package/provider/form_provider.dart';
import 'package:doctor_v2/package/repository/state_repo.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateView extends StatefulWidget {
  int selectedState = -1;
  int selectedLGA = -1;
  StateView({Key? key, required this.selectedState, required this.selectedLGA});

  @override
  _StateViewState createState() {
    return _StateViewState(this.selectedState, this.selectedLGA);
  }
}

class _StateViewState extends State<StateView> {
  int var_selectedState = -1;
  int var_selectedLGA = -1;
  _StateViewState(this.var_selectedState, this.var_selectedLGA);
  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose ..";

  StateModelPAC sel_State = StateModelPAC(id: -1, title: "Choose a state");

  StateRepository repo = StateRepository();

  getAllStates() {
     //_states = List.from(_states)..addAll(repo.getState_v1());
  }

  @override
  void initState() {
    //repo.getState_v1();
    //print(repo.getStates());
    //_states = List.from(_states)..addAll(repo.getStates());
    //getAllStates();
    /*
    _states = List.from(_states)..addAll(repo.getState_v1());
    if(var_selectedState!=''){
      print("------------------9009");
      setState(() {
        _selectedState = var_selectedState;
        _lgas = List.from(_lgas)..addAll(repo.getLocalByState(_selectedState));
        _selectedLGA = var_selectedLGA;
      });
    }
    */
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose ..";
      _lgas = ["Choose .."];
      print('---------------');
      print(value);
      _selectedState = value;
      //_lgas = List.from(_lgas)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
    print('==============');
    print(value);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<FormProvider>(
        builder: (context, formProvider, child) {
          print('-----${formProvider.lgas.length}');
          print('-----${formProvider.lgas[0]}');
          print('---67--${formProvider.selectedLGA}');
          if(formProvider.stateLoading){
            return Text("Loading States...", style: TextStyle(color: Colors.white),);
          }
        return Column(children: [

          Padding(
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
                            Text('State', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),

                          DropdownButton<StateModelPAC>(
                              isExpanded: true,
                              dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                              underline: Container(color: Colors.transparent),
                              items: formProvider.states.map((StateModelPAC dropDownStringItem) {
                                return DropdownMenuItem<StateModelPAC>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem.title, style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (value) async {
                                formProvider.onSelectedState(value!);
                              },
                              value: formProvider.selectedState.id==-1?formProvider.states[0]:formProvider.selectedState,
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
          ),

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:0.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.location_on, color: Colors.white,),
                    ),
                    SizedBox(width: 1,child: Container(color: Colors.white,), height: 65,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LGA', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                            if(formProvider.lgaLoading)Text("Loading LGAs...", style: TextStyle(color: Colors.white),),
                            if(!formProvider.lgaLoading)DropdownButton<LgaModelPAC>(
                              isExpanded: true,
                              dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                              underline: Container(color: Colors.transparent),
                              items: formProvider.lgas.map((LgaModelPAC dropDownStringItem) {
                                return DropdownMenuItem<LgaModelPAC>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem.title, style: TextStyle(color: Colors.white),),
                                );
                              }).toList(),
                              onChanged: (value){
                                print("#########${value}");
                                formProvider.onSelectedLGA(value!);
                              },
                              value: formProvider.lgas.length==1?formProvider.lgas[0]:formProvider.selectedLGA,
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
          ),
        ],);
      }
    );
  }
}