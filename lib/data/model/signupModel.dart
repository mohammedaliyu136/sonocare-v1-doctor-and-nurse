class SignUpModel {
  late String firstName;
  late String otherName;
  late String lastName;
  late String phoneNumber;
  late String email;
  late String address;
  late String password;
  late String doctorType;
  late String servicePreferences;

  SignUpModel({required this.firstName, required this.otherName, required this.lastName, required this.phoneNumber, required this.email, required this.address, required this.password, required this.doctorType, required this.servicePreferences});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    otherName = json['other_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['other_name'] = this.otherName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['email'] = this.email;
    data['password'] = this.password;
    data['doctor_type'] = this.doctorType;
    data['service_preferences'] = this.servicePreferences;
    return data;
  }
}
