import 'package:doctor_v2/data/model/prescription_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/package/gender/view.dart';
import 'package:doctor_v2/provider/appointment_provider.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/provider/prescription_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrescriptionScreen extends StatefulWidget {
  String appointmentID;
  PrescriptionScreen({Key? key, required this.appointmentID}) : super(key: key);

  @override
  _PrescriptionScreenState createState() {
    return _PrescriptionScreenState();
  }
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final _patientNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _dateOfConsultationController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _prescriptionController = TextEditingController();
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
    DateTime date = DateTime.now();
    _dateOfConsultationController.text='${date.day<10?'0'+date.day.toString():date.day}/${date.month<10?'0'+date.month.toString():date.month}/${date.year}';
    return Stack(
      children: [
        BackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Prescription'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
                _patientNameController.text = appointmentProvider.patientModel.firstName+' '+appointmentProvider.patientModel.otherName+' '+appointmentProvider.patientModel.lastName;
                _ageController.text = (DateTime.now().year - int.parse(appointmentProvider.patientModel.dob.split('-')[2])).toString();
              return Consumer<PrescriptionProvider>(
                  builder: (context, prescriptionProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(children: [
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Patient name', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: _patientNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '',
                          contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('Age', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                            ),
                            TextField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '',
                                contentPadding:
                                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text('Sex', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                            ),
                            Stack(
                              children: [
                                TextField(
                                  //controller: _genderController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: '',
                                    contentPadding:
                                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: Container(color: Colors.transparent),
                                    items: ['Male','Female'].map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem, style: TextStyle(color: Colors.black),),
                                      );
                                    }).toList(),
                                    onChanged: (value){
                                      setState(() {
                                        _genderController.text=value!;
                                      });
                                    },
                                    value: _genderController.text.isEmpty?'Male':_genderController.text,
                                  ),
                                ),
                              ],
                            ),
                          ],),
                        ),
                      ],),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Date of Consultation', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                      TextField(
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        controller: _dateOfConsultationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '',
                          contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Diagnosis', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        controller: _diagnosisController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '',
                          contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Prescription', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                      TextField(
                        textInputAction: TextInputAction.done,
                        maxLines: 5,
                        controller: _prescriptionController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '',
                          contentPadding:
                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    SizedBox(height: 30,),
                      if(prescriptionProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                      if(!prescriptionProvider.isLoading)normalButton(
                      backgroundColor: ColorResources.COLOR_PURPLE_MID,
                      button_text: 'Submit',
                      primaryColor: ColorResources.COLOR_WHITE,
                      fontSize: 16, onTap: () {
                      String token = Provider.of<AuthProvider>(context, listen: false).token;
                        prescriptionProvider.setPrescription(
                            PrescriptionModel(
                                patientName: _patientNameController.text, dateOfConsultation: _dateOfConsultationController.text,
                                prescription: _prescriptionController.text, diagnosis: _diagnosisController.text,
                                age: _ageController.text.toString(), gender: _genderController.text.isEmpty?'male':_genderController.text.toLowerCase(), appointmentID: widget.appointmentID),
                            token).then((ResponseModel responseModel){
                              if(responseModel.isSuccess){
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }else{
                                showCustomSnackBar(responseModel.message, context, isError: true);
                              }

                        });
                    },
                    )
                    ],),
                  );
                }
              );
            }
          ),
        )
      ],
    );
  }
}