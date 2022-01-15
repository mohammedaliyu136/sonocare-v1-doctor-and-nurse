import 'package:flutter/material.dart';



LGConatiner({required heading, required body, bgColorTXT = '', required onTab}){
  var bgColor = Colors.white;
  if(bgColorTXT=='colored'){
    bgColor = Color.fromRGBO(78, 0, 118, 0.47);
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(children: [
        Expanded(
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
                    child: Text(heading, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black, letterSpacing: 1.12, height: 1.5),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(body, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, letterSpacing: 1.12, height: 1.5),),
                  ),
                  GestureDetector(
                    onTap: onTab,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset('assets/icons/right-arrow_icon.png'),
                    ),
                  )
                ],),
            ),
          ),
        )
      ],),
    ),
  );
}
