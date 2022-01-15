import 'package:doctor_v2/nurse_data/model/util_models.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'model/model.dart';
import 'model/verificationModel.dart';
import 'repository/state_repo.dart';
import 'repository/country_repo.dart';

class FormVerificationNurseProvider with ChangeNotifier {
  final genderController = TextEditingController();
  final specialityController = TextEditingController();
  final specialityCodeController = TextEditingController();
  final specialityCodeOtherController = TextEditingController();
  final languageSpokenController = TextEditingController();
  final mcdnNumberController = TextEditingController();
  final otherLanguageController = TextEditingController();
  final passportController = TextEditingController();
  XFile? passport;

  final countryController = TextEditingController();
  final stateController = TextEditingController();
  StateModelPAC? selectedState;
  final referredByController = TextEditingController();
  final idCardController = TextEditingController();
  XFile? idCard;
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();
  final bankCodeController = TextEditingController();

  final degreeCertificateController = TextEditingController();
  XFile? degreeCertificate;
  final nigeriaMedicalLicenseController = TextEditingController();
  XFile? nigeriaMedicalLicense;
  final specialistDocumentsController = TextEditingController();
  XFile? specialistDocuments;
  final aboutMeController = TextEditingController();

  final companyOrganisationController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();

  bool iCurrentlyWorkHere = false;

  bool isLoading = false;

  NurseType selectedNurseType = NurseType(id: '', title: '');

  List<String> countries = [];
  List<StateModelPAC> states = [StateModelPAC(id: -1, title: "Choose a state")];


  setGender(gender){
    genderController.text=gender;
    notifyListeners();
  }
  setCountry(country){
    countryController.text=country;
    notifyListeners();
  }
  selectState(StateModelPAC stateName){
    selectedState=stateName;
    stateController.text = stateName.title;
    notifyListeners();
  }
  setICurrentlyWorkHere(_iCurrentlyWorkHere){
    iCurrentlyWorkHere=_iCurrentlyWorkHere;
    notifyListeners();
  }
  setFromDate(_date){
    fromController.text=_date;
    notifyListeners();
  }
  setToDate(_date){
    toController.text=_date;
    notifyListeners();
  }
  selectSpecialty(NurseType specialty){
    specialityController.text=specialty.title;
    selectedNurseType = specialty;
    notifyListeners();
  }

  //set files
  takePassport() async {
    final ImagePicker _picker = ImagePicker();
    passport = await _picker.pickImage(source: ImageSource.camera);
    passportController.text=passport!.path;
    notifyListeners();
  }
  takeIDCard() async {
    final ImagePicker _picker = ImagePicker();
    idCard = await _picker.pickImage(source: ImageSource.gallery);
    idCardController.text=idCard!.path;
    notifyListeners();
  }
  takeDegreeCertificate() async {
    final ImagePicker _picker = ImagePicker();
    degreeCertificate = await _picker.pickImage(source: ImageSource.gallery);
    degreeCertificateController.text=degreeCertificate!.path;
    notifyListeners();
  }
  takeNigeriaMedicalLicense() async {
    final ImagePicker _picker = ImagePicker();
    nigeriaMedicalLicense = await _picker.pickImage(source: ImageSource.gallery);
    nigeriaMedicalLicenseController.text=nigeriaMedicalLicense!.path;
    notifyListeners();
  }
  takeSpecialistDocuments() async {
    final ImagePicker _picker = ImagePicker();
    specialistDocuments = await _picker.pickImage(source: ImageSource.gallery);
    specialistDocumentsController.text=specialistDocuments!.path;
    print('------------');
    print(specialistDocuments!.path);
    notifyListeners();
  }

  getAllStates() async {
    print('00000');
    if(states.isNotEmpty){
      isLoading=true;
      countries = [];
      List<String>? countriesResponse = await getCountries();
      countries.addAll(countriesResponse!);
      notifyListeners();
      states = [];
      List<StateModelPAC> response = await getState_v1();
      states = [StateModelPAC(id: -1, title: "Choose a state")];
      states.addAll(response);
      isLoading=false;
      notifyListeners();
    }
  }

  VerificationModel step1Verified(context){
    if(this.languageSpokenController.text.isEmpty){
      showCustomSnackBar('You have to enter language Spoken', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.mcdnNumberController.text.isEmpty){
      showCustomSnackBar('You have to enter MCDN', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    /*
    if(this.specialityCodeController.text.isEmpty){
      showCustomSnackBar('You have to enter speciality Code', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }*/
    if(this.passport==null){
      showCustomSnackBar('You have to upload your passport', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    return VerificationModel(verified: true, message: 'verified');
  }
  VerificationModel step2Verified(context){
    if(this.stateController.text.isEmpty){
      showCustomSnackBar('You have to select State', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.idCard==null){
      showCustomSnackBar('You have to upload your ID Card', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.accountNameController.text.isEmpty){
      showCustomSnackBar('You have to enter account name', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.accountNumberController.text.isEmpty){
      showCustomSnackBar('You have to enter account number', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.bankCodeController.text.isEmpty){
      showCustomSnackBar('You have to enter bank name', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    return VerificationModel(verified: true, message: 'verified');
  }
  VerificationModel step3Verified(context){
    if(this.aboutMeController.text.isEmpty){
      showCustomSnackBar('The about me can not be empty', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.degreeCertificate==null){
      showCustomSnackBar('You have to upload your Degree Certificate', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.nigeriaMedicalLicense==null){
      showCustomSnackBar('You have to upload your Nigeria Medical License', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    /*
    if(this.specialistDocuments==null){
      showCustomSnackBar('You have to upload your Specialist Supporting Documents', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    */
    return VerificationModel(verified: true, message: 'verified');
  }
  VerificationModel step4Verified(context){
    if(this.companyOrganisationController.text.isEmpty){
      showCustomSnackBar('The Company / Organisation can not be empty', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    if(this.fromController.text.isEmpty){
      showCustomSnackBar('From date can not be empty', context, isError: true);
      return VerificationModel(verified: false, message: '');
    }
    return VerificationModel(verified: true, message: 'verified');
  }

  Map<String, dynamic> getStep1(speciality){
    String specialityCode = '';
    if(this.specialityCodeController.text.isNotEmpty){
      specialityCode = this.specialityCodeController.text;
      if(this.specialityCodeOtherController.text.isNotEmpty){
        specialityCode = specialityCode+','+this.specialityCodeOtherController.text;
      }
    }
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.genderController.text.isEmpty?'male':this.genderController.text;
    data['speciality'] = this.specialityController.text.isEmpty?speciality.trim():this.specialityController.text.trim();
    data['speciality_code'] = specialityCode;//this.specialityCodeController.text.isEmpty?'0000':this.specialityCodeController.text;
    data['language'] = this.languageSpokenController.text;
    data['mcdn'] = this.mcdnNumberController.text;
    data['otherlanguage'] = this.otherLanguageController.text;
    data['refer'] = this.referredByController.text;
    return data;
  }
  Map<String, dynamic> getStep2(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.countryController.text.isEmpty?'Nigeria':this.countryController.text;
    data['state'] = this.stateController.text.isEmpty?'Abuja':this.stateController.text;
    data['refer'] = this.referredByController.text.isEmpty?'none':this.referredByController.text;
    data['account_number'] = this.accountNumberController.text.isEmpty?'none':this.accountNumberController.text;
    data['account_name'] = this.accountNameController.text.isEmpty?'none':this.accountNameController.text;
    data['bank_code'] = this.bankCodeController.text.isEmpty?'none':this.bankCodeController.text;
    return data;
  }
  Map<String, dynamic> getStep3(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.aboutMeController.text;
    return data;
  }
  Map<String, dynamic> getStep4(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    DateTime date = DateTime.now();
    List<String> datearray = date.toString().split(' ')[0].split('-');
    String dateStr = datearray[2]+'/'+datearray[1]+'/'+datearray[0];
    data['company'] = this.companyOrganisationController.text;
    data['from'] = this.fromController.text;
    data['to'] = this.toController.text.isEmpty?dateStr:this.toController.text;
    data['current'] = this.iCurrentlyWorkHere?'1':'0';
    return data;
  }
}