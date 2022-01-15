import 'package:doctor_v2/views/message/chat_detail.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/textFieldNotStyled.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);
  int numOfMessages = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Message'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: textFieldNotStyled(),
              ),
              if(numOfMessages>0)Column(
                children: List.generate(numOfMessages, (index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatDetailScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  image:DecorationImage(
                                    fit:BoxFit.fill,
                                    image: AssetImage("assets/dummy/profile_dummy.png"),
                                  )
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dr. Prince David', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text('Operand of null-aware operation', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),),
                                  ],
                                ),
                              ],)
                          ],),
                        ),
                      ),
                    ),
                  );
                }),),
              if(numOfMessages==0)Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('You have no messages', style: TextStyle(color: Colors.white),),
                  )
                ],)
            ],),
          )
      ),
    ],);
  }
}
