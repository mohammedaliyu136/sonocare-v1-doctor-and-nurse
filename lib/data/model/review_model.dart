class ReviewModel{
  String id = '';
  String doctorID = '';
  String nurseID = '';
  String userID = '';
  String rating = '';
  String comment = '';
  String patientName = '';
  String createdAT = '';

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorID = json['doctor_id']??'';
    nurseID = json['nurse_id']??'';
    userID = json['userid'];
    rating = json['rating'];
    comment = json['comment'];
    patientName = json['patient_first_name']+' '+json['patient_last_name'];
    createdAT = json['created_at'].split(' ').join('\n');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}