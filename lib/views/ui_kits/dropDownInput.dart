import 'package:flutter/material.dart';



class dropDownInputXX extends StatefulWidget {
  dropDownInputXX({required this.icon, required this.label, required this.list, required this.dropDownValue, required this.hintText});
  Icon icon = Icon(Icons.ac_unit);
  String hintText = '';
  String label = '';
  List<String> list = [];
  String dropDownValue;

  @override
  _dropDownInputState createState() {
    return _dropDownInputState(icon:icon, label:label, list:list, dropDownValue:dropDownValue, hintText:hintText);
  }
}

class _dropDownInputState extends State<dropDownInputXX> {
  _dropDownInputState({required this.icon, required this.label, required this.list, required this.dropDownValue, required this.hintText});
  Icon icon = Icon(Icons.ac_unit);
  String label = '';
  List<String> list = [];
  List<DropdownMenuItem> ddMenuItem = [];
  String dropDownValue = '';
  String hintText = '';

  @override
  void initState() {
    setState(() {
      list.forEach((element) {
        ddMenuItem.add(DropdownMenuItem(
            value: element, child: Text("$element")));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> cityList = [
    'Ajman',
    'Al Ain',
    'Dubai',
    'Fujairah',
    'Ras Al Khaimah',
    'Sharjah',
    'Umm Al Quwain'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(list);

    return Column(
      children: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: icon,
          ),
          SizedBox(width: 1,child: Container(color: Colors.white,), height: 60,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,),
                  child: Text(label==''?'TEST':label, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                ),
                /*
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 0, top: 0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        //hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: hintText,
                        //fillColor: Colors.blue[200]
                    ),
                    value: dropDownValue,
                    /*
                    onChanged: (String Value) async {
                      dropDownValue_test = Value;
                    },
                    */
                      /*
                    items: list
                        .map((cityTitle) => DropdownMenuItem(
                        value: cityTitle, child: Text("$cityTitle")))
                        .toList(),
                    */
                    items: ddMenuItem, onChanged: (value) {  },
                  ),
                ),
                */
              ],
            ),
          ),
        ],),
        SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),


      ],
    );
  }
}