import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  textField({ required this.hintText,  required this.label,  required this.icon, required this.controller, required this.validator, required this.onChanged, this.obscureText=false, this.enable=true});
  final TextEditingController controller;
  final Function() validator;
  bool obscureText = false;
  bool enable;
  String hintText = '';
  String label = '';
  Icon icon = Icon(Icons.ac_unit);
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
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
                padding: const EdgeInsets.all(12.0),
                child: icon,
              ),
              SizedBox(width: 1,child: Container(color: Colors.white,), height: 50,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label==''?'TEST':label, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                      TextFormField(
                        controller: controller,
                         validator: validator(),
                        enabled: enable,
                        obscureText: obscureText,
                        style: TextStyle(color: Colors.white.withOpacity(.6)),
                        decoration: InputDecoration(
                          //labelText: 'Enter your username',
                          hintStyle: TextStyle(
                            color: Colors.grey
                          ),
                          hintText: hintText!=''?hintText:'Enter your TEST',
                          contentPadding: EdgeInsets.symmetric(vertical: 5), //Change this value to custom as you like
                          isDense: true, // and add this line
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.none
                            ),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.none
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],),
            SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
          ],
    );
  }
}
