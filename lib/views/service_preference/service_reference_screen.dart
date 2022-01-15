import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/data/model/util_models.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'set_service_fee_screen.dart';
import 'widgets/lg_container.dart';
class ServicePreferenceScreen extends StatefulWidget {
  ConsultationFee? consultationFee;
  ServicePreferenceScreen({Key? key, this.consultationFee}) : super(key: key);

  @override
  _ServicePreferenceScreenState createState() {
    return _ServicePreferenceScreenState();
  }
}

class _ServicePreferenceScreenState extends State<ServicePreferenceScreen> {
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
    if(widget.consultationFee!=null){
      setState(() {
        feeController.text=widget.consultationFee!.price;
      });
    }
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
              return Column(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Text('Set Fee and Service Preference', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 1.12, height: 1.5),),
                      ),
                      //SetServiceFeeScreen
                      /*
                      GestureDetector(
                        child: LGConatiner(heading: 'Independent', body: 'Decide your consultation fees and consult only with patient willing to pay for your services',
                            onTab: ()=>Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: 'Independent',)),) ),
                        onTap: ()=>Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: 'Independent',)),),),
                      GestureDetector(
                        child: LGConatiner(heading: 'Tariff Based', body: 'Consult with patients using sonocare subscription plans only',
                            onTab: ()=>Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: 'Tariff Based',)),)
                        ),
                        onTap: ()=>Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: 'Tariff Based',)),),),
                      GestureDetector(
                        child: LGConatiner(heading: 'Combined', body: 'See both PAYGO patients and subscription based patients',
                            onTab: ()=>Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: 'Combined',)),)
                        ),
                        onTap: ()=>Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: 'Combined',)),),),
                      */
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(Icons.person, color: Colors.transparent,),
                                ),
                                SizedBox(width: 1,child: Container(color: Colors.white,), height: 64,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0, bottom: 0),
                                    child: Stack(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Consultation', textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                                        if(!authProvider.loadingConsultationType)Padding(
                                          padding: const EdgeInsets.only(top:10.0),
                                          child: DropdownButton<ConsultationType>(
                                            isExpanded: true,
                                            dropdownColor: ColorResources.COLOR_PURPLE_DEEP,
                                            underline: Container(color: Colors.transparent),
                                            items: authProvider.consultationTypeList.map((ConsultationType consultationType) {
                                              return DropdownMenuItem<ConsultationType>(
                                                value: consultationType,
                                                child: Text(consultationType.title.trim(), style: TextStyle(color: Colors.white),),
                                              );
                                            }).toList(),
                                            onChanged: (value){
                                              setState(() {
                                                selectedConsultationType = value!;
                                              });
                                            },
                                            //value: formVerificationProvider.selectedNurseType.id,
                                            //value: formVerificationProvider.selectedDoctorType.id==''?authProvider.doctorTypeList[0]:formVerificationProvider.selectedDoctorType,
                                            value: selectedConsultationType.id==''?authProvider.consultationTypeList[0]:selectedConsultationType,
                                            //value: authProvider.doctorTypeList[0],
                                          ),
                                        ),
                                        if(authProvider.loadingConsultationType)Padding(
                                          padding: const EdgeInsets.only(top:30.0),
                                          child: Row(children: [Text('Loading Consultation Type', style: TextStyle(color: ColorResources.COLOR_WHITE),),],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width,child: Container(color: Colors.white,), height: 1,),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      textField(label: 'Fee', icon: Icon(Icons.account_circle_outlined, color: Colors.transparent,), hintText: 'Enter Consultation Fee', controller: feeController, validator: (){}, onChanged: (){}),


                      if(authProvider.loadingConsultationFee)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                      if(!authProvider.loadingConsultationFee)Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(child: normalButton(
                              backgroundColor: ColorResources.COLOR_PURPLE_MID,
                              button_text: 'Save',
                              primaryColor: ColorResources.COLOR_WHITE,
                              fontSize: 16,
                              onTap: (){
                                String token = Provider.of<AuthProvider>(context, listen: false).token;
                                ConsultationFee consultation = ConsultationFee(id: '', servicesType: selectedConsultationType.id==''?authProvider.consultationTypeList[0].title:selectedConsultationType.title, price: feeController.text);
                                authProvider.setConsultationFee(token, consultation).then((ResponseModel responseModel){
                                  if(responseModel.isSuccess){
                                    String token = Provider.of<AuthProvider>(context, listen: false).token;
                                    Provider.of<AuthProvider>(context, listen: false).getConsultationFee(token);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            )),
                          ],
                        ),
                      ),

                    ],),
                  ),
                )
              ],);
            }
          ),
        ),
      )
    ],);
  }
}
