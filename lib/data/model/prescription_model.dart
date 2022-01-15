class PrescriptionModel{
  String appointmentID = '';
  String patientName = '';
  String age = '';
  String gender = '';
  String dateOfConsultation = '';
  String diagnosis = '';
  String prescription = '';

  PrescriptionModel({
    required this.appointmentID,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.dateOfConsultation,
    required this.diagnosis,
    required this.prescription,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['appointment_id'] = this.appointmentID;
    data['first_name'] = this.patientName;
    data['age'] = this.age;
    data['sex'] = this.gender;
    data['date_consultation'] = this.dateOfConsultation;
    data['diagnosis'] = this.diagnosis;
    data['report'] = this.prescription;

    return data;
  }

}