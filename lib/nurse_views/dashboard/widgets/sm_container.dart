import 'package:flutter/material.dart';

SMConatiner({required title}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
        ),
    ),
  );
}