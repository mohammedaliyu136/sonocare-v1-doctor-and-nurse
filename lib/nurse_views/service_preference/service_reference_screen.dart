import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'set_service_fee_screen.dart';
import 'widgets/lg_container.dart';

class ServicePreferenceScreen extends StatelessWidget {
  ServicePreferenceScreen();

  @override
  Widget build(BuildContext context) {
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
          child: Column(children: [
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

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(child: normalButton(
                          backgroundColor: ColorResources.COLOR_PURPLE_MID,
                          button_text: 'Go To Dashboard',
                          primaryColor: ColorResources.COLOR_WHITE,
                          fontSize: 16,
                          onTap: (){
                            Navigator.pop(context);
                          },
                        )),
                      ],
                    ),
                  ),
                  */
                  Consumer<NurseAuthProvider>(
                      builder: (context, authProvider, child) {
                        if(authProvider.loadingNurseServices){
                          return Center(child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('Loading...', style: TextStyle(color: Colors.white, fontSize: 16),),
                          ));
                        }else{
                          return Column(
                            children: List<Widget>.generate(authProvider.nurseServicesList.length, (index) {
                              return service_fee_widget(
                                  onTab: ()=>Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SetServiceFeeScreen(preference: authProvider.nurseServicesList[index].title,)),),
                                  title: authProvider.nurseServicesList[index].title
                              );
                            }),
                          );
                        }
                    }
                  ),
                ],),
              ),
            )
          ],),
        ),
      )
    ],);
  }
}
