import 'package:doctor_v2/data/model/util_models.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/service_preference/service_reference_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'set_service_fee_screen.dart';
import 'widgets/lg_container.dart';
class ServicePreferenceListScreen extends StatefulWidget {
  ServicePreferenceListScreen({Key? key}) : super(key: key);

  @override
  _ServicePreferenceScreenState createState() {
    return _ServicePreferenceScreenState();
  }
}

class _ServicePreferenceScreenState extends State<ServicePreferenceListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ConsultationType selectedConsultationType = ConsultationType(id: '', title: '');
  final feeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Service Preference'),
          leading: GestureDetector(
              onTap: ()=>Navigator.pop(context),
              child: Image.asset('assets/icons/back-arrow_icon.png')),
          elevation: 0,
        ),
        body: SafeArea(
          child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                if(authProvider.loadingConsultationFee){
                  return Center(child: Text('Loading...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: ColorResources.COLOR_WHITE),),);
                }else {
                  return Column(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: ListView(children: List.generate(authProvider.consultationFeeList.length, (index) {
                          print(authProvider.consultationFeeList[index].servicesType);
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServicePreferenceScreen(consultationFee:authProvider.consultationFeeList[index])),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(authProvider.consultationFeeList[index].servicesType, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text("ID:${authProvider.consultationFeeList[index].id}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                            SizedBox(width: 20,),
                                            Text("₦${authProvider.consultationFeeList[index].price}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                          ],
                                        ),
                                      ],)
                                  ],),
                                ),
                              ),
                            ),
                          );
                        }),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(child: normalButton(
                            backgroundColor: ColorResources.COLOR_PURPLE_MID,
                            button_text: 'Set Consultation',
                            primaryColor: ColorResources.COLOR_WHITE,
                            fontSize: 16,
                            onTap: (){
                              //SetServiceFeeScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServicePreferenceScreen()),
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  ],);
                }
              }
          ),
        ),
      )
    ],);
  }
}
