class VerificationModelDoctor {
  late int id;
  String gender='';
  String language='';
  String otherLanguage='';
  String MCDNNumber='';
  String specialityCode='';
  String picture='';
  String companyOrganisation='';
  String workingFrom='';
  String workingTo='';
  String serviceFee='';
  String country='';
  String referedBy='';
  String degreeCert='';
  String medicalLicence='';
  String backingInformation='';
  String aboutMe='';

  VerificationModelDoctor({required this.id});

  VerificationModelDoctor.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }

  setPersonalInformation({gender, specialty, language, otherLanguage, MCDNNumberRegCert, specialityCode, passport}){
    this.gender = gender;
    this.language = language;
    this.MCDNNumber = MCDNNumberRegCert;
    this.specialityCode = specialityCode;
    this.otherLanguage = otherLanguage;
    this.picture = passport;

  }
  setBusinessInformation({country, state, referredBy, identityCard}){
    this.country = country;
    this.referedBy = referredBy;
  }
  setMedicalInformation({degreeCertificate, nigerianMedicalLicense, backingInformation}){
    this.degreeCert = degreeCertificate;
    this.medicalLicence = nigerianMedicalLicense;
    this.backingInformation = backingInformation;
  }
  setPersonal2Information({company, from, to}){
    this.companyOrganisation = company;
    this.workingFrom = from;
    this.workingTo = to;
  }

}
