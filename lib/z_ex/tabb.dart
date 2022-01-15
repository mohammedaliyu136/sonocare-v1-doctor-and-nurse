import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:flutter/material.dart';

class Tabb extends StatefulWidget {
  Tabb({Key? key}) : super(key: key);

  @override
  _TabbState createState() {
    return _TabbState();
  }
}

class _TabbState extends State<Tabb> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showCustomSnackBar(String message, GlobalKey<ScaffoldState> _scaffoldKey, {bool isError = true}) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        BackGround(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: index==0?GestureDetector(
            onTap: (){
              showCustomSnackBar('Welcome to the app', _scaffoldKey, isError: false);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green
              ),
              child: ImageIcon(
                AssetImage("assets/icons/appointment_icon.png"),
                color: Colors.red,
                size: 200,
              ),
            ),
          ):
                index==1?Center(child: Text('1', style: TextStyle(fontSize: 50, color: Colors.white),)):
                         Center(child: Text('2', style: TextStyle(fontSize: 50, color: Colors.white),)),

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.green,
            iconSize: 40,
            currentIndex: index,
            onTap: (current_index){
              setState(() {
                index=current_index;
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: index==0?
                     Image.asset("assets/icons/home_icon.png", height: 40, width: 40)
                    :Image.asset("assets/icons/home_icon_light.png", height: 40, width: 40),
                label: 'ss',
                backgroundColor: Colors.green
              ),
              BottomNavigationBarItem(
                icon: index==1?
                Image.asset("assets/icons/chat_icon.png", height: 40, width: 40)
                    :Image.asset("assets/icons/chat_icon_light.png", height: 40, width: 40),
                label: 'aa',
              ),
              BottomNavigationBarItem(
                icon: index==2?
                Image.asset("assets/icons/settings_icon.png", height: 40, width: 40)
                    :Image.asset("assets/icons/settings_icon_light.png", height: 40, width: 40),
                label: 'qq',
              ),
            ],
          ),
        ),
      ],
    );
  }
}