import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../form_verification_provider.dart';

class Step03 extends StatelessWidget {
  Step03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<FormVerificationProvider>(
        builder: (context, formVerificationProvider, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 10.0, bottom: 20.0),
            child: Text('Medical Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
          ),
          GestureDetector(
              onTap: ()=>formVerificationProvider.takeDegreeCertificate(),
              child: textField(label: 'Degree Certificate', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select Degree Certificate', controller: formVerificationProvider.degreeCertificateController, validator: (){}, onChanged: (){}, enable: false,)),
          SizedBox(height: 15,),
          GestureDetector(
              onTap: ()=>formVerificationProvider.takeNigeriaMedicalLicense(),
              child: textField(label: ' Nigeria Medical License', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select Nigeria Medical License', controller: formVerificationProvider.nigeriaMedicalLicenseController, validator: (){}, onChanged: (){}, enable: false,)),
          SizedBox(height: 15,),
          GestureDetector(
              onTap: ()=>formVerificationProvider.takeSpecialistDocuments(),
              child: textField(label: 'Specialist Supporting Documents', icon: Icon(Icons.upload_rounded, color: Colors.white,), hintText: 'Select Specialist Supporting Documents', controller: formVerificationProvider.specialistDocumentsController, validator: (){}, onChanged: (){}, enable: false,)),
          SizedBox(height: 15,),
          TextField(
            controller: formVerificationProvider.aboutMeController,
            maxLines: 6,

            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'About me',
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.1),
              ),

            ),
          ),
        ],);
      }
    );
  }
}
