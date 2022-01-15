import 'package:doctor_v2/nurse_provider/lab_test_provider.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/textFieldNotStyled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sub_cat_lab_test_screen.dart';

class LabTestScreen extends StatelessWidget {
  LabTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        DarkBackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Lab Test'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Consumer<LabTestProvider>(
              builder: (context, labTestProvider, child) {
                if(labTestProvider.isLoadingMainList){
                  return Center(child: CircularProgressIndicator());
                }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    child: textFieldNotStyled(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Text('Categories', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: labTestProvider.labTests.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            labTestProvider.getSubLabTestCategory(labTestProvider.labTests[index].id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SubLabTestScreen(labTest: labTestProvider.labTests[index],)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Center(child: Text(labTestProvider.labTests[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ),
                ],
              );
            }
          ),
        )
      ],
    );
  }
}
