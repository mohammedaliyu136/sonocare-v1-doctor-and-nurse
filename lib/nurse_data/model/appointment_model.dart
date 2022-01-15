class AppointmentModel{
  String id = '0';
  String consultationID = '';
  String patientID = '';
  String patientName = '';
  String doctorID = '';
  String image = '';
  String time = '';
  String day = '';
  String date = '';
  String appointmentDate = '';
  String status = '';
  String createdAT = '';
  String updatedAT = '';
  AppointmentModel(){}

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultationID = '';//json['consultation_id'];
    patientID = json['patient_id'];
    doctorID = json['patient_id'];
    patientName = json['first_name'];
    image = json['image'];

    time = json['time']??'';
    day = json['day']??'';
    appointmentDate = json['date']??'';
    status = json['status'];
    createdAT = json['created_at'];
    updatedAT = '';//json['updated_at'];
    /*
    consultationID = json['consultation_id'];
    patientID = json['patient_id'];
    doctorID = json['doctor_id'];

    time = json['time'];
    appointmentDate = json['date'];
    status = json['status'];
    createdAT = json['created_at'];
    updatedAT = json['updated_at'];
     */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['type'] = this.type;
    //data['consultation_fee'] = this.consultationFee.toString();
    return data;
  }

  getDate(){
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    DateTime datetime = DateTime.parse(this.createdAT);
    String date = '${datetime.day}, ${months[datetime.month]} ${datetime.year}';
    return date;
  }
  getTime(){
    DateTime datetime = DateTime.parse(this.createdAT);
    String time = '${datetime.hour>12?datetime.hour-12:datetime.hour}:${datetime.minute} ${datetime.hour>12?'pm':'am'}';
    return time;
  }

  setAppointmentDateTime(date, time, day){
    this.date=date;
    this.time=time;
    this.day=day;
  }
  getAppointmentDateTimeSTR(){
    List<String> docDay = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday","Sunday"];
    try{
      return '${docDay[int.parse(this.date)]} ${this.time} (${this.day})';
    }catch(e){
      return 'no date';
    }
  }
}

class AppointmentDetailModel{
  String id = '0';
  String consultationID = '';
  String patientID = '';
  String doctorID = '';
  String time = '';
  String day = '';
  String appointmentDate = '';
  String status = '';
  String createdAT = '';
  String updatedAT = '';
  AppointmentDetailModel(){}

  AppointmentDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultationID = '';//json['consultation_id'];
    patientID = '';//json['patient_id'];
    doctorID = json['doctor_id'];

    time = json['time'];
    day = json['day'];
    appointmentDate = json['date'];
    status = json['status'];
    createdAT = json['created_at'];
    updatedAT = '';//json['updated_at'];
    /*
    consultationID = json['consultation_id'];
    patientID = json['patient_id'];
    doctorID = json['doctor_id'];

    time = json['time'];
    appointmentDate = json['date'];
    status = json['status'];
    createdAT = json['created_at'];
    updatedAT = json['updated_at'];
     */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['type'] = this.type;
    //data['consultation_fee'] = this.consultationFee.toString();
    return data;
  }
}