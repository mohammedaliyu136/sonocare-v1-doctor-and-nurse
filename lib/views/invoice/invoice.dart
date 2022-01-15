import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Padding(
        padding: const EdgeInsets.only(bottom:60.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
            title: Text('Invoice', style: TextStyle(color: Colors.white),),
            elevation: 0,
          ),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(100))
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                                SizedBox(width: 20,),
                                Text('Paid', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                      ],),
                    ),
                  ),
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(100))
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                                SizedBox(width: 20,),
                                Text('Paid', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                      ],),
                    ),
                  ),
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(100))
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Patient', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                                SizedBox(width: 20,),
                                Text('Paid', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text('26th May 2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                SizedBox(width: 30,),
                                Text('9:00 am', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ],)
                      ],),
                    ),
                  ),
                ),
              ],),
            ),
          ],),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PURPLE_DEEP,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(Icons.home, color: Colors.white,),
              ),
              SizedBox(width: 10,),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PURPLE_DEEP,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(Icons.chat, color: Colors.white,),
              ),
              SizedBox(width: 10,),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: ColorResources.COLOR_PURPLE_DEEP,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Icon(Icons.settings, color: Colors.white,),
              ),
            ],),
        ),
      )
    ],);
  }
}
