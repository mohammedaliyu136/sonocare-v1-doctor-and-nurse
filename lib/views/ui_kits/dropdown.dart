import 'package:doctor_v2/data/model/state_model.dart';
import 'package:doctor_v2/provider/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class dropDownField extends StatelessWidget {
  dropDownField({required this.label,  required this.icon, required this.statesModel, required this.selected});
  final List<StateModel> statesModel;
  String hintText = '';
  String label = '';
  int selected;
  Icon icon = Icon(Icons.ac_unit);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<DropdownMenuItem<int>> columnList = [];
    for (var i = 0; i < 37; i++) {
      print(i);
      print(statesModel[i].name);
      columnList.add(DropdownMenuItem(
        child: new Text(statesModel[i].name!=null?statesModel[i].name:'', style: TextStyle(color: Colors.white),),
        value: i,//statesModel[i].id,
      ),);
    }
    print('------------');
    for(StateModel sm in statesModel) {
      print(sm.name);

    }
    print(columnList);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: icon,
            ),
            SizedBox(width: 1,child: Container(color: Colors.white,), height: 65,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label==''?'TEST':label, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<StateProvider>(
                              builder: (context, stateProvider, child) {
                                List<DropdownMenuItem<int>> columnListL = [];
                                for (var i = 0; i < 37; i++) {
                                  print(i);
                                  print(statesModel[i].name);
                                  columnList.add(DropdownMenuItem(
                                    child: new Text(stateProvider.states[i].name!=null?stateProvider.states[i].name:'', style: TextStyle(color: Colors.white),),
                                    value: i,//statesModel[i].id,
                                  ),);
                                }
                              return new DropdownButton(
                                value: stateProvider.selectedState!=null?stateProvider.selectedState:0,
                                items: columnListL,
                                onChanged: (int? value) {
                                  stateProvider.selectedState=value;
                                },
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],),
          SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
        ],
      ),
    );
  }
}
class dropDownField6 extends StatelessWidget {
  dropDownField6({required this.label,  required this.icon, required this.statesModel, required this.selected});
  final List<StateModel> statesModel;
  String hintText = '';
  String label = '';
  int selected;
  Icon icon = Icon(Icons.ac_unit);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<DropdownMenuItem<int>> columnList = [];
    for (var i = 0; i < 37; i++) {
      print(i);
      print(statesModel[i].name);
      columnList.add(DropdownMenuItem(
        child: new Text(statesModel[i].name!=null?statesModel[i].name:'', style: TextStyle(color: Colors.white),),
        value: i,//statesModel[i].id,
      ),);
    }
    print('------------');
    for(StateModel sm in statesModel) {
      print(sm.name);

    }
    print(columnList);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          /*
          Padding(
            padding: const EdgeInsets.only(left: 60.0, bottom: 0),
            child: Text('Enter your username'),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: TextField(
              decoration: InputDecoration(
                //labelText: 'Enter your username',
                focusedBorder: new UnderlineInputBorder(
                borderSide: BorderSide(
                color: Colors.black,
                    width: 1.0,
                    //style: BorderStyle.none
                ),
              ),
                enabledBorder: new UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                      //style: BorderStyle.none
                  ),
                ),
                prefixIcon: Container(
                  width: 50,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Color(0xFF272727),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+91',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          */
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: icon,
            ),
            SizedBox(width: 1,child: Container(color: Colors.white,), height: 65,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label==''?'TEST':label, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                    Row(
                      children: [
                        Expanded(
                          child: new DropdownButton(
                            value: selected,
                            items: columnList,
                            /*<DropdownMenuItem<int>>[
                              for(StateModel stateda in statesModel)
                                ...[
                                  DropdownMenuItem(
                                    child: new Text(stateda.name, style: TextStyle(color: Colors.white),),
                                    value: stateda.id,
                                  ),
                                ]
                           /*
                              new DropdownMenuItem(
                                child: new Text('Foo', style: TextStyle(color: Colors.white),),
                                value: 0,
                              ),
                              new DropdownMenuItem(
                                child: new Text('Bar', style: TextStyle(color: Colors.white),),
                                value: 42,
                              ),*/
                            ],*/
                            onChanged: (int? value) {
                              /*
                              setState(() {
                                _value = value!;
                              });
                              */
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],),
          SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
        ],
      ),
    );
  }
}
/*
class dropDownFieldLGA extends StatelessWidget {
  dropDownFieldLGA({required this.label,  required this.icon, required this.LGAsModel, required this.selected});
  final List<LGAModel> LGAsModel;
  String hintText = '';
  String label = '';
  int selected;
  Icon icon = Icon(Icons.ac_unit);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<DropdownMenuItem<int>> columnList = [];
    if(LGAsModel.length != 0){
      for (var i = 0; i < 37; i++) {
        print(i);
        print(LGAsModel[i].name);
        columnList.add(DropdownMenuItem(
          child: new Text(LGAsModel[i].name!=null?LGAsModel[i].name:'', style: TextStyle(color: Colors.white),),
          value: i,//statesModel[i].id,
        ),);
      }
    }
    print('------------');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          /*
          Padding(
            padding: const EdgeInsets.only(left: 60.0, bottom: 0),
            child: Text('Enter your username'),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: TextField(
              decoration: InputDecoration(
                //labelText: 'Enter your username',
                focusedBorder: new UnderlineInputBorder(
                borderSide: BorderSide(
                color: Colors.black,
                    width: 1.0,
                    //style: BorderStyle.none
                ),
              ),
                enabledBorder: new UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                      //style: BorderStyle.none
                  ),
                ),
                prefixIcon: Container(
                  width: 50,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Color(0xFF272727),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+91',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          */
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: icon,
            ),
            SizedBox(width: 1,child: Container(color: Colors.white,), height: 65,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label==''?'TEST':label, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                    Row(
                      children: [
                        Expanded(
                          child: new DropdownButton(
                            value: Provider.of<StateProvider>(context, listen: false).stateModel==null?0:Provider.of<StateProvider>(context, listen: false).stateModel!.id,
                            items: columnList,
                            /*<DropdownMenuItem<int>>[
                              for(StateModel stateda in statesModel)
                                ...[
                                  DropdownMenuItem(
                                    child: new Text(stateda.name, style: TextStyle(color: Colors.white),),
                                    value: stateda.id,
                                  ),
                                ]
                           /*
                              new DropdownMenuItem(
                                child: new Text('Foo', style: TextStyle(color: Colors.white),),
                                value: 0,
                              ),
                              new DropdownMenuItem(
                                child: new Text('Bar', style: TextStyle(color: Colors.white),),
                                value: 42,
                              ),*/
                            ],*/
                            onChanged: (int? value) {
                              if(value==null){

                              }else{
                                Provider.of<StateProvider>(context, listen: false).stateModel = Provider.of<StateProvider>(context, listen: false).states[value];
                                Provider.of<StateProvider>(context, listen: false).getLGAs(value);
                              }
                              /*
                              setState(() {
                                _value = value!;
                              });
                              */
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],),
          SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
        ],
      ),
    );
  }
}
*/
/*
class dropDownField2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
*/

/*
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100),
            child: Text(
              'KDTechs',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== State

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        value: _myState,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select State'),
                        onChanged: (int? newValue) {
                          setState(() {
                            _myState = newValue;
                            _getCitiesList();
                            print(_myState);
                          });
                        },
                        items: statesList?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'],
                          );
                        })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        value: _myCity,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select LGA'),
                        onChanged: (int? newValue) {
                          setState(() {
                            _myCity = newValue;
                            print(_myCity);
                          });
                        },
                        items: citiesList?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'],
                          );
                        })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API
  List statesList = [];
  int _myState = 0;

  String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
  Future<String> _getStateList() async {
    await http.post(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        statesList = data['state'];
      });
    });
  }

  // Get State information by API
  List citiesList = [];
  int _myCity=0;

  String cityInfoUrl =
      'http://cleanions.bestweb.my/api/location/get_city_by_state_id';
  Future<String> _getCitiesList() async {
    await http.post(cityInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
      "state_id": _myState,
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        citiesList = data['cities'];
      });
    });
  }
}
*/