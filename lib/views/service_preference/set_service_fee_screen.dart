import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/service_fee_model.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/provider/consultation_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
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
              onTap: ()=>Navigator.pop(context),
              child: Image.asset('assets/icons/back-arrow_icon.png')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Consumer<ConsultationProvider>(
              builder: (context, consultationProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(preference, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                  SizedBox(height: 30,),
                  textField(hintText: 'Enter Fee here', label:'Set Consultation Fee', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _consultationFeeController, validator: (){},onChanged: (){},),
                  if(preference!='Independent')SizedBox(height: 20,),
                  if(preference!='Independent')textField(hintText: 'Enter Fee here', label:'Tariff Based', icon: Icon(Icons.account_circle_outlined, color: Colors.white,), controller: _consultationFeeController, validator: (){},onChanged: (){},),
                  SizedBox(height: 10,),
                  if(_isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                  if(!_isLoading)Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(child: normalButton(
                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                          button_text: 'Done',
                          primaryColor: ColorResources.COLOR_WHITE,
                          fontSize: 16,
                          onTap: (){
                            if(_consultationFeeController.text.isEmpty){
                              showCustomSnackBar('Please enter consultation fee', context, isError: true);
                            }else{
                              String token = Provider.of<AuthProvider>(context, listen: false).token;
                              ServiceFeeModel serviceFeeModel = ServiceFeeModel(type: preference, consultationFee: double.parse(_consultationFeeController.text),);
                              consultationProvider.setConsultationFee(context, token, serviceFeeModel).then((ResponseModel response){
                                if(response.isSuccess){
                                  showCustomSnackBar(response.message, context, isError: false);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                                  );
                                }else{
                                  showCustomSnackBar(response.message, context, isError: true);
                                }
                              });
                            }
                          },
                        )),
                      ],
                    ),
                  ),
              ],);
            }
          ),
        ),
      )
    ],);
  }
}
