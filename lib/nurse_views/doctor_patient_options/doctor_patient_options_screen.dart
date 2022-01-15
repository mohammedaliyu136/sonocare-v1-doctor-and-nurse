import 'package:doctor_v2/nurse_provider/appointment_provider.dart';
import 'package:doctor_v2/nurse_provider/lab_test_provider.dart';
import 'package:doctor_v2/nurse_views/lab_test/lab_test_screen.dart';
import 'package:doctor_v2/nurse_views/prescription/prescription_screen.dart';
import 'package:doctor_v2/nurse_views/profile_setup/profile_setup.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorPatientOptionsScreen extends StatelessWidget {
  DoctorPatientOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      DarkBackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: ()=>Navigator.pop(context),
              child: Image.asset('assets/icons/back-arrow_icon.png')),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileSetUPNurseScreen(upDateProfile:true)),
                  );
                },
                child: Container(
                  height: 55,
                  width: 57,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image:DecorationImage(
                        fit:BoxFit.fill,
                        image: AssetImage("assets/dummy/profile_dummy.png"),
                      )
                  ),
                ),
              ),
            )
          ],
        ),
        body:Consumer<AppointmentNurseProvider>(
            builder: (context, appointmentProvider, child) {
              return Column(children: [
                SizedBox(height: 30,),
                ListTile(
                  title: Text('Recommend Tests', style: TextStyle(color: Colors.white, fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                  onTap: (){
                    Provider.of<LabTestProvider>(context, listen: false).getLabTestCategory();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LabTestScreen()),
                    );
                  },
                ),
                SizedBox(height: 20,),
                ListTile(
                  title: Text('Write Prescriptions', style: TextStyle(color: Colors.white, fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrescriptionScreen(appointmentID: appointmentProvider.appointment!.id,)),
                    );
                  },
                ),
                SizedBox(height: 20,),
                ListTile(
                  title: Text('Write Medical Report', style: TextStyle(color: Colors.white, fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: (){},
                ),
                SizedBox(height: 20,),
                ListTile(
                  title: Text('Recommend Referral', style: TextStyle(color: Colors.white, fontSize: 20),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: (){},
                ),
              ],);
            }
        ),
      )
    ],);
  }
}
