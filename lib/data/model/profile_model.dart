class ProfileDoctorModel {
  int id = 0;
  String firstName = '';
  String otherName = '';
  String lastName = '';
  String address = '';

  String email = '';
  String phoneNumber = '';

  int stateID = 0;
  int lgaID = 0;
  String gender = '';
  String language = '';

  ProfileDoctorModel({
    required this.firstName,
    required this.otherName,
    required this.lastName,
    required this.address,

    required this.stateID,
    required this.lgaID,
    required this.gender,
    //required this.language,

    required this.id,
  });

  ProfileDoctorModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    otherName = json['other_name'];
    lastName = json['last_name'];
    address = json['address'];

    stateID = json['state_id'];
    lgaID = json['lga_id'];
    gender = json['gender'];
    language = json['language']??'';
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['first_name'] = this.firstName;
    data['other_name'] = this.otherName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;

    data['state_id'] = this.stateID.toString();
    data['lga_id'] = this.lgaID.toString();
    data['gender'] = this.gender;
    data['language'] = '';

    return data;
  }
}
