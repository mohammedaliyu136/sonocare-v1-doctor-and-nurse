import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_data/model/service_fee_model.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_provider/consultation_provider.dart';
import 'package:doctor_v2/nurse_provider/service_preference_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetServiceFeeScreen extends StatelessWidget {
  SetServiceFeeScreen({Key? key, required this.preference}) : super(key: key);
  String preference;
  final _consultationFeeController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(preference);
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Set Service Fees'),
          elevation: 0,
          leading: GestureDetector(
              onTap: ()=>Navigator.pop(context),//
              child: Image.asset('assets/icons/back-arrow_icon.png')),
        ),
        body: Consumer<NurseServicePreferenceProvider>(
            builder: (context, nurseServicePreferenceProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(preference, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                  SizedBox(height: 30,),
                  textField(hintText: 'Enter Fee here', label:'Set Fee', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _consultationFeeController, validator: (){},onChanged: (){},),
                  //if(preference!='Independent')SizedBox(height: 20,),
                  //if(preference!='Independent')textField(hintText: 'Enter Fee here', label:'Tariff Based', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _consultationFeeController, validator: (){},onChanged: (){},),
                  SizedBox(height: 10,),
                  if(nurseServicePreferenceProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                  if(!nurseServicePreferenceProvider.isLoading)Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(child: normalButton(
                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                          button_text: 'Done',
                          primaryColor: ColorResources.COLOR_WHITE,
                          fontSize: 16,
                          onTap: () async {
                            String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                            //token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc29ub2NhcmUuYXBwXC9hcGlcL2RvY3RvcmxvZ2luIiwiaWF0IjoxNjM2NjU2NjgzLCJleHAiOjIyMzY2NTY2ODMsIm5iZiI6MTYzNjY1NjY4MywianRpIjoidTgwdVJodURFOWZTdW9rdiIsInN1YiI6NDgsInBydiI6IjdmNzA2MmMzZDlkOTdhMjg3YjZkY2Y2NTkzNWFkNmRkZjJhNzI0N2YifQ.n4Y_JFoT3KgQtrrqIuztckXmbQ1xsl8gRGf5oEFXdN0';
                            await nurseServicePreferenceProvider.setServicePreference(1,_consultationFeeController.text,token).then((ResponseModelNurse response){
                              if(response.isSuccess){
                                showCustomSnackBar(response.message, context, isError: false);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashboardNurseScreen()),
                                );
                              }
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                ],),
            );
          }
        ),
      )
    ],);
  }
}
