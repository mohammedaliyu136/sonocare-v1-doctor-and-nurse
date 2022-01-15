import 'package:doctor_v2/data/data_source/api_response.dart';
import 'package:doctor_v2/data/data_source/remote.dart';
import 'package:doctor_v2/data/repository/verification_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/src/streamed_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationProvider with ChangeNotifier {
  String token = "";
  bool isUploading = false;
  bool isUploadingPersonalInfo = false;
  bool isUploadingBusinessInfo = false;
  bool isUploadingMedicalInfo = false;
  bool isUploadingPersonalInfo2 = false;

  bool isDoneUploadingPersonalInfo = false;
  bool isDoneUploadingBusinessInfo = false;
  bool isDoneUploadingMedicalInfo = false;
  bool isDoneUploadingPersonalInfo2 = false;

  setToken(token){
    this.token=token;
    notifyListeners();
  }

  startUpload({required Map<String, dynamic> step1,required Map<String, dynamic> step2,required Map<String, dynamic> step3,required Map<String, dynamic> step4, passport, idCard, degreeCertificate, nigerianMedicalCertificate, specialistDoc}) async {
    isUploadingPersonalInfo = false;
    isUploadingBusinessInfo = false;
    isUploadingMedicalInfo = false;
    isUploadingPersonalInfo2 = false;

    isDoneUploadingPersonalInfo = false;
    isDoneUploadingBusinessInfo = false;
    isDoneUploadingMedicalInfo = false;
    isDoneUploadingPersonalInfo2 = false;
    this.token=token;
    await uploadPersonalInfo(step1, passport);
    await uploadBusinessInfo(step2, idCard);
    await uploadMedicalInfo(step3, degreeCertificate, nigerianMedicalCertificate, specialistDoc);
    await uploadPersonalInfo2(step4);
    if(isDoneUploadingBusinessInfo&&isDoneUploadingBusinessInfo&&isDoneUploadingMedicalInfo&&isDoneUploadingPersonalInfo2){
      return true;
    }else{
      return false;
    }
  }

  uploadPersonalInfo(Map<String, dynamic> step, passport) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    VerificationRepo verificationRepo = VerificationRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    isUploading = true;
    isUploadingPersonalInfo=true;
    notifyListeners();
    String token = this.token;
    StreamedResponse response = await verificationRepo.personalInformationVerification(step, passport, token);
    if(response.statusCode==200){
      isUploadingPersonalInfo=false;
      isDoneUploadingPersonalInfo=true;
    }else{

    }
    //await Future.delayed(Duration(seconds: 3));
    isUploadingPersonalInfo=false;
    isDoneUploadingPersonalInfo=true;
    notifyListeners();
  }
  uploadBusinessInfo(Map<String, dynamic> step, idCard) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    VerificationRepo verificationRepo = VerificationRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    isUploadingBusinessInfo=true;
    notifyListeners();
    String token = this.token;
    StreamedResponse response = await verificationRepo.businessInformationVerification(step, idCard, token);
    if(response.statusCode==200){
      isUploadingBusinessInfo=false;
      isDoneUploadingBusinessInfo=true;
    }else{

    }
    //await Future.delayed(Duration(seconds: 3));
    isUploadingBusinessInfo=false;
    isDoneUploadingBusinessInfo=true;
    notifyListeners();
  }
  uploadMedicalInfo(Map<String, dynamic> step, degreeCertificate, nigerianMedicalCertificate, specialistDoc) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    VerificationRepo verificationRepo = VerificationRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    isUploadingMedicalInfo=true;
    notifyListeners();
    StreamedResponse response = await verificationRepo.medicalInformationVerification(step, degreeCertificate, nigerianMedicalCertificate, specialistDoc, token);
    if(response.statusCode==200){
      isUploadingMedicalInfo=false;
      isDoneUploadingMedicalInfo = true;
    }else{

    }
    await Future.delayed(Duration(seconds: 3));
    isUploadingMedicalInfo=false;
    isDoneUploadingMedicalInfo = true;
    notifyListeners();
  }
  uploadPersonalInfo2(Map<String, dynamic> step) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    RemoteClient remoteClient = RemoteClient();
    VerificationRepo verificationRepo = VerificationRepo(remoteClient: remoteClient, sharedPreferences: sharedPreferences);
    isUploadingPersonalInfo2=true;
    notifyListeners();
    StreamedResponse response = await verificationRepo.professionalInformationVerification(step, token);
    if(response.statusCode==200){
      isUploadingPersonalInfo2=false;
      isDoneUploadingPersonalInfo2 = true;
    }else{

    }
    await Future.delayed(Duration(seconds: 3));
    isUploadingPersonalInfo2=false;
    isDoneUploadingPersonalInfo2 = true;
    isUploading = false;
    notifyListeners();
  }
}