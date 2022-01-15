class SignUpModelNurse {
  String firstName = '';
  String otherName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';
  String address = '';
  String password = '';
  String nurseType = '';
  String servicePref = '';
  String nurseService = '';
  String hospitalID = '';

  SignUpModelNurse({required this.firstName, required this.otherName, required this.lastName, required this.phoneNumber,
    required this.email, required this.address, required this.password, required this.nurseType, required this.nurseService,
    required this.servicePref, required this.hospitalID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['other_names'] = this.otherName;
    data['last_names'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['email'] = this.email;
    data['password'] = this.password;
    data['nurse_type'] = this.nurseType;
    data['service_preferences'] = servicePref;
    data['nurse_service'] = nurseService;
    data['hospital_id'] = hospitalID;
    return data;
  }
}
