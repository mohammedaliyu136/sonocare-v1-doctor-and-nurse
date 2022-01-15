import 'package:flutter/material.dart';



LGConatiner({required heading, required body, bgColorTXT = '', imageUrl}){
  var bgColor = Colors.white.withOpacity(0.56);
  if(bgColorTXT=='colored'){
    bgColor = Color.fromRGBO(78, 0, 118, 0.47);
  }
  return Container(
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: Row(children: [
      Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Container(height: 120, width: 120, color: Colors.transparent, child: imageUrl!=null?Image.asset(imageUrl,):Text(''),),
          )),
      Expanded(
        flex: 8,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:14.0, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(heading, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(body, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset('assets/icons/right-arrow_icon.png'),
                )
              ],),
          ),
        ),
      )
    ],),
  );
}
