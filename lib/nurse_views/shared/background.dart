import 'package:doctor_v2/nurse_utill/images.dart';
import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  BackGround();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:BoxDecoration(
                image:DecorationImage(
                  fit:BoxFit.cover,
                  image: AssetImage("assets/bg/bg_1.png"),
                )
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(78, 0, 118, 0.3),
        ),
        Column(children: [
          Spacer(),
          Row(
            children: [
              Image.asset(Images.scope),
            ],
          ),
        ],),
      ],
    );
  }
}

class DarkBackGround extends StatelessWidget {
  DarkBackGround();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:BoxDecoration(
                color: Color(0xFF4E0076)
              /*
                image:DecorationImage(
                  fit:BoxFit.cover,
                  image: AssetImage("assets/bg/dark_bg.png"),
                )*/
            ),
          ),
        ),
        Column(children: [
          Spacer(),
          Row(
            children: [
              Image.asset(Images.scope),
            ],
          ),
        ],),
      ],
    );
  }
}