import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/wallet/bank_account.dart';
import 'package:flutter/material.dart';

class WalletSettings extends StatefulWidget {
  WalletSettings({Key? key}) : super(key: key);

  @override
  _WalletSettingsState createState() {
    return _WalletSettingsState();
  }
}

class _WalletSettingsState extends State<WalletSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      DarkBackGround(),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
            title: Text('Wallet Settings', style: TextStyle(color: Colors.white),),
            elevation: 0,
          ),
          body: ListView(children: [
            ListTile(
                title: Text('Bank Account', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.person, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BankAccountScreen()),
                );
              },
            ),
            /*
            ListTile(
              title: Text('Privacy', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.visibility, color: Colors.white,),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){},
            ),
            ListTile(
              title: Text('Security', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.lock, color: Colors.white,),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){
                //Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                //);
                //ForgetPasswordScreen
              },
            ),
            ListTile(
                title: Text('Ads', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.all_out_sharp, color: Colors.white,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
            ListTile(
              title: Text('Help', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.camera, color: Colors.white,),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){},
            ),
            ListTile(
              title: Text('About', style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.info, color: Colors.white,),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: (){
                //Navigator.push(
                 // context,
                 // MaterialPageRoute(builder: (context) => AboutScreen()),
                //);
              },
            ),
            */
          ]))
    ],);
  }
}