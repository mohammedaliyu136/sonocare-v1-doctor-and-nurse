class VitalSignModel{
  String id = '';
  String patientID = '';
  String nurseID = '';
  String bloodGroup = '';
  String temperature = '';
  String pulseRate = '';
  String respiration = '';
  String sp02 = '';
  String bodyMass = '';
  String status = '';
  String createdAt = '';
  String updatedAt = '';
  VitalSignModel({
    required this.id,
    required this.patientID,
    required this.nurseID,
    required this.bloodGroup,
    required this.temperature,
    required this.pulseRate,
    required this.respiration,
    required this.sp02,
    required this.bodyMass,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });


  VitalSignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientID = json['patient_id'];
    nurseID = json['nurse_id']??'';
    bloodGroup = json['blood_group']??'';
    temperature = json['temprature']??'';
    pulseRate = json['pulse_rate']??'';
    respiration = json['respiration']??'';
    sp02 = json['sp02']??'';
    bodyMass = json['body_mass']??'';
    status = json['status']??'';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class PatientModel{
  String id = '';
  String firstName = '';
  String otherName = '';
  String lastName = '';
  String image = '';
  String email = '';
  String phoneNumber = '';

  String gender = '';
  String genoType = '';
  String bloodGroup = '';
  String dob = '';

  List<VitalSignModel> vitals = [];

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    otherName = json['other_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    phoneNumber = json['phone_number'];

    genoType = json['genotype'] ?? '';
    bloodGroup = json['blood_group'] ?? '';
    dob = json['dob'] ?? '';
    gender = json['gender'] ?? '';
  }
}