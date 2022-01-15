import 'package:flutter/material.dart';

class textFieldNotStyled extends StatelessWidget {
  textFieldNotStyled();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: TextField(
        decoration: InputDecoration(
          //labelText: 'Enter your username',
          hintText: 'Search',
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
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
